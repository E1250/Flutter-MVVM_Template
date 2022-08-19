class LoginRequest{
  String email;
  String password;
  LoginRequest(this.email,this.password);
}

class ForgetPassRequest{
  String email;
  ForgetPassRequest(this.email);
}

class RegisterRequest{
  String userName;
  String countryCode;
  String mobilNumber;
  String password;
  String email;
  String profilePic;
  RegisterRequest(this.email,this.password,this.userName,this.countryCode,this.mobilNumber,this.profilePic);
}