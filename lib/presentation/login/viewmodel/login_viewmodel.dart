import 'dart:async';
import 'package:advanced_flutter_arabic/domain/use_case/login_usecase.dart';
import 'package:advanced_flutter_arabic/presentation/base/base_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInput,LoginViewModelOutput{

  final StreamController _userNameStreamController = StreamController<String>.broadcast(); //  to make stream controller has many listeners
  final StreamController _passwordStreamController = StreamController<String>.broadcast(); //  to make stream controller has many listeners
  final StreamController _areAllInputsValidStreamController = StreamController<void>.broadcast();

  StreamController isUserLoggedInStreamController = StreamController<bool>();

  var loginObject = LoginObject("","");
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  // inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLoggedInStreamController.close();
  }

  @override
  void start() {
    // view model should tell view please show content state
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get areAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  setUserName(String username) {
    inputUserName.add(username);
    loginObject=loginObject.copyWith(userName: username);
    areAllInputsValid.add(null);

  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject=loginObject.copyWith(password: password);
    areAllInputsValid.add(null);
  }


  @override
  login() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE,message: "Login...."));
    // fold is either fun for return left and right
    (await _loginUseCase.execute(LoginUseCaseInput(loginObject.userName, loginObject.password))).
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
      inputState.add(ContentState());
      // navigate to main Screen
      isUserLoggedInStreamController.add(true);
    });
  }

  // outputs

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream.map((username) => _isUserNameValid(username));

  @override
  Stream<bool> get areAllOutputsValid => _areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());


  bool _areAllInputsValid(){
    return _isPasswordValid(loginObject.password) || _isUserNameValid(loginObject.userName);
  }
  bool _isPasswordValid(String password){
    return password.isNotEmpty;
  }
  bool _isUserNameValid(String username){
    return username.isNotEmpty;
  }

}

abstract class LoginViewModelInput{

  setUserName(String username);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get areAllInputsValid;

}

abstract class LoginViewModelOutput{
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get areAllOutputsValid;
}