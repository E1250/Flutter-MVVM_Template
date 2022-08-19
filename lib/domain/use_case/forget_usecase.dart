
import 'package:advanced_flutter_arabic/data/network/requests.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../domain/models/models.dart';
import '../../domain/repository/repository.dart';
import 'base_use_case.dart';

class ForgetUseCase implements BaseUseCase<String,String>{ // <In,Out>

  final Repository _repository;
  ForgetUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String input) async {
    return await _repository.forgetPass(input);
  }
}


class ForgetPassUseCaseInput {  // model
  String email;
  ForgetPassUseCaseInput(this.email);
}
