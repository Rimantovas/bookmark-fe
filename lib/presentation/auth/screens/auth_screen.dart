import 'package:app/presentation/auth/bloc/auth_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/widgets/cta_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = FThemes.zinc.dark.colorScheme;
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return FTheme(
            data: FThemes.zinc.dark,
            child: ColoredBox(
              color: colors.background,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/auth_bg.png'),
                    fit: BoxFit.cover,
                    opacity: 0.2,
                  ),
                ),
                child: FScaffold(
                  resizeToAvoidBottomInset: false,
                  style: FScaffoldStyle(
                    backgroundColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    footerDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        child: FCard(
                          title: Text(
                            'Welcome to Bookmarker',
                            style: TextStyle(
                              color: colors.foreground,
                            ),
                          ),
                          subtitle: Text(
                            'Sign in or continue as guest',
                            style: TextStyle(
                              color: colors.foreground,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FButton(
                                  label: const Text('Sign in with Google'),
                                  onPress: () {
                                    context.read<AuthBloc>().signInWithGoogle();
                                  },
                                ),
                                8.heightBox,
                                FButton(
                                  label: const Text('Continue as Guest'),
                                  style: FButtonStyle.outline,
                                  onPress: () {
                                    context.read<AuthBloc>().signInAsGuest();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

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
