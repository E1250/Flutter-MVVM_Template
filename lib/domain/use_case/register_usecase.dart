import 'package:advanced_flutter_arabic/data/network/failure.dart';
import 'package:advanced_flutter_arabic/data/network/requests.dart';
import 'package:advanced_flutter_arabic/domain/models/models.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import 'base_use_case.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput,Authentication>{ // <In,Out>

  final Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
      input.email,
      input.mobilNumber,
      input.profilePic,
      input.password,
      input.userName,
      input.countryCode
    ));
  }
}


class RegisterUseCaseInput {  // model
  String userName;
  String countryCode;
  String mobilNumber;
  String password;
  String email;
  String profilePic;
  RegisterUseCaseInput(this.email,this.password,this.userName,this.countryCode,this.mobilNumber,this.profilePic);
}

