import 'dart:async';

import 'package:app/data/dto/search_pagination_dto.dart';
import 'package:app/data/repositories/bookmark_repository.dart';
import 'package:app/data/repositories/collections_repository.dart';
import 'package:app/data/repositories/user_repository.dart';
import 'package:app/domain/models/bookmark.dart';
import 'package:app/domain/models/collection.dart';
import 'package:app/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc() : super(SearchState.initial()) {
    _setupSearchListener();
  }

  Timer? _debounce;
  final _userRepository = GetIt.I<UserRepository>();
  final _collectionsRepository = GetIt.I<CollectionsRepository>();
  final _bookmarkRepository = GetIt.I<BookmarkRepository>();

  void _setupSearchListener() {
    state.queryController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        updateQuery(state.queryController.text);
      });
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    state.queryController.dispose();
    return super.close();
  }

  void updateQuery(String query) {
    if (query == state.query) return;
    emit(state.copyWith(query: query));

    if (query.length < 3) {
      emit(state.copyWith(
        bookmarks: [],
        collections: [],
        users: [],
        isLoading: false,
      ));
      return;
    }

    print('search');

    search();
  }

  void addQuery(String query) {
    emit(state.copyWith(query: query));
    state.queryController.text = query;
    updateQuery(query);
  }

  Future<void> search() async {
    if (state.query.length < 3) return;

    emit(state.copyWith(isLoading: true));

    try {
      final results = await Future.wait([
        _searchBookmarks(),
        _searchCollections(),
        _searchUsers(),
      ]);

      emit(state.copyWith(
        bookmarks: results[0] as List<Bookmark>,
        collections: results[1] as List<Collection>,
        users: results[2] as List<User>,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        bookmarks: [],
        collections: [],
        users: [],
        isLoading: false,
      ));
    }
  }

  Future<List<Bookmark>> _searchBookmarks() async {
    try {
      return await _bookmarkRepository.searchBookmarks(state.query);
    } catch (e) {
      return [];
    }
  }

  Future<List<Collection>> _searchCollections() async {
    try {
      return await _collectionsRepository.searchCollections(
        SearchPaginationDto(
          query: state.query,
          page: 1,
          limit: 10,
        ),
      );
    } catch (e) {
      return [];
    }
  }

  Future<List<User>> _searchUsers() async {
    try {
      final response = await _userRepository.searchUsers(
        SearchPaginationDto(
          query: state.query,
          page: 1,
          limit: 10,
        ),
      );
      return response.map((dto) => dto.toUser()).toList();
    } catch (e) {
      return [];
    }
  }

  void addToSearchHistory(String query) {
    if (query.isEmpty || state.searchHistory.contains(query)) return;

    emit(state.copyWith(
      searchHistory: [query, ...state.searchHistory],
    ));
  }

  void removeFromSearchHistory(String query) {
    emit(state.copyWith(
      searchHistory: state.searchHistory.where((q) => q != query).toList(),
    ));
  }

  void clearSearchHistory() {
    emit(state.copyWith(searchHistory: []));
  }
}

class SearchState {
  final String query;
  final TextEditingController queryController;
  final List<String> searchHistory;
  final List<Bookmark> bookmarks;
  final List<Collection> collections;
  final List<User> users;
  final bool isLoading;

  const SearchState({
    required this.query,
    required this.queryController,
    required this.searchHistory,
    required this.bookmarks,
    required this.collections,
    required this.users,
    required this.isLoading,
  });

  SearchState.initial()
      : this(
          query: '',
          queryController: TextEditingController(),
          searchHistory: [],
          bookmarks: [],
          collections: [],
          users: [],
          isLoading: false,
        );

  SearchState copyWith({
    String? query,
    TextEditingController? queryController,
    List<String>? searchHistory,
    List<Bookmark>? bookmarks,
    List<Collection>? collections,
    List<User>? users,
    bool? isLoading,
  }) {
    return SearchState(
      query: query ?? this.query,
      queryController: queryController ?? this.queryController,
      searchHistory: searchHistory ?? this.searchHistory,
      bookmarks: bookmarks ?? this.bookmarks,
      collections: collections ?? this.collections,
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
