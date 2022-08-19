
import 'dart:ffi';

import 'package:advanced_flutter_arabic/domain/models/models.dart';
import 'package:advanced_flutter_arabic/domain/use_case/store_details_usecase.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/subjects.dart';
import 'dart:async';
import 'package:advanced_flutter_arabic/presentation/base/base_view_model.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';


class StoreDetailsViewModel extends BaseViewModel with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase storeDetailsUseCase;

  StoreDetailsViewModel(this.storeDetailsUseCase);

  @override
  start() async {
    _loadData();
  }

  _loadData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await storeDetailsUseCase.execute(Void)).fold(
          (failure) {
        inputState.add(ErrorState(
            StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
      },
          (storeDetails) async {
        inputState.add(ContentState());
        inputStoreDetails.add(storeDetails);
      },
    );
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  //output
  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((stores) => stores);
}

abstract class StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}