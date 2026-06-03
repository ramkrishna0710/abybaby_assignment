import 'package:assignment_abybaby/data/repository/location/location_repository.dart';
import 'package:assignment_abybaby/domain/Location/location_event.dart';
import 'package:assignment_abybaby/domain/Location/location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;

  LocationBloc({required this.locationRepository}) : super(LocationState.initial()) {
    on<GetDealerCurrentLocationEvent>(_getDealerCurrentLocation);
    on<RefreshDealerCurrentLocationEvent>(_refreshDealerCurrentLocation);
  }

  Future<void> _getDealerCurrentLocation(
      GetDealerCurrentLocationEvent event,
      Emitter<LocationState> emit,
      ) async {
    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
        errorMessage: '',
      ),
    );

    try {
      final result = await locationRepository.getCurrentLocation();

      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          errorMessage: '',
          location: result,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _refreshDealerCurrentLocation(
      RefreshDealerCurrentLocationEvent event,
      Emitter<LocationState> emit,
      ) async {
    try {
      final result = await locationRepository.getCurrentLocation();

      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          errorMessage: '',
          location: result,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}