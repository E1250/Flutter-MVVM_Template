import 'constants.dart';

extension NonNullString on String?{
  String orEmpty(){
    if(this == null){
      return Constants.empty;
    }else{
      return this!;
    }
  }
}

extension NonNullInt on int?{
  int orZero(){
    if(this == null){
      return Constants.zero;
    }else{
      return this!;
    }
  }
}

extension IsEmail on String{
  bool orText(){
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this)){
      return true;
    }else{
      return false;
    }
  }
}
