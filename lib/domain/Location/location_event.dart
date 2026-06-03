import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class GetDealerCurrentLocationEvent extends LocationEvent {
  const GetDealerCurrentLocationEvent();
}

class RefreshDealerCurrentLocationEvent extends LocationEvent {
  const RefreshDealerCurrentLocationEvent();
}