import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:ogp_data_extract/ogp_data_extract.dart';

class UrlMetadata {
  final String? title;
  final String? description;
  final String? image;
  final String domain;

  UrlMetadata(
      {required this.title,
      required this.description,
      required this.image,
      required this.domain});
}

class UrlMetadataService {
  Future<UrlMetadata?> getMetadata(String url) async {
    String? title;
    String? description;
    String? image;
    String domain = 'https://${url.split('https://').last.split('/').first}';
    try {
      // First try social graph metadata
      final OgpData? ogpData = await OgpDataExtract.execute(url);

      if (ogpData != null) {
        title = ogpData.title;
        description = ogpData.description;
        image = ogpData.image;
      }

      // If social graph fails, try parsing HTML
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) return null;

      final document = parse(response.body);

      // Get title
      title ??= document.querySelector('title')?.text;
      // Get description
      description ??= document
          .querySelector('meta[name="description"]')
          ?.attributes['content'];

      // Get favicon
      image ??= document
          .querySelector('link[rel="icon"]')
          ?.attributes['href']
          ?.replaceAll('//', 'https://');

      return UrlMetadata(
        title: title,
        description: description,
        image: image,
        domain: domain,
      );
    } catch (e) {
      return null;
    }
  }
}
