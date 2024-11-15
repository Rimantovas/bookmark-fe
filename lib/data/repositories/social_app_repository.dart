import 'package:app/domain/models/social_app.dart';
import 'package:app/main.dart';

class SocialAppRepository {
  static const String _kBasePath = '/social-apps';

  Future<List<SocialApp>> getSocialApps() async {
    final response = await dio.get(_kBasePath);

    final socialApps = (response.data as List<dynamic>)
        .map((e) => SocialAppMapper.fromMap(e))
        .toList();

    return socialApps;
  }
}
