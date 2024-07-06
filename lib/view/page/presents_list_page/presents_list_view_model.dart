import 'package:Birthday_Presents_List/domain/model/presents_list_model.dart';
import 'package:Birthday_Presents_List/domain/use_case/delete_presents_list_use_case.dart';
import 'package:Birthday_Presents_List/domain/use_case/post_presents_list_use_case.dart';
import 'package:Birthday_Presents_List/view/page/presents_list_page/presents_list_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../data/core/result.dart';
import '../../../domain/use_case/load_presents_list_use_case.dart';
import '../../../utils/simple_logger.dart';

class PresentsListViewModel extends ChangeNotifier {
  final LoadPresentsListUseCase _loadPresentsListUseCase;
  final DeletePresentsListUseCase _deletePresentsListUseCase;
  final PostPresentsListUseCase _postPresentsListUseCase;

  PresentsListState _state = const PresentsListState();

  PresentsListState get state => _state;

  PresentsListViewModel(
      {required LoadPresentsListUseCase loadPresentsListUseCase,
      required DeletePresentsListUseCase deletePresentsListUseCase,
      required PostPresentsListUseCase postPresentsListUseCase})
      : _loadPresentsListUseCase = loadPresentsListUseCase,
        _deletePresentsListUseCase = deletePresentsListUseCase,
        _postPresentsListUseCase = postPresentsListUseCase;

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

  // 선물리스트 서버에 존재여부 확인
  Future<bool> checkListExists(String docId) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('presentsList')
        .doc(docId)
        .get();
    return docSnapshot.exists;
  }

  // 선물리스트 불러오는 기능
  Future<void> getSavedPresentsList() async {
    final result = await _loadPresentsListUseCase.execute();
    switch (result) {
      case Success<Map<String, List<Map<String, dynamic>>>>():
        _state = state.copyWith(loadedDocId: result.data.keys.first);
        _state = state.copyWith(linksList: result.data.values.first);
        _state = state.copyWith(
            isCompleted: await checkListExists(result.data.keys.first));
        notifyListeners();
        break;
      case Error<Map<String, List<Map<String, dynamic>>>>():
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

// 리스트에서 제거하는 기능
  Future<void> removeFromPresentsList(
      Map<String, dynamic> item, BuildContext context) async {
    final result = await _deletePresentsListUseCase.execute(item);
    switch (result) {
      case Success<void>():
        // 스낵바로 표시
        if (context.mounted) {
          listAddSnackBar('Deleted the Link.', context);
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

  Future<void> postAndMakeListLink(
      String listDocId, PresentsListModel myList, BuildContext context) async {
    _state = state.copyWith(isPosting: true);
    notifyListeners();
    final result = await _postPresentsListUseCase.execute(
        myListDocId: listDocId, myList: myList);
    if (result is Success<void>) {
      // 스낵바로 표시
      if (context.mounted) {
        listAddSnackBar('The link has been copied to your clipboard', context);
      }
      _state = state.copyWith(isCompleted: true);
      notifyListeners();
    } else if (result is Error) {
      logger.info(result.message);
      notifyListeners();
    }
    _state = state.copyWith(isPosting: false);
    notifyListeners();
  }
}
