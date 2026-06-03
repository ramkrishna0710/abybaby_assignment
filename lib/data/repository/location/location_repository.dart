import 'package:assignment_abybaby/data/model/location/current_location_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class LocationRepository {
  Future<bool> _handlePermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location service is disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permission permanently denied. Please enable it from app settings.',
      );
    }

    return true;
  }

  Future<CurrentLocationModel> getCurrentLocation() async {
    await _handlePermission();

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final placemark = placemarks.isNotEmpty ? placemarks.first : Placemark();

    final addressParts = [
      placemark.name,
      placemark.street,
      placemark.subLocality,
      placemark.locality,
      placemark.administrativeArea,
      placemark.postalCode,
      placemark.country,
    ].where((e) => e != null && e.toString().trim().isNotEmpty).map((e) => e!).toList();

    return CurrentLocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
      fullAddress: addressParts.join(', '),
      locality: placemark.locality ?? '',
      subLocality: placemark.subLocality ?? '',
      administrativeArea: placemark.administrativeArea ?? '',
      postalCode: placemark.postalCode ?? '',
      country: placemark.country ?? '',
    );
  }
}