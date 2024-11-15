import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState(pageNr: 0));

  void changePage(int pageNr) {
    emit(HomeState(pageNr: pageNr));
  }
}

class HomeState {
  final int pageNr;

  HomeState({required this.pageNr});
}
