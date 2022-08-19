import 'package:advanced_flutter_arabic/data/network/failure.dart';
import 'package:advanced_flutter_arabic/data/network/requests.dart';
import 'package:advanced_flutter_arabic/domain/models/models.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import 'base_use_case.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentication>{ // <In,Out>

  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}


class LoginUseCaseInput {  // model
  String email;
  String password;
  LoginUseCaseInput(this.email,this.password);
}

