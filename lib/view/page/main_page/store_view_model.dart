import 'package:flutter/cupertino.dart';
import 'package:myk_market_app/data/model/store_model.dart';
import 'package:myk_market_app/data/repository/store_repository_impl.dart';
import 'package:myk_market_app/view/page/main_page/store_state.dart';

class StoreViewModel extends ChangeNotifier {
  StoreViewModel() {
    loadingHome();
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

  StoreRepositoryImpl repository = StoreRepositoryImpl();
  StoreState _state = StoreState();
  List<Store> storeList = [];

  StoreState get state => _state;

  Future<void> loadingHome() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    storeList = await repository.getFirebaseStore();

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }
}
