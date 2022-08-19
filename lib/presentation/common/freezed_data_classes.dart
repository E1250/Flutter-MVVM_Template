import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';


@freezed
class LoginObject with _$LoginObject{
  factory LoginObject(String userName,String password) = _LoginObject;
}

@freezed
class ForgetObject with _$ForgetObject{
  factory ForgetObject(String email) = _ForgetObject;
}

@freezed
class RegisterObject with _$RegisterObject{
  factory RegisterObject(
    String userName,
    String countryCode,
    String mobilNumber,
    String password,
    String email,
    String profilePic,
      ) = _RegisterObject;
}
