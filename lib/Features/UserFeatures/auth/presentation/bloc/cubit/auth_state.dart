part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthLoadedState extends AuthState {}

final class AuthLoginState extends AuthState {}

final class AuthAdminState extends AuthState {}

final class AuthRegisteredState extends AuthState {}

final class AuthErrorState extends AuthState {}
