import 'package:app/domain/models/collection.dart';
import 'package:app/domain/models/social_app.dart';
import 'package:app/presentation/common/bloc/catalog_bloc.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/home/widgets/collection_grid.dart';
import 'package:app/presentation/home/widgets/social_app_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Home'),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BlocSelector<CatalogBloc, CatalogState, List<SocialApp>>(
              bloc: GetIt.I<CatalogBloc>(),
              selector: (state) {
                return state.socialApps;
              },
              builder: (context, socialApps) {
                return SocialAppGrid(socialApps: socialApps);
              },
            ),
            24.heightBox,
            BlocSelector<UserBloc, UserState, List<Collection>>(
              bloc: GetIt.I<UserBloc>(),
              selector: (state) {
                return state.collections;
              },
              builder: (context, collections) {
                return CollectionGrid(collections: collections);
              },
            ),
          ],
        ),
      ),
    );
  }
}
