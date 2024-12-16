import 'package:app/domain/models/bookmark.dart';
import 'package:app/domain/models/collection.dart';
import 'package:app/domain/models/user.dart';
import 'package:app/main.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/utils/routes.dart';
import 'package:app/presentation/common/widgets/custom_placeholder.dart';
import 'package:app/presentation/common/widgets/keyboard_dismissable.dart';
import 'package:app/presentation/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: BlocSelector<SearchBloc, SearchState,
          (String, TextEditingController)>(
        selector: (state) {
          return (state.query, state.queryController);
        },
        builder: (context, state) {
          final (query, controller) = state;
          return KeyboardDismissable(
            child: FScaffold(
              resizeToAvoidBottomInset: false,
              header: const FHeader(
                title: Text('Search'),
              ),
              content: Column(
                children: [
                  FTextField(
                    controller: controller,
                    hint: 'Search...',
                  ),
                  Expanded(
                    child: _buildContent(
                      query,
                    ), // Replace with actual search query
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(String query) {
    if (query.length < 3) {
      return const _SearchHistory();
    }

    return const _SearchResults();
  }
}

class _SearchHistory extends StatelessWidget {
  const _SearchHistory();

  @override
  Widget build(BuildContext context) {
    // TODO: Get actual search history
    final searchHistory = ['flutter', 'dart', 'forui'];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: FTileGroup(
            children: searchHistory.map((query) {
              return FTile(
                prefixIcon: FIcon(FAssets.icons.clock),
                title: Text(query),
                suffixIcon: const Icon(Icons.close),
                onPress: () {
                  context.read<SearchBloc>().addQuery(query);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.bookmarks.isEmpty &&
            state.collections.isEmpty &&
            state.users.isEmpty) {
          return const Column(
            children: [
              Spacer(
                flex: 1,
              ),
              Center(
                child: CustomPlaceholder(
                  title: 'No results found',
                ),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              _BookmarksGroup(
                bookmarks: state.bookmarks,
              ),
              16.heightBox,
              _CollectionsGroup(
                collections: state.collections,
              ),
              16.heightBox,
              _UsersGroup(
                users: state.users,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BookmarksGroup extends StatelessWidget {
  const _BookmarksGroup({required this.bookmarks});

  final List<Bookmark> bookmarks;

  @override
  Widget build(BuildContext context) {
    if (bookmarks.isEmpty) return const SizedBox();

    return FTileGroup(
      label: Text('Bookmarks (${bookmarks.length})'),
      children: bookmarks.map((bookmark) {
        return FTile(
          prefixIcon: bookmark.imageUrl != null
              ? Image.network(bookmark.imageUrl!, width: 24, height: 24)
              : FIcon(FAssets.icons.link),
          title: Text(bookmark.title ?? bookmark.link),
          subtitle: bookmark.description != null
              ? Text(
                  bookmark.description!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : null,
          suffixIcon: FIcon(FAssets.icons.chevronRight),
          onPress: () {
            launchUrl(
              Uri.parse(bookmark.link),
              mode: LaunchMode.externalApplication,
            );
          },
        );
      }).toList(),
    );
  }
}

class _CollectionsGroup extends StatelessWidget {
  const _CollectionsGroup({required this.collections});

  final List<Collection> collections;

  @override
  Widget build(BuildContext context) {
    if (collections.isEmpty) return const SizedBox();

    return FTileGroup(
      label: Text('Collections (${collections.length})'),
      children: collections.map((collection) {
        return FTile(
          prefixIcon: FIcon(FAssets.icons.folder),
          title: Text(collection.title),
          suffixIcon: FIcon(FAssets.icons.chevronRight),
          onPress: () {
            router.push(CollectionBookmarksRoute(
              collectionId: collection.id,
            ));
          },
        );
      }).toList(),
    );
  }
}

class _UsersGroup extends StatelessWidget {
  const _UsersGroup({required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) return const SizedBox();

    return FTileGroup(
      label: Text('Users (${users.length})'),
      children: users.map((user) {
        return FTile(
          prefixIcon: FIcon(FAssets.icons.user),
          title: Text(user.name),
          subtitle: Text('@${user.username}'),
          suffixIcon: FIcon(FAssets.icons.chevronRight),
          onPress: () {
            // TODO: Navigate to user profile
          },
        );
      }).toList(),
    );
  }
}
