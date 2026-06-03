import 'package:assignment_abybaby/domain/Location/location_bloc.dart';
import 'package:assignment_abybaby/domain/Location/location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mappls_gl/mappls_gl.dart';
import '../../domain/Location/location_event.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() =>
      _LocationScreenState();
}

class _LocationScreenState
    extends State<LocationScreen> {
  MapplsMapController? _mapController;

  static const CameraPosition _fallbackCameraPosition = CameraPosition(
    target: LatLng(22.4856982, 88.3848309),
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    context.read<LocationBloc>().add(const GetDealerCurrentLocationEvent());
  }

  void _onMapCreated(MapplsMapController controller) {
    _mapController = controller;
  }

  Future<void> _moveCamera(double lat, double lng) async {
    if (_mapController == null) return;

    await _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dealer Current Location'),
        centerTitle: true,
      ),
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) async {
          if (state.isSuccess &&
              state.location.latitude != 0.0 &&
              state.location.longitude != 0.0) {
            await _moveCamera(
              state.location.latitude,
              state.location.longitude,
            );
          }
        },
        builder: (context, state) {
          final hasValidLocation = state.location.latitude != 0.0 &&
              state.location.longitude != 0.0;

          final currentCamera = hasValidLocation
              ? CameraPosition(
            target: LatLng(
              state.location.latitude,
              state.location.longitude,
            ),
            zoom: 16,
          )
              : _fallbackCameraPosition;

          return Stack(
            children: [
              MapplsMap(
                initialCameraPosition: currentCamera,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.tracking,
                myLocationRenderMode: MyLocationRenderMode.normal,
                onStyleLoadedCallback: () {},
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: state.isLoading
                      ? const Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text('Fetching current location...'),
                      ),
                    ],
                  )
                      : state.errorMessage.isNotEmpty
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Error',
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        state.errorMessage,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<LocationBloc>().add(
                              const RefreshDealerCurrentLocationEvent(),
                            );
                          },
                          child: const Text('Retry'),
                        ),
                      ),
                    ],
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Current Address',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.location.fullAddress.isEmpty
                            ? 'Address not available'
                            : state.location.fullAddress,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _InfoTile(
                              title: 'Latitude',
                              value: hasValidLocation
                                  ? state.location.latitude
                                  .toStringAsFixed(6)
                                  : '--',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _InfoTile(
                              title: 'Longitude',
                              value: hasValidLocation
                                  ? state.location.longitude
                                  .toStringAsFixed(6)
                                  : '--',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // context.read<LocationState>().add(
                            //   const RefreshDealerCurrentLocationEvent(),
                            // );
                          },
                          child: const Text('Refresh Location'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}