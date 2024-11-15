import 'package:app/presentation/auth/screens/auth_screen.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:app/presentation/common/utils/router_listenable.dart';
import 'package:app/presentation/common/utils/routes.dart';
import 'package:app/presentation/home/screens/home_wrapper.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    refreshListenable: GoRouterRefreshStream(
      GetIt.I<UserBloc>().stream,
    ),
    routes: [
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeWrapperScreen(),
      ),
    ],
    redirect: (context, state) {
      final userState = GetIt.I.get<UserBloc>().state;
      if (userState is UserInitial) {
        return '/auth';
      }
      if ((userState is UserSuccess || userState is UserGuest) &&
          state.fullPath == '/auth') {
        return '/';
      }

      return null;
    },
  );

  void go(AppRoute route, {Map<String, String>? params, Object? extra}) {
    router.goNamed(
      route.name,
      pathParameters: params ?? route.params,
      queryParameters: route.queryParams ?? {},
      extra: extra ?? route.extra,
    );
  }

  Future<T?> push<T>(AppRoute route) async {
    return router.pushNamed<T>(
      route.name,
      pathParameters: route.params,
      queryParameters: route.queryParams ?? {},
      extra: route.extra,
    );
  }
}
