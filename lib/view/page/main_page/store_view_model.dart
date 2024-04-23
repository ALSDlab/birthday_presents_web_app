import 'package:flutter/cupertino.dart';
import 'package:myk_market_app/data/repository/store_repository_impl.dart';
import 'package:myk_market_app/view/page/main_page/store_state.dart';

class StoreViewModel extends ChangeNotifier {
  StoreRepositoryImpl repository = StoreRepositoryImpl();
  StoreState _state = StoreState();

  StoreState get state => _state;

  void getStoreList() async {
    _state = state.copyWith(storeList: await repository.getFirebaseStore());
    print(state.storeList);
    notifyListeners();
  }

}