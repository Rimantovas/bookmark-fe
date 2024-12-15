import 'package:app/data/repositories/secure_storage_repository.dart';
import 'package:app/main.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class RemoveAccessToken {
  Future<void> call() async {
    await GetIt.I<SecureStorageRepository>().deleteAccessToken();

    dio.interceptors.removeWhere((element) => element is InterceptorsWrapper);

    GetIt.I<UserBloc>().logout();
  }
}
