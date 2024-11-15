import 'package:app/domain/models/user.dart';
import 'package:app/main.dart';

class UserRepository {
  static const _kBasePath = '/auth';
  static const _kLoginPath = '$_kBasePath/login';

  Future<User> login() async {
    final response = await dio.post(_kLoginPath);

    return UserMapper.fromMap(response.data);
  }
}
