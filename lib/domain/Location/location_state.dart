import 'package:assignment_abybaby/data/model/location/current_location_model.dart';
import 'package:equatable/equatable.dart';

class LocationState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final CurrentLocationModel location;

  const LocationState({
    required this.isLoading,
    required this.isSuccess,
    required this.errorMessage,
    required this.location,
  });

  factory LocationState.initial() {
    return LocationState(
      isLoading: false,
      isSuccess: false,
      errorMessage: '',
      location: CurrentLocationModel.empty(),
    );
  }

  LocationState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    CurrentLocationModel? location,
  }) {
    return LocationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage, location];
}