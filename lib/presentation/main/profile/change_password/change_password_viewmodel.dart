import 'dart:async';
import 'package:elevator/app/functions.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';

class ChangePasswordViewmodel extends BaseViewModel
    implements ChangePasswordViewmodelInputs, ChangePasswordViewmodelOutputs {
  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------
  @override
  void start() {
    inputState.add(ContentState());
  }

  // ---------------------------------------------------------------------------
  // Stream Controllers
  // ---------------------------------------------------------------------------
  final _oldPasswordController = StreamController<String>.broadcast();
  final _newPasswordController = StreamController<String>.broadcast();
  final _confirmPasswordController = StreamController<String>.broadcast();
  final _inputsValidationController = StreamController<void>.broadcast();

  // ---------------------------------------------------------------------------
  // Internal State
  // ---------------------------------------------------------------------------
  String _oldPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  // ---------------------------------------------------------------------------
  // Inputs
  // ---------------------------------------------------------------------------
  @override
  Sink get inPutOldPassword => _oldPasswordController.sink;

  @override
  Sink get inPutNewPassword => _newPasswordController.sink;

  @override
  Sink get inPutConfirmPassword => _confirmPasswordController.sink;

  @override
  Sink get areAllInputsValidController => _inputsValidationController.sink;

  @override
  void setOldPassword(String oldPassword) {
    _oldPassword = oldPassword;
    inPutOldPassword.add(oldPassword);
    areAllInputsValidController.add(null);
  }

  @override
  void setNewPassword(String newPassword) {
    _newPassword = newPassword;
    inPutNewPassword.add(newPassword);
    areAllInputsValidController.add(null);
  }

  @override
  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    inPutConfirmPassword.add(confirmPassword);
    areAllInputsValidController.add(null);
  }

  @override
  void saveChanges() {
    // TODO: Implement password change logic (e.g., call API)
  }

  // ---------------------------------------------------------------------------
  // Outputs
  // ---------------------------------------------------------------------------
  @override
  Stream<bool> get isOldPasswordValid =>
      _oldPasswordController.stream.map(isPasswordValid);

  @override
  Stream<bool> get isNewPasswordValid =>
      _newPasswordController.stream.map(isPasswordValid);

  @override
  Stream<bool> get isConfirmPasswordValid => _confirmPasswordController.stream
      .map((confirmPassword) => _isConfirmPasswordValid(confirmPassword));

  @override
  Stream<bool> get areAllInputsValid => _inputsValidationController.stream
      .map((_) => _areAllInputsValid());

  // ---------------------------------------------------------------------------
  // Private Helpers
  // ---------------------------------------------------------------------------
  bool _isConfirmPasswordValid(String confirmPassword) =>
      confirmPassword == _newPassword && isPasswordValid(confirmPassword);

  bool _areAllInputsValid() =>
      isTextNotEmpty(_oldPassword) &&
          isTextNotEmpty(_newPassword) &&
          _isConfirmPasswordValid(_confirmPassword);
}

// -----------------------------------------------------------------------------
// Abstract Interfaces
// -----------------------------------------------------------------------------
abstract class ChangePasswordViewmodelInputs {
  Sink get inPutOldPassword;
  Sink get inPutNewPassword;
  Sink get inPutConfirmPassword;
  Sink get areAllInputsValidController;

  void setOldPassword(String oldPassword);
  void setNewPassword(String newPassword);
  void setConfirmPassword(String confirmPassword);
  void saveChanges();
}

abstract class ChangePasswordViewmodelOutputs {
  Stream<bool> get isOldPasswordValid;
  Stream<bool> get isNewPasswordValid;
  Stream<bool> get isConfirmPasswordValid;
  Stream<bool> get areAllInputsValid;
}
