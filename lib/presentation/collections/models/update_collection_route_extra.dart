import 'package:app/domain/models/collection.dart';

class UpdateCollectionRouteExtra {
  final Collection collection;
  final Function(Collection)? onUpdated;

  UpdateCollectionRouteExtra({
    required this.collection,
    this.onUpdated,
  });
}
