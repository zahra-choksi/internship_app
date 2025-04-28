import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigate to home
          }
          if (state is AuthError) {
            // Show error
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignInWithGoogleEvent());
              },
              child: Text('Sign in with Google'),
            ),
          );
        },
      ),
    );
  }
}
