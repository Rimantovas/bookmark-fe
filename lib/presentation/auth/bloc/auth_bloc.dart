import 'dart:ui';

import 'package:app/application/usecases/save_access_token.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(AuthState(isLoading: false));

  late final UserBloc _userBloc = GetIt.I<UserBloc>();

  late final Auth0 auth0 =
      Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
  late final Auth0Web auth0Web =
      Auth0Web(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);

  Future<void> signInWithGoogle({
    VoidCallback? onSuccess,
  }) async {
    emit(state.copyWith(isLoading: true));
    final credentials = await auth0
        .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
        // Use a Universal Link callback URL on iOS 17.4+ / macOS 14.4+
        // useHTTPS is ignored on Android
        .login(
          audience: 'https://bookmark.api.com',
          useHTTPS: false,
          redirectUrl: 'bookmarker://redirect',
        );

    final accessToken = credentials.accessToken;

    await SaveAccessToken().call(accessToken);

    await _userBloc.initUser();

    onSuccess?.call();

    emit(state.copyWith(isLoading: false));
  }

  Future<void> signInAsGuest() async {
    _userBloc.continueWithGuest();
  }
}

class AuthState {
  final bool isLoading;

  AuthState({required this.isLoading});

  AuthState copyWith({required bool isLoading}) =>
      AuthState(isLoading: isLoading);
}
