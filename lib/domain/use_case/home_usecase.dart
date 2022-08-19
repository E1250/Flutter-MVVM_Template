import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../models/models.dart';
import '../repository/repository.dart';
import 'base_use_case.dart';

class HomeUseCase implements BaseUseCase<void,HomeObject>{ // <In,Out>

  final Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHomeData();
  }
}
