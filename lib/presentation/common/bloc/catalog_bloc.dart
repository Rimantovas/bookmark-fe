import 'package:app/data/repositories/social_app_repository.dart';
import 'package:app/domain/models/social_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CatalogBloc extends Cubit<CatalogState> {
  CatalogBloc() : super(CatalogState(socialApps: []));

  late final SocialAppRepository _socialAppRepository =
      GetIt.I<SocialAppRepository>();

  Future<void> init() async {
    final response = await _socialAppRepository.getSocialApps();
    emit(CatalogState(socialApps: response));
  }
}

class CatalogState {
  final List<SocialApp> socialApps;

  CatalogState({required this.socialApps});
}
