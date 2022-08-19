import 'package:advanced_flutter_arabic/app/constants.dart';
import 'package:advanced_flutter_arabic/app/extensions.dart';
import 'package:advanced_flutter_arabic/data/response/responses.dart';

import '../../domain/models/models.dart';

extension CustomerResponseMapper on CustomerResponse?{
  Customer toDomain(){
    return Customer(this?.id.orEmpty() ?? Constants.empty, this?.name.orEmpty() ?? Constants.empty, this?.numOfNotifications.orZero() ?? Constants.zero);
  }
}

extension ContactsResponseMapper on ContactResponse?{
  Contact toDomain(){
    return Contact(this?.phone.orEmpty() ?? Constants.empty, this?.email.orEmpty() ?? Constants.empty, this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse?{
  Authentication toDomain(){
    return Authentication(this?.customer.toDomain(), this?.contacts.toDomain());
  }
}

extension ForgetPasswordResponseMapper on ForgetPassResponse?{
  String toDomain(){
    return this!.support?.orEmpty()?? Constants.empty;
  }
}

extension ServiceResponseMapper on ServiceResponse?{
  Service toDomain(){
    return Service(this?.id.orZero() ?? Constants.zero,this?.title.orEmpty()?? Constants.empty,this?.image.orEmpty()?? Constants.empty);
  }
}

extension StoreResponseMapper on StoreResponse?{
  Store toDomain(){
    return Store(this?.id.orZero() ?? Constants.zero,this?.title.orEmpty()?? Constants.empty,this?.image.orEmpty()?? Constants.empty);
  }
}

extension BannerResponseMapper on BannersResponse?{
  BannerAd toDomain(){
    return BannerAd(this?.id.orZero() ?? Constants.zero,this?.title.orEmpty()?? Constants.empty,this?.image.orEmpty()?? Constants.empty,this?.link.orEmpty()??Constants.empty);
  }
}

extension HomeResponseMapper on HomeResponse?{
  HomeObject toDomain(){
    // TODO Really good way to use
    List<Service> services = (this?.data?.services?.map((serviceResponse)=>serviceResponse.toDomain()) ?? const Iterable.empty()).cast<Service>().toList();
    List<BannerAd> banners = (this?.data?.banners?.map((bannerResponse)=>bannerResponse.toDomain()) ?? const Iterable.empty()).cast<BannerAd>().toList();
    List<Store> stores = (this?.data?.stores?.map((storeResponse)=>storeResponse.toDomain()) ?? const Iterable.empty()).cast<Store>().toList();


    var data = HomeData(services, banners, stores);
    return HomeObject(data);
  }
}


extension StoreDetailsResponseMapper on StoreDetailsResponse?{
  StoreDetails toDomain(){
    return StoreDetails(
      this?.id.orZero() ?? Constants.zero,
      this?.title.orEmpty()?? Constants.empty,
      this?.image.orEmpty()?? Constants.empty,
      this?.details.orEmpty()??Constants.empty,
      this?.services.orEmpty()??Constants.empty,
      this?.about.orEmpty()??Constants.empty,
    );
  }
}



