part of 'admin_cubit.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

final class AdminLoadingState extends AdminState {}

final class AdminLoadedState extends AdminState {}
final class AdminUserCreatedState extends AdminState {}

final class AdminErrorState extends AdminState {}
