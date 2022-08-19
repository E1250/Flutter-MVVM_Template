import 'dart:async';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInput with BaseViewModelOutputs{
  // shared variables and functions used through any view model.
  StreamController _inputStreamController= BehaviorSubject<FlowState>(); // to make multi listener


  @override
  void dispose() {
    // TODO: implement dispose
    _inputStreamController.close();
  }

  @override
  // TODO: implement inputState
  Sink get inputState => _inputStreamController.sink;


  @override
  // TODO: implement outputState
  Stream<FlowState> get outputState => _inputStreamController.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInput{
  void start(); // start view model job

  void dispose(); // will be called when view model dies

Sink get inputState;
}

abstract class BaseViewModelOutputs{
  // will be implemented later
  Stream<FlowState> get outputState;
}