import 'package:app/domain/models/bookmark.dart';

class UpdateBookmarkRouteExtra {
  final Bookmark bookmark;
  final Function(Bookmark)? onUpdated;

  UpdateBookmarkRouteExtra({
    required this.bookmark,
    this.onUpdated,
  });
}
