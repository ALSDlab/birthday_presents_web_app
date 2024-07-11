import 'package:get_it/get_it.dart';

import '../data/repository/presents_list_repository_impl.dart';
import '../domain/repository/presents_list_repository.dart';
import '../domain/use_case/delete_presents_list_use_case.dart';
import '../domain/use_case/get_presents_list_use_case.dart';
import '../domain/use_case/load_presents_list_use_case.dart';
import '../domain/use_case/post_presents_list_use_case.dart';
import '../domain/use_case/save_presents_list_use_case.dart';
import '../domain/use_case/update_presents_list_use_case.dart';
import '../view/page/list_for_guest_page/list_for_guest_page_view_model.dart';
import '../view/page/navigation_page/navigation_page_view_model.dart';
import '../view/page/presents_list_page/presents_list_view_model.dart';
import '../view/page/search_page/search_page_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  // Repository
  getIt.registerSingleton<PresentsListRepository>(
    PresentsListRepositoryImpl(),
  );

  // use case
  getIt
    ..registerSingleton<GetPresentsListUseCase>(
      GetPresentsListUseCase(
        presentsListRepository: getIt<PresentsListRepository>(),
      ),
    )
    ..registerSingleton<PostPresentsListUseCase>(PostPresentsListUseCase(
      presentsListRepository: getIt<PresentsListRepository>(),
    ))
    ..registerSingleton<UpdatePresentsListUseCase>(UpdatePresentsListUseCase(
      presentsListRepository: getIt<PresentsListRepository>(),
    ))
    ..registerSingleton<LoadPresentsListUseCase>(LoadPresentsListUseCase())
    ..registerSingleton<SavePresentsListUseCase>(SavePresentsListUseCase())
    ..registerSingleton<DeletePresentsListUseCase>(DeletePresentsListUseCase());

  // ViewModel
  getIt
    ..registerFactory<NavigationPageViewModel>(() => NavigationPageViewModel())
    ..registerFactory<PresentsListViewModel>(() => PresentsListViewModel(
        loadPresentsListUseCase: getIt<LoadPresentsListUseCase>(),
        deletePresentsListUseCase: getIt<DeletePresentsListUseCase>(),
        postPresentsListUseCase: getIt<PostPresentsListUseCase>()))
    ..registerFactory<SearchPageViewModel>(() => SearchPageViewModel(
        savePresentsListUseCase: getIt<SavePresentsListUseCase>(),
        loadPresentsListUseCase: getIt<LoadPresentsListUseCase>()))
    ..registerFactory<ListForGuestPageViewModel>(() =>
        ListForGuestPageViewModel(
            getPresentsListUseCase: getIt<GetPresentsListUseCase>(),
            postPresentsListUseCase: getIt<PostPresentsListUseCase>(),
            updatePresentsListUseCase: getIt<UpdatePresentsListUseCase>()));
}
