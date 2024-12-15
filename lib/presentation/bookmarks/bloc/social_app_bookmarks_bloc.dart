import 'package:app/data/repositories/bookmark_repository.dart';
import 'package:app/data/repositories/social_app_repository.dart';
import 'package:app/domain/models/bookmark.dart';
import 'package:app/domain/models/social_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SocialAppBookmarksBloc extends Cubit<SocialAppBookmarksState> {
  SocialAppBookmarksBloc(String socialAppId)
      : _socialAppId = socialAppId,
        super(const SocialAppBookmarksState()) {
    init();
  }

  final String _socialAppId;
  final _socialAppRepository = GetIt.I<SocialAppRepository>();
  final _bookmarkRepository = GetIt.I<BookmarkRepository>();

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    final socialApp = await getSocialApp();
    final bookmarks = await getBookmarks();
    emit(state.copyWith(
      socialApp: socialApp,
      bookmarks: bookmarks,
      isLoading: false,
    ));
  }

  Future<List<Bookmark>> getBookmarks() async {
    try {
      final bookmarks =
          await _socialAppRepository.getSocialAppBookmarks(_socialAppId);
      return bookmarks;
    } catch (e) {
      return [];
    }
  }

  Future<SocialApp?> getSocialApp() async {
    try {
      final apps = await _socialAppRepository.getSocialApps();
      return apps.firstWhere((app) => app.id == _socialAppId);
    } catch (e) {
      return null;
    }
  }

  void updateBookmark(Bookmark bookmark) {
    final bookmarks = [...state.bookmarks];
    final index = bookmarks.indexWhere((b) => b.id == bookmark.id);
    if (index != -1) {
      bookmarks[index] = bookmark;
      emit(state.copyWith(bookmarks: bookmarks));
    }
  }

  void deleteBookmark(String id) {
    final oldBookmarks = [...state.bookmarks];

    // Optimistic update
    emit(state.copyWith(
      bookmarks: state.bookmarks.where((b) => b.id != id).toList(),
    ));

    try {
      _bookmarkRepository.deleteBookmark(id).catchError((_) {
        // Revert on error
        emit(state.copyWith(bookmarks: oldBookmarks));
      });
    } catch (e) {
      // Revert on error
      emit(state.copyWith(bookmarks: oldBookmarks));
    }
  }
}

class SocialAppBookmarksState {
  final List<Bookmark> bookmarks;
  final SocialApp? socialApp;
  final bool isLoading;

  const SocialAppBookmarksState({
    this.bookmarks = const [],
    this.socialApp,
    this.isLoading = false,
  });

  SocialAppBookmarksState copyWith({
    List<Bookmark>? bookmarks,
    SocialApp? socialApp,
    bool? isLoading,
  }) {
    return SocialAppBookmarksState(
      bookmarks: bookmarks ?? this.bookmarks,
      socialApp: socialApp ?? this.socialApp,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
