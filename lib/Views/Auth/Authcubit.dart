import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/Views/Auth/AuthStates.dart';

import 'package:meal_app/Views/Auth/Usermodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthCubit extends Cubit<AppAuthState> {
  AuthCubit() : super(AuthInitial()) {
    _checkAuthStatus();
  }

  final supabase = Supabase.instance.client;
  // final supabase = Supabase.instance.client;
  // Check if user is already logged in
  Future<void> _checkAuthStatus() async {
    try {
      final session = supabase.auth.currentSession;
      if (session != null) {
        final user = UserModel(
          id: session.user.id,
          email: session.user.email!,
          fullName: session.user.userMetadata?['full_name'],
          avatarUrl: session.user.userMetadata?['avatar_url'],
          createdAt: DateTime.parse(session.user.createdAt),
        );
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  // Sign Up with Email
  Future<void> signUp({
    required String email,
    required String password,
    String? fullName,
  }) async {
    try {
      emit(AuthLoading());

      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      if (response.user != null) {
        final user = UserModel(
          id: response.user!.id,
          email: response.user!.email!,
          fullName: fullName,
          avatarUrl: null,
          createdAt: DateTime.parse(response.user!.createdAt),
        );
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError('Sign up failed'));
      }
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError('An error occurred: $e'));
    }
  }

  // Sign In with Email
  Future<void> signIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());

      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final user = UserModel(
          id: response.user!.id,
          email: response.user!.email!,
          fullName: response.user!.userMetadata?['full_name'],
          avatarUrl: response.user!.userMetadata?['avatar_url'],
          createdAt: DateTime.parse(response.user!.createdAt),
        );
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError('Sign in failed'));
      }
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError('An error occurred: $e'));
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Sign out failed: $e'));
    }
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    try {
      emit(AuthLoading());
      await supabase.auth.resetPasswordForEmail(email);
      emit(AuthUnauthenticated());
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError('An error occurred: $e'));
    }
  }

  // Update Profile
  Future<void> updateProfile({String? fullName, String? avatarUrl}) async {
    try {
      final updates = <String, dynamic>{};
      if (fullName != null) updates['full_name'] = fullName;
      if (avatarUrl != null) updates['avatar_url'] = avatarUrl;

      await supabase.auth.updateUser(UserAttributes(data: updates));

      // Reload user
      await _checkAuthStatus();
    } catch (e) {
      emit(AuthError('Update failed: $e'));
    }
  }
}
