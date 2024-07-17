import 'package:Birthday_Presents_List/domain/use_case/get_link_preview_use_case.dart';
import 'package:get_it/get_it.dart';

import '../data/repository/presents_list_repository_impl.dart';
import '../domain/repository/presents_list_repository.dart';
import '../domain/use_case/delete_presents_list_use_case.dart';
import '../domain/use_case/get_presents_list_use_case.dart';
import '../domain/use_case/load_presents_list_use_case.dart';
import '../domain/use_case/post_presents_list_use_case.dart';
import '../domain/use_case/save_presents_list_use_case.dart';
import '../domain/use_case/update_list_completed.dart';
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
    ..registerSingleton<DeletePresentsListUseCase>(DeletePresentsListUseCase())
    ..registerSingleton<GetLinkPreviewUseCase>(GetLinkPreviewUseCase())
    ..registerSingleton<UpdateListCompletedUseCase>(UpdateListCompletedUseCase(
      presentsListRepository: getIt<PresentsListRepository>(),
    ));

  // ViewModel
  getIt
    ..registerFactory<NavigationPageViewModel>(() => NavigationPageViewModel())
    ..registerFactory<PresentsListViewModel>(() => PresentsListViewModel(
        loadPresentsListUseCase: getIt<LoadPresentsListUseCase>(),
        deletePresentsListUseCase: getIt<DeletePresentsListUseCase>(),
        postPresentsListUseCase: getIt<PostPresentsListUseCase>(),
        getLinkPreviewUseCase: getIt<GetLinkPreviewUseCase>(),
        updateListCompletedUseCase: getIt<UpdateListCompletedUseCase>()))
    ..registerFactory<SearchPageViewModel>(() => SearchPageViewModel(
        savePresentsListUseCase: getIt<SavePresentsListUseCase>(),
        loadPresentsListUseCase: getIt<LoadPresentsListUseCase>()))
    ..registerFactory<ListForGuestPageViewModel>(() =>
        ListForGuestPageViewModel(
            getPresentsListUseCase: getIt<GetPresentsListUseCase>(),
            updatePresentsListUseCase: getIt<UpdatePresentsListUseCase>(),
            getLinkPreviewUseCase: getIt<GetLinkPreviewUseCase>()));
}
