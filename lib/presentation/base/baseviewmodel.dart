import 'dart:async';

import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel
    implements BaseViewModelInputs, BaseViewModelOutputs {
  final StreamController<FlowState> _inputStateController =
      StreamController<FlowState>.broadcast();

  @override
  void dispose() => _inputStateController.close();

  @override
  Stream<FlowState> get outputStateStream =>
      _inputStateController.stream.map((flowState) => flowState);

  @override
  Sink get inputState => _inputStateController.sink;
}

abstract class BaseViewModelInputs {
  void start();

  void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputStateStream;
}
