import 'package:Birthday_Presents_List/domain/model/presents_list_model.dart';
import 'package:Birthday_Presents_List/domain/use_case/get_presents_list_use_case.dart';
import 'package:Birthday_Presents_List/domain/use_case/post_presents_list_use_case.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../data/core/result.dart';
import '../../../utils/simple_logger.dart';
import 'list_for_guest_page_state.dart';

class ListForGuestPageViewModel extends ChangeNotifier {
  final GetPresentsListUseCase _getPresentsListUseCase;
  final PostPresentsListUseCase _postPresentsListUseCase;

  ListForGuestPageState _state = const ListForGuestPageState();

  ListForGuestPageState get state => _state;

  ListForGuestPageViewModel(
      {required GetPresentsListUseCase getPresentsListUseCase,
      required PostPresentsListUseCase postPresentsListUseCase})
      : _getPresentsListUseCase = getPresentsListUseCase,
        _postPresentsListUseCase = postPresentsListUseCase {
    getBadgeCount();
  }

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  Future<int> getBadgeCount() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
    try {
      await getPresentsList(
          Uri.base.toString().substring(Uri.base.toString().length - 15));
      notifyListeners();
      return _state.linksList.length;
    } catch (error) {
      // 에러 처리
      logger.info('Error get badge: $error');

      return 0;
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  // 선물리스트 불러오는 기능
  Future<void> getPresentsList(String docId) async {
    final result = await _getPresentsListUseCase.execute(docId);
    switch (result) {
      case Success<PresentsListModel>():
        _state = state.copyWith(getName: result.data.name);
        _state = state.copyWith(getBirthYear: result.data.birthYear);
        _state = state.copyWith(linksList: result.data.links);
        notifyListeners();
        break;
      case Error():
        logger.info(result.message);
        notifyListeners();
        break;
    }
  }

  // 스낵바 구현 매서드
  void listAddSnackBar(String comment, BuildContext context) {
    _state = state.copyWith(showSnackbarPadding: true);
    notifyListeners();

    final snackBar = SnackBar(
      content: Text(comment, style: const TextStyle(fontFamily: 'Jalnan')),
      duration: const Duration(seconds: 2),
      onVisible: () {
        // snackbar가 사라질 때 패딩을 제거합니다.
        Future.delayed(const Duration(milliseconds: 2200), () {
          _state = state.copyWith(showSnackbarPadding: false);
          notifyListeners();
        });
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> postAndMakeListLink(
      String listDocId, PresentsListModel myList, BuildContext context) async {
    final result = await _postPresentsListUseCase.execute(
        myListDocId: listDocId, myList: myList);
    switch (result) {
      case Success<void>():
        // 스낵바로 표시
        if (context.mounted) {
          listAddSnackBar('Made the link for list', context);
          _state = state.copyWith(isCompleted: true);
        }
        notifyListeners();
        break;
      case Error<Map<String, List<Map<String, dynamic>>>>():
        logger.info(result.message);
        notifyListeners();
        break;
    }
  }
}
