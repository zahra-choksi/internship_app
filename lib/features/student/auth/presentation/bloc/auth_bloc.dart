// lib/features/auth/presentation/bloc/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_current_user.dart';
import '../../domain/usecase/sign_in_with_google.dart';
import '../../domain/usecase/sign_out.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogle signInWithGoogle;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;

  AuthBloc({
    required this.signInWithGoogle,
    required this.signOut,
    required this.getCurrentUser,
  }) : super(AuthInitial()) {
    on<SignInWithGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signInWithGoogle();
        emit(Authenticated(user));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignOutEvent>((event, emit) async {
      await signOut();
      emit(Unauthenticated());
    });

    on<CheckAuthStatusEvent>((event, emit) async {
      final user = await getCurrentUser();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    });
  }
}
