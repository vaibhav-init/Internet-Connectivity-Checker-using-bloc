import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc1/blocs/internet_bloc/internet_event.dart';
import 'package:learning_bloc1/blocs/internet_bloc/internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;
  InternetBloc() : super(InternetInitialState()) {
    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        add(InternetGainedEvent());
      } else {
        add(InternetLostEvent());
      }
    });
  }
  @override
  Future<void> close() {
    // TODO: implement close
    connectivitySubscription?.cancel();
    return super.close();
  }
}
