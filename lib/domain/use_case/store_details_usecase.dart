import 'package:advanced_flutter_arabic/data/network/failure.dart';
import 'package:advanced_flutter_arabic/domain/models/models.dart';
import 'package:advanced_flutter_arabic/domain/repository/repository.dart';
import 'package:advanced_flutter_arabic/domain/use_case/base_use_case.dart';
import 'package:dartz/dartz.dart';

class StoreDetailsUseCase  extends BaseUseCase<void,StoreDetails>{
  final Repository _repository;
  StoreDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) {
    return _repository.getStoreDetails();
  }


}