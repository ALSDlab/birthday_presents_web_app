import 'package:Birthday_Presents_List/domain/use_case/delete_presents_list_use_case.dart';
import 'package:Birthday_Presents_List/view/page/presents_list_page/presents_list_state.dart';
import 'package:flutter/material.dart';

import '../../../data/core/result.dart';
import '../../../domain/use_case/load_presents_list_use_case.dart';
import '../../../domain/use_case/save_presents_list_use_case.dart';
import '../../../utils/simple_logger.dart';

class PresentsListViewModel extends ChangeNotifier {
  final SavePresentsListUseCase _savePresentsListUseCase;
  final LoadPresentsListUseCase _loadPresentsListUseCase;
  final DeletePresentsListUseCase _deletePresentsListUseCase;

  PresentsListState _state = const PresentsListState();

  PresentsListState get state => _state;

  PresentsListViewModel(
      {required SavePresentsListUseCase savePresentsListUseCase,
      required LoadPresentsListUseCase loadPresentsListUseCase,
      required DeletePresentsListUseCase deletePresentsListUseCase})
      : _savePresentsListUseCase = savePresentsListUseCase,
        _loadPresentsListUseCase = loadPresentsListUseCase,
        _deletePresentsListUseCase = deletePresentsListUseCase;

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
    try {
      await getSavedPresentsList();
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
  Future<void> getSavedPresentsList() async {
    final result = await _loadPresentsListUseCase.execute();
    switch (result) {
      case Success<Map<String, List<Map<String, dynamic>>>>():
        _state = state.copyWith(loadedDocId: result.data.keys.first);
        _state = state.copyWith(linksList: result.data.values.first);
        notifyListeners();
        break;
      case Error<Map<String, List<Map<String, dynamic>>>>():
        logger.info(result.message);
        notifyListeners();
        break;
    }
  }

  // 스낵바 구현 매서드
  void listAddSnackBar(BuildContext context) {
    _state = state.copyWith(showSnackbarPadding: true);
    notifyListeners();

    final snackBar = SnackBar(
      content:
          const Text('Deleted the Link.', style: TextStyle(fontFamily: 'Jalnan')),
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

// 리스트에서 제거하는 기능
Future<void> removeFromPresentsList(Map<String, dynamic> item, BuildContext context) async {
  final result = await _deletePresentsListUseCase.execute(item);
  switch (result) {
    case Success<void>():
    // 스낵바로 표시
      if (context.mounted) {
        listAddSnackBar(context);
      }
      notifyListeners();
      break;
    case Error<void>():
      logger.info(result.message);
      notifyListeners();
      break;
  }
  notifyListeners();
}

//TODO: 파이어베이스 POST 기능 작성
}
