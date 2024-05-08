import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:myk_market_app/data/repository/connectivity_observer.dart';

class NetworkConnectivityObserver implements ConnectivityObserver {
  final _connectivity = Connectivity();

  @override
  Stream<Status> observe() {
    return _connectivity.onConnectivityChanged.map((event) {
      switch (event) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.ethernet:
        case ConnectivityResult.mobile:
          return Status.available;

        default:
          return Status.unavailable;
      }
    });
  }
}
