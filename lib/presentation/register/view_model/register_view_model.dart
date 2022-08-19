import 'dart:async';
import 'dart:io';
import 'package:advanced_flutter_arabic/app/extensions.dart';
import 'package:advanced_flutter_arabic/domain/use_case/register_usecase.dart';
import 'package:advanced_flutter_arabic/presentation/base/base_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/common/freezed_data_classes.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class RegisterViewModel extends BaseViewModel with RegisterViewModelInput,RegisterViewModelOutput{
  StreamController userNameStreamController = StreamController<String>.broadcast();
  StreamController mobileNumberStreamController = StreamController<String>.broadcast();
  StreamController emailStreamController = StreamController<String>.broadcast();
  StreamController passwordStreamController = StreamController<String>.broadcast();
  StreamController profilePicStreamController = StreamController<File>.broadcast();
  StreamController areAllInputsValidStreamController = StreamController<void>.broadcast();

  StreamController isUserRegisteredSuccessfullyStreamController = StreamController<bool>();

  final RegisterUseCase _registerUseCase;
  var registerObject = RegisterObject('', '', '', '', '','');
  RegisterViewModel(this._registerUseCase);

  // inputs

  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputMobileNumber => mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputProfilePic => profilePicStreamController.sink;

  @override
  Sink get inputUserName => userNameStreamController.sink;


  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    userNameStreamController.close();
    mobileNumberStreamController.close();
    emailStreamController.close();
    profilePicStreamController.close();
    passwordStreamController.close();
    areAllInputsValidStreamController.close();
    super.dispose();

  }

  // outputs

  @override
  Stream<bool> get outIsEmailValid => emailStreamController.stream.map((email) => email.toString().orText());

  @override
  Stream<bool> get outIsMobileNumberValid => mobileNumberStreamController.stream.map((mobileNum) => _isMobileNumValid(mobileNum));

  @override
  Stream<bool> get outIsPasswordValid => passwordStreamController.stream.map((password) => _isPassValid(password));

  @override
  Stream<File> get outIsProfilePicValid => profilePicStreamController.stream.map((file) =>file);

  @override
  Stream<bool> get outIsUserNameValid => userNameStreamController.stream.map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorEmail => outIsEmailValid.map((isEmailValid){
    isEmailValid ? null : AppStrings.emailInvalid.tr();
  });

  @override
  Stream<String?> get outputErrorMobileNumber => outIsMobileNumberValid.map((isValid){
    isValid ? null : AppStrings.phoneInvalid.tr();
  });

  @override
  Stream<String?> get outputErrorPassword => outIsPasswordValid.map((isValid) {
    isValid ? null : AppStrings.passInvalid.tr();

  });

  @override
  Stream<String?> get outputErrorUserName => outIsUserNameValid.map((isUserName) {
    isUserName ? null : AppStrings.userNameInvalid.tr();
  });

 // private functions
  bool _isUserNameValid(String userName){
    return userName.length >= 8 ;
  }

  bool _isMobileNumValid(String mobileNum){
    return mobileNum.length >= 10 ;
  }
  bool _isPassValid(String password){
    return password.length >= 6 ;
  }

  // private section
  @override
  register() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE,message: "Login...."));
    // fold is either fun for return left and right
    (await _registerUseCase.execute(RegisterUseCaseInput(
        registerObject.userName,
        registerObject.email,
        registerObject.profilePic,
        registerObject.password,
        registerObject.mobilNumber,
        registerObject.countryCode
    )))
        .fold((failure) => {
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
    isUserRegisteredSuccessfullyStreamController.add(true);
    });
  }

  @override
  setCountryCode(String countryCode) {
    if(countryCode.isNotEmpty){
      // update view object
      registerObject = registerObject.copyWith(countryCode: countryCode);
    }else{
      // reset username value in register view object
      registerObject = registerObject.copyWith(countryCode: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if(email.orText()){ // is email valid
      // update view object
      registerObject = registerObject.copyWith(email: email);
    }else{
      // reset username value in register view object
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if(_isPassValid(password)){ // is email valid
      // update view object
      registerObject = registerObject.copyWith(password: password);
    }else{
      // reset username value in register view object
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setPhoneNum(String phone) {
    inputMobileNumber.add(phone);
    if(_isMobileNumValid(phone)){ // is email valid
      // update view object
      registerObject = registerObject.copyWith(mobilNumber: phone);
    }else{
      // reset username value in register view object
      registerObject = registerObject.copyWith(mobilNumber: "");
    }
    validate();

  }

  @override
  setProfilePic(File profilePic) {
    inputProfilePic.add(profilePic);
    if(profilePic.path.isNotEmpty){ // is email valid
      // update view object
      registerObject = registerObject.copyWith(profilePic: profilePic.path);
    }else{
      // reset username value in register view object
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setUserName(String userName) {
    print("here");
    inputUserName.add(userName);
    if(_isUserNameValid(userName)){
      // update view object
      registerObject = registerObject.copyWith(userName: userName);
    }else{
      // reset username value in register view object
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();

  }

  @override
  Sink get allInputsValid => areAllInputsValidStreamController.sink;

  @override
  Stream<bool> get areAllInputsValid => areAllInputsValidStreamController.stream.map((_) {
    return _areAllInputsValid();
  } );

  bool _areAllInputsValid(){
    return
      registerObject.countryCode.isNotEmpty &&
      registerObject.mobilNumber.isNotEmpty &&
      registerObject.password.isNotEmpty &&
      registerObject.email.isNotEmpty &&
      registerObject.userName.isNotEmpty
    ;
  }

  validate(){
    allInputsValid.add(null);
  }
}

abstract class RegisterViewModelInput{
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePic;
  Sink get allInputsValid;


  register();
  setUserName(String userName);
  setPhoneNum(String phone);
  setCountryCode(String countryCode);
  setEmail(String email);
  setPassword(String password);
  setProfilePic(File profilePic);

}

abstract class RegisterViewModelOutput{
  Stream<bool> get outIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<File> get outIsProfilePicValid;
  Stream<bool> get areAllInputsValid;

}


