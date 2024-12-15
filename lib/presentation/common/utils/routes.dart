import 'package:app/domain/models/bookmark.dart';
import 'package:app/domain/models/collection.dart';
import 'package:app/domain/models/tag.dart';
import 'package:app/presentation/bookmarks/models/update_bookmark_route_extra.dart';
import 'package:app/presentation/collections/models/update_collection_route_extra.dart';

abstract class AppRoute {
  const AppRoute({
    required this.name,
    required this.path,
    required this.params,
    this.queryParams,
    this.extra,
  });

  final String name;
  final String path;
  final Map<String, String> params;
  final Map<String, String>? queryParams;
  final Object? extra;

  String get formPath {
    var pathWithParams = path;
    params.forEach((key, value) {
      pathWithParams = pathWithParams.replaceAll(':$key', value);
    });
    return pathWithParams;
  }
}

class AuthRoute extends AppRoute {
  AuthRoute() : super(name: 'auth', path: '/auth', params: {}, queryParams: {});
}

class HomeRoute extends AppRoute {
  HomeRoute() : super(name: 'home', path: '/', params: {}, queryParams: {});
}

class CreateTagRoute extends AppRoute {
  CreateTagRoute()
      : super(
            name: 'create_tag',
            path: '/create_tag',
            params: {},
            queryParams: {});
}

class CreateBookmarkRoute extends AppRoute {
  CreateBookmarkRoute()
      : super(
            name: 'create_bookmark',
            path: '/create_bookmark',
            params: {},
            queryParams: {});
}

class CollectionBookmarksRoute extends AppRoute {
  CollectionBookmarksRoute({required String collectionId})
      : super(
          name: 'collection_bookmarks',
          path: '/collections/:id',
          params: {'id': collectionId},
        );
}

class UpdateTagRoute extends AppRoute {
  UpdateTagRoute({required Tag tag})
      : super(
          name: 'update_tag',
          path: '/update_tag',
          params: {},
          extra: tag,
        );
}

class UpdateBookmarkRoute extends AppRoute {
  UpdateBookmarkRoute({
    required Bookmark bookmark,
    Function(Bookmark)? onUpdated,
  }) : super(
          name: 'update_bookmark',
          path: '/update_bookmark',
          params: {},
          extra: UpdateBookmarkRouteExtra(
            bookmark: bookmark,
            onUpdated: onUpdated,
          ),
        );
}

// ... existing routes ...

class CreateCollectionRoute extends AppRoute {
  CreateCollectionRoute()
      : super(
          name: 'create_collection',
          path: '/create_collection',
          params: {},
        );
}

class UpdateCollectionRoute extends AppRoute {
  UpdateCollectionRoute({
    required Collection collection,
    Function(Collection)? onUpdated,
  }) : super(
          name: 'update_collection',
          path: '/update_collection',
          params: {},
          extra: UpdateCollectionRouteExtra(
            collection: collection,
            onUpdated: onUpdated,
          ),
        );
}

class SocialAppBookmarksRoute extends AppRoute {
  SocialAppBookmarksRoute({required String socialAppId})
      : super(
          name: 'social_app_bookmarks',
          path: '/social-apps/:id',
          params: {'id': socialAppId},
        );
}
