import 'package:app/application/usecases/get_access_token.dart';
import 'package:app/data/repositories/collections_repository.dart';
import 'package:app/data/repositories/secure_storage_repository.dart';
import 'package:app/data/repositories/social_app_repository.dart';
import 'package:app/data/repositories/tag_repository.dart';
import 'package:app/data/repositories/user_repository.dart';
import 'package:app/domain/enums/user_role.dart';
import 'package:app/presentation/common/bloc/catalog_bloc.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:app/presentation/common/utils/colors.dart';
import 'package:app/presentation/common/utils/router.dart';
import 'package:app/presentation/common/utils/theme.dart';
import 'package:app/presentation/home/bloc/home_bloc.dart';
import 'package:app/presentation/tags/bloc/tags_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:forui/forui.dart';
import 'package:get_it/get_it.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'http://localhost:3000',
    connectTimeout: const Duration(seconds: 3),
  ),
);

final router = AppRouter();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    final getIt = GetIt.I;

    getIt.registerSingleton<SecureStorageRepository>(SecureStorageRepository());
    getIt.registerSingleton<UserRepository>(UserRepository());
    getIt.registerSingleton<SocialAppRepository>(SocialAppRepository());
    getIt.registerSingleton<CollectionsRepository>(CollectionsRepository());
    getIt.registerSingleton<TagRepository>(TagRepository());

    getIt.registerSingleton<UserBloc>(UserBloc());
    getIt.registerSingleton<HomeBloc>(HomeBloc());
    getIt.registerSingleton<CatalogBloc>(CatalogBloc());
    getIt.registerSingleton<TagsBloc>(TagsBloc());
    initUser();
  }

  Future<void> initUser() async {
    final accessToken = await GetAccessToken().call();
    if (accessToken != null) {
      print('access token: $accessToken');
      final response = await GetIt.I<UserBloc>().initUser();
      // if (response) {
      //   print('go to home');
      //   appRouter.go(HomeRoute());
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          bloc: GetIt.I<UserBloc>(),
          listener: (context, state) {
            if (state.user.role == UserRole.premium) {
              GetIt.I<TagsBloc>().getTags();
            }
            GetIt.I<CatalogBloc>().init();
          },
          listenWhen: (previous, current) {
            if (!previous.isLoggedIn && current.isLoggedIn) {
              return true;
            }
            return false;
          },
        ),
      ],
      child: MaterialApp.router(
        theme: AppTheme.themeData(),
        builder: (context, child) => FTheme(
          data: FThemes.zinc.light.copyWith(
            scaffoldStyle: FScaffoldStyle(
              contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              backgroundColor: AppColors().white,
              footerDecoration: const BoxDecoration(),
            ),
          ),
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => child!,
              ),
            ],
          ),
        ),
        routerConfig: router.router,
      ),
    );
  }
}
