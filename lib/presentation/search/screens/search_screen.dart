import 'package:app/domain/enums/user_role.dart';
import 'package:app/domain/models/bookmark.dart';
import 'package:app/domain/models/collection.dart';
import 'package:app/domain/models/user.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: const FHeader(
        title: Text('Search'),
      ),
      content: Column(
        children: [
          const FTextField(
            hint: 'Search...',
          ),
          Expanded(
            child: _buildContent('test'), // Replace with actual search query
          ),
        ],
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

    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: FTileGroup(
        children: searchHistory.map((query) {
          return FTile(
            prefixIcon: FIcon(FAssets.icons.clock),
            title: Text(query),
            suffixIcon: const Icon(Icons.close),
            onPress: () {
              // TODO: Use this search query
            },
          );
        }).toList(),
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          _BookmarksGroup(
            bookmarks: List.generate(
              3,
              (i) => Bookmark(
                id: '$i',
                link: 'https://example.com',
                collectionId: '1',
                userId: '1',
                tags: const [],
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            ),
          ),
          16.heightBox,
          _CollectionsGroup(
            collections: List.generate(
              2,
              (i) => Collection.mock(),
            ),
          ),
          16.heightBox,
          _UsersGroup(
            users: List.generate(
              2,
              (i) => User(
                id: '$i',
                name: 'User $i',
                username: 'user$i',
                email: 'user$i@example.com',
                role: UserRole.regular,
              ),
            ),
          ),
        ],
      ),
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
            // TODO: Navigate to bookmark
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
            // TODO: Navigate to collection
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
