import 'package:app/data/repositories/secure_storage_repository.dart';
import 'package:app/main.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class GetAccessToken {
  Future<String?> call() async {
    final accessToken =
        await GetIt.I<SecureStorageRepository>().getAccessToken();

    if (accessToken != null) {
      print('add interceptor');
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            options.headers['Authorization'] = 'Bearer $accessToken';
            return handler.next(options);
          },
        ),
      );
    }
    return accessToken;
  }
}
