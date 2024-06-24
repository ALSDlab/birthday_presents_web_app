import 'package:connectivity_plus/connectivity_plus.dart';

import 'connectivity_observer.dart';

class NetworkConnectivityObserver implements ConnectivityObserver {
  final _connectivity = Connectivity();

  @override
  Stream<Status> observe() {
    return _connectivity.onConnectivityChanged.map((event) {
      var connectivityResult = event.first; //첫번째 요소만 가져옴

      switch (connectivityResult) {
        case ConnectivityResult.wifi:
          return Status.available;
        case ConnectivityResult.mobile:
          return Status.available;
        case ConnectivityResult.none:
          return Status.unavailable;
        default:
          return Status.available;
      }
    });
  }
}
