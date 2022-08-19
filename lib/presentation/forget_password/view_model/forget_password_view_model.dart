
import 'dart:async';

import 'package:advanced_flutter_arabic/app/extensions.dart';
import 'package:advanced_flutter_arabic/presentation/base/base_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/common/freezed_data_classes.dart';
import '../../../domain/use_case/forget_usecase.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class ForgetPassViewModel extends BaseViewModel with ForgetPassViewModelInput,ForgetPassModelOutput{

  final StreamController _emailStreamController = StreamController<String>.broadcast(); //  to make stream controller has many listeners
  final StreamController _areAllInputsValidStreamController = StreamController<void>.broadcast();

  var email = "";

  final ForgetUseCase _forgetUseCase;
  ForgetPassViewModel(this._forgetUseCase);

@override
  void dispose() {
    _emailStreamController.close();
    _areAllInputsValidStreamController.close();
    super.dispose();
  }

  @override
  Sink get areAllInputsValid => _areAllInputsValidStreamController;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Stream<bool> get areAllOutputsValid => _areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  forgetPass() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE,message: "Sending Verification Code..."));
    // fold is either fun for return left and right
    (await _forgetUseCase.execute(email)).
    fold((failure) => {
      // left
      inputState.add(ErrorState(StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message))
    },
            (data){
/*
      print(data.customer?.name);
*/
          // right
          // content
          inputState.add(SuccessState(data));
          // navigate to main Screen
/*
          isUserLoggedInStreamController.add(true);
*/
        });
  }



  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    areAllInputsValid.add(null);
  }

  @override
  void start() {
    inputState.add(ContentState());
  }
  // some functions
  bool _areAllInputsValid(){
    return _isEmailValid(email);
  }
  bool _isEmailValid(String password){
    return password.orText();
  }


}

abstract class ForgetPassViewModelInput{
  setEmail(String email);
  forgetPass();

  Sink get inputEmail;
  Sink get areAllInputsValid;

}

abstract class ForgetPassModelOutput{
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get areAllOutputsValid;
}