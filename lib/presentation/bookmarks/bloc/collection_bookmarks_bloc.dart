import 'package:app/data/repositories/collections_repository.dart';
import 'package:app/domain/models/bookmark.dart';
import 'package:app/domain/models/collection.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CollectionBookmarksBloc extends Cubit<CollectionBookmarksState> {
  CollectionBookmarksBloc(String collectionId)
      : _collectionId = collectionId,
        super(const CollectionBookmarksState()) {
    init();
  }

  final String _collectionId;
  final _collectionsRepository = GetIt.I<CollectionsRepository>();
  final _userBloc = GetIt.I<UserBloc>();

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    final collection = await getCollection();
    final bookmarks = await getBookmarks();
    emit(state.copyWith(
      collection: collection,
      bookmarks: bookmarks,
      isLoading: false,
    ));
  }

  Future<List<Bookmark>> getBookmarks() async {
    try {
      final bookmarks =
          await _collectionsRepository.getCollectionBookmarks(_collectionId);
      return bookmarks;
    } catch (e) {
      return [];
    }
  }

  Future<Collection?> getCollection() async {
    try {
      // Try to find in user's collections first
      final userCollection =
          _userBloc.state.collections.firstWhere((c) => c.id == _collectionId);
      return userCollection;
    } catch (_) {
      try {
        // If not found, fetch from repository
        final collection =
            await _collectionsRepository.getCollection(_collectionId);
        return collection;
      } catch (e) {
        return null;
      }
    }
  }
}

class CollectionBookmarksState {
  final List<Bookmark> bookmarks;
  final Collection? collection;
  final bool isLoading;

  const CollectionBookmarksState({
    this.bookmarks = const [],
    this.collection,
    this.isLoading = false,
  });

  CollectionBookmarksState copyWith({
    List<Bookmark>? bookmarks,
    Collection? collection,
    bool? isLoading,
  }) {
    return CollectionBookmarksState(
      bookmarks: bookmarks ?? this.bookmarks,
      collection: collection ?? this.collection,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
