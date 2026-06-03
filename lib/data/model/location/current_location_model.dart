class CurrentLocationModel {
  final double latitude;
  final double longitude;
  final String fullAddress;
  final String locality;
  final String subLocality;
  final String administrativeArea;
  final String postalCode;
  final String country;

  const CurrentLocationModel({
    required this.latitude,
    required this.longitude,
    required this.fullAddress,
    required this.locality,
    required this.subLocality,
    required this.administrativeArea,
    required this.postalCode,
    required this.country,
  });

  factory CurrentLocationModel.empty() {
    return const CurrentLocationModel(
      latitude: 0.0,
      longitude: 0.0,
      fullAddress: '',
      locality: '',
      subLocality: '',
      administrativeArea: '',
      postalCode: '',
      country: '',
    );
  }

  CurrentLocationModel copyWith({
    double? latitude,
    double? longitude,
    String? fullAddress,
    String? locality,
    String? subLocality,
    String? administrativeArea,
    String? postalCode,
    String? country,
  }) {
    return CurrentLocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      fullAddress: fullAddress ?? this.fullAddress,
      locality: locality ?? this.locality,
      subLocality: subLocality ?? this.subLocality,
      administrativeArea: administrativeArea ?? this.administrativeArea,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
    );
  }
}