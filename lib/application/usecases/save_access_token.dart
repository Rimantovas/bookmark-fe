import 'package:app/data/repositories/secure_storage_repository.dart';
import 'package:app/main.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class SaveAccessToken {
  Future<void> call(String accessToken) async {
    await GetIt.I<SecureStorageRepository>().saveAccessToken(accessToken);

    dio.interceptors.removeWhere((element) => element is InterceptorsWrapper);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer $accessToken';
          return handler.next(options);
        },
      ),
    );
  }
}
