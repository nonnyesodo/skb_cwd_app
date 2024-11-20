part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedState extends HomeState {}

final class HomeCreatedShipmentState extends HomeState {}

final class ShipmentcanceledState extends HomeState {}

final class ShipmentConfirmedState extends HomeState {}

final class HomeErrorState extends HomeState {}
