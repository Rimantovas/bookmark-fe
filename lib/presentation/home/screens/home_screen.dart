import 'package:app/domain/models/collection.dart';
import 'package:app/domain/models/social_app.dart';
import 'package:app/main.dart';
import 'package:app/presentation/common/bloc/catalog_bloc.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/utils/routes.dart';
import 'package:app/presentation/common/utils/sheet_utils.dart';
import 'package:app/presentation/common/widgets/custom_placeholder.dart';
import 'package:app/presentation/home/widgets/collection_card.dart';
import 'package:app/presentation/home/widgets/social_app_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      resizeToAvoidBottomInset: false,
      header: const FHeader(
        title: Text('Home'),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocSelector<CatalogBloc, CatalogState, List<SocialApp>>(
              bloc: GetIt.I<CatalogBloc>(),
              selector: (state) => state.socialApps,
              builder: (context, socialApps) {
                return SocialAppGrid(
                  socialApps: socialApps,
                  onTap: (app) {
                    final isGuest = GetIt.I<UserBloc>().state.isGuest;
                    if (isGuest) {
                      showAuthSheet(context, feature: 'view bookmarks');
                    } else {
                      router.push(SocialAppBookmarksRoute(
                        socialAppId: app.id,
                      ));
                    }
                  },
                );
              },
            ),
            24.heightBox,
            BlocSelector<UserBloc, UserState, List<Collection>>(
              bloc: GetIt.I<UserBloc>(),
              selector: (state) => state.collections,
              builder: (context, collections) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Collections',
                      style: context.styles.button1,
                    ),
                    8.heightBox,
                    if (collections.isEmpty)
                      Center(
                        child: CustomPlaceholder(
                          title: 'No collections yet',
                          action: SizedBox(
                            width: 180,
                            child: FButton(
                              onPress: () {
                                final isGuest =
                                    GetIt.I<UserBloc>().state.isGuest;
                                if (isGuest) {
                                  showAuthSheet(
                                    context,
                                    feature: 'create collections',
                                  );
                                } else {
                                  router.push(CreateCollectionRoute());
                                }
                              },
                              label: const Text('Create first one'),
                            ),
                          ),
                        ),
                      )
                    else ...[
                      ...collections.map(
                        (collection) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CollectionCard(
                            collection: collection,
                            onTap: () {
                              router.push(CollectionBookmarksRoute(
                                collectionId: collection.id,
                              ));
                            },
                          ),
                        ),
                      ),
                      FButton(
                        onPress: () {
                          router.push(CreateCollectionRoute());
                        },
                        style: FButtonStyle.outline,
                        label: const Text('Create new collection'),
                      ),
                    ],
                    24.heightBox,
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
