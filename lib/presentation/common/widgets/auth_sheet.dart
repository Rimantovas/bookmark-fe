import 'package:app/presentation/auth/bloc/auth_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class AuthSheet extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onSignInPressed;

  const AuthSheet({
    super.key,
    required this.title,
    required this.description,
    required this.onSignInPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.colors.background,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              border: Border(
                top: BorderSide(color: context.colors.border),
              ),
            ),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _TopGraphic(),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: context.theme.typography.xl2.copyWith(
                              fontWeight: FontWeight.w600,
                              color: context.colors.foreground,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description,
                            style: context.theme.typography.sm.copyWith(
                              color: context.colors.mutedForeground,
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: FButton(
                              onPress: () {
                                context.read<AuthBloc>().signInWithGoogle(
                                  onSuccess: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                              label: const Text('Sign in with Google'),
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _TopGraphic extends StatelessWidget {
  const _TopGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 0.9, 1],
            colors: [
              Colors.black26,
              Colors.white70,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: context.colors.background,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ),
    );
    // return Container(
    //   height: 100,
    //   decoration: const BoxDecoration(
    //     gradient: LinearGradient(
    //       begin: Alignment.topCenter,
    //       end: Alignment.bottomCenter,
    //       stops: [0, 1],
    //       colors: [
    //         Colors.black,
    //         Colors.white,
    //       ],
    //     ),
    //   ),
    //   child: Stack(
    //     children: [
    //       Positioned(
    //         top: 20,
    //         left: 10,
    //         child: _getImage(1, context: context, size: 50),
    //       ),
    //       Positioned(
    //         bottom: 10,
    //         right: 20,
    //         child: _getImage(2, context: context, size: 70),
    //       ),
    //       Positioned(
    //         bottom: 10,
    //         left: 70,
    //         child: _getImage(7, context: context, size: 50),
    //       ),
    //       Positioned(
    //         bottom: 5,
    //         right: 90,
    //         child: _getImage(8, context: context, size: 30),
    //       ),
    //       Positioned(
    //         top: 10,
    //         left: 10,
    //         right: 10,
    //         child: _getImage(9, context: context, size: 80),
    //       ),
    //     ],
    //   ),
    // );
  }
}
