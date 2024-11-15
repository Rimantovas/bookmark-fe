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
