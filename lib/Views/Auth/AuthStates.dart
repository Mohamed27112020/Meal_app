import 'package:meal_app/Views/Auth/Usermodel.dart';

abstract class AppAuthState {}

class AuthInitial extends AppAuthState {}

class AuthLoading extends AppAuthState {}

class AuthAuthenticated extends AppAuthState {
  final UserModel user;
  AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AppAuthState {}

class AuthError extends AppAuthState {
  final String message;
  AuthError(this.message);
}
