import 'package:app/presentation/auth/bloc/auth_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/widgets/cta_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to Bookmarker',
                    style: context.styles.h3,
                  ),
                  24.heightBox,
                  CTAButton(
                    text: 'Sign in with Google',
                    onPressed: () {
                      context.read<AuthBloc>().signInWithGoogle();
                    },
                  ),
                  8.heightBox,
                  CTAButton(
                    text: 'Continue as Guest',
                    onPressed: () {
                      context.read<AuthBloc>().signInAsGuest();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
