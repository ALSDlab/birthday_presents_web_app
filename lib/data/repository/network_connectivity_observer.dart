import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:myk_market_app/data/repository/connectivity_observer.dart';

class NetworkConnectivityObserver implements ConnectivityObserver {
  final _connectivity = Connectivity();

  @override
  Stream<Status> observe() {
    return _connectivity.onConnectivityChanged.map((event) {
      print('Connetivity changed : $event');
      var connectivityResult = event.first; //첫번째 요소만 가져옴

      return connectivityResult == ConnectivityResult.ethernet ||
              connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi
          ? Status.available
          : Status.unavailable;
    });
  }
}
