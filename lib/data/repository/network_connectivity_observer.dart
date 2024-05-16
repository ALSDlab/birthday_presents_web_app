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
          event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi ||
          event == ConnectivityResult.none
          ? Status.available
          : Status.unavailable;
    });
  }
}

    //   .map((event) {
    // //print('Connetivity changed2 : $event');
    // switch (event) {
    //
    //   case ConnectivityResult.wifi:
    //   case ConnectivityResult.ethernet:
    //   case ConnectivityResult.mobile:
    //     return Status.available;
    //
    //   default:
    //
    //     return Status.unavailable;
    // }
    //});


