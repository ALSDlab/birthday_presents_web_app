import 'package:flutter/cupertino.dart';
import 'package:myk_market_app/data/model/store_model.dart';
import 'package:myk_market_app/data/repository/store_repository_impl.dart';
import 'package:myk_market_app/view/page/main_page/store_state.dart';

class StoreViewModel extends ChangeNotifier {

  StoreViewModel(){
    loadingHome();
  }

  StoreRepositoryImpl repository = StoreRepositoryImpl();
  final StoreState _state = StoreState();
  List<Store> storeList = [];

  StoreState get state => _state;

  bool _isLoading = false;

  bool get isLoading => _isLoading;



  Future<void> loadingHome() async {
    _isLoading = true;
    notifyListeners();

    storeList = await repository.getFirebaseStore();

    _isLoading = false;
    notifyListeners();
  }


}
