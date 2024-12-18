import 'package:app/domain/models/tag.dart';
import 'package:app/presentation/auth/screens/auth_screen.dart';
import 'package:app/presentation/bookmarks/models/update_bookmark_route_extra.dart';
import 'package:app/presentation/bookmarks/screens/collection_bookmarks_screen.dart';
import 'package:app/presentation/bookmarks/screens/create_bookmark_screen.dart';
import 'package:app/presentation/bookmarks/screens/social_app_bookmarks_screen.dart';
import 'package:app/presentation/bookmarks/screens/update_bookmark_screen.dart';
import 'package:app/presentation/collections/models/update_collection_route_extra.dart';
import 'package:app/presentation/collections/screens/create_collection_screen.dart';
import 'package:app/presentation/collections/screens/update_collection_screen.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:app/presentation/common/utils/router_listenable.dart';
import 'package:app/presentation/common/utils/routes.dart';
import 'package:app/presentation/home/screens/home_wrapper.dart';
import 'package:app/presentation/tags/screens/create_tag_screen.dart';
import 'package:app/presentation/tags/screens/update_tag_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    refreshListenable: GoRouterRefreshStream(
      GetIt.I<UserBloc>().authStatusStream,
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
        routes: [
          GoRoute(
            path: 'create_tag',
            name: 'create_tag',
            pageBuilder: (context, state) {
              return const CupertinoModalSheetPage(
                swipeDismissible: true,
                child: CreateTagScreen(),
              );
            },
          ),
          GoRoute(
            path: 'create_bookmark',
            name: 'create_bookmark',
            pageBuilder: (context, state) {
              return const CupertinoModalSheetPage(
                swipeDismissible: true,
                child: CreateBookmarkScreen(),
              );
            },
          ),
          GoRoute(
            path: 'collections/:id',
            name: 'collection_bookmarks',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return CollectionBookmarksScreen(collectionId: id);
            },
          ),
          GoRoute(
            path: 'update_tag',
            name: 'update_tag',
            pageBuilder: (context, state) {
              final tag = state.extra as Tag;
              return CupertinoModalSheetPage(
                swipeDismissible: true,
                child: UpdateTagScreen(tag: tag),
              );
            },
          ),
          GoRoute(
            path: 'update_bookmark',
            name: 'update_bookmark',
            pageBuilder: (context, state) {
              final extra = state.extra as UpdateBookmarkRouteExtra;
              return CupertinoModalSheetPage(
                swipeDismissible: true,
                child: UpdateBookmarkScreen(
                  bookmark: extra.bookmark,
                  onUpdated: extra.onUpdated,
                ),
              );
            },
          ),
          // ... in routes array ...
          GoRoute(
            path: 'create_collection',
            name: 'create_collection',
            pageBuilder: (context, state) {
              return const CupertinoModalSheetPage(
                swipeDismissible: true,
                child: CreateCollectionScreen(),
              );
            },
          ),
          GoRoute(
            path: 'update_collection',
            name: 'update_collection',
            pageBuilder: (context, state) {
              final extra = state.extra as UpdateCollectionRouteExtra;
              return CupertinoModalSheetPage(
                swipeDismissible: true,
                child: UpdateCollectionScreen(
                  collection: extra.collection,
                  onUpdated: extra.onUpdated,
                ),
              );
            },
          ),
          GoRoute(
            path: 'social-apps/:id',
            name: 'social_app_bookmarks',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return SocialAppBookmarksScreen(socialAppId: id);
            },
          ),
        ],
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

  void pop() {
    router.pop();
  }
}
