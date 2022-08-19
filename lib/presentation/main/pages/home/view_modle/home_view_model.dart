import 'dart:async';
import 'dart:ffi';

import 'package:advanced_flutter_arabic/domain/models/models.dart';
import 'package:advanced_flutter_arabic/domain/use_case/home_usecase.dart';
import 'package:advanced_flutter_arabic/presentation/base/base_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel with HomeViewModelInput,HomeViewModelOutput{
  //final StreamController _bannerStreamController = StreamController<List<BannerAd>>.broadcast(); // to have more than one listener
/*
  final StreamController _bannerStreamController = BehaviorSubject<List<BannerAd>>(); // to have more than one listener
  final StreamController _serviceStreamController = BehaviorSubject<List<Service>>();
  final StreamController _storeStreamController = BehaviorSubject<List<Store>>();
*/

final _dataStreamController = BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);
  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE,message: "Login...."));
    (await _homeUseCase.execute(Void)).
    fold((failure) => {
      inputState.add(ErrorState(StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message))
    }, (homeObject){
          inputState.add(ContentState()); // show content
  /*        inputBanners.add(homeObject.data.banners);
          inputServices.add(homeObject.data.services);
          inputStores.add(homeObject.data.stores);*/
      inputHomeData.add(HomeViewObject(homeObject.data.stores, homeObject.data.services, homeObject.data.banners));

    });
  }

  @override
  void dispose() {
/*    _bannerStreamController.close();
    _serviceStreamController.close();
    _storeStreamController.close();*/
    _dataStreamController.close();
    super.dispose();
  }

  @override
  // TODO: implement inputHomeData
  Sink get inputHomeData => _dataStreamController.sink;

  @override
  // TODO: implement outputHomeData
  Stream<HomeViewObject> get outputHomeData => _dataStreamController.stream.map((data)=> data);



/*  @override
  Sink get inputBanners => _bannerStreamController.sink;

  @override
  Sink get inputServices => _serviceStreamController.sink;

  @override
  Sink get inputStores => _storeStreamController.sink;


  // outputs ***********************
  @override
  Stream<List<BannerAd>> get outputBanners => _bannerStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outputServices => _serviceStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores => _storeStreamController.stream.map((stores) => stores);*/

}


abstract class HomeViewModelOutput{
/*  Sink get inputStores;
  Sink get inputServices;
  Sink get inputBanners;*/

  Sink get inputHomeData;
}

abstract class HomeViewModelInput{
/*  Stream<List<Store>> get outputStores;
  Stream<List<Service>> get outputServices;
  Stream<List<BannerAd>> get outputBanners;*/

    Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject{
  List<Store> stores;
  List<Service> services;
  List<BannerAd> banners;

  HomeViewObject(this.stores,this.services,this.banners);
}