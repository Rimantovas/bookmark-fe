import 'package:dart_mappable/dart_mappable.dart';

part 'social_app.mapper.dart';

@MappableClass(
  caseStyle: CaseStyle.snakeCase,
)
class SocialApp with SocialAppMappable {
  final String id;
  final String title;
  final String image;
  final String website;
  final String deeplink;

  SocialApp({
    required this.id,
    required this.title,
    required this.image,
    required this.website,
    required this.deeplink,
  });
}
