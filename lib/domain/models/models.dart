// onBoarding models
import 'package:advanced_flutter_arabic/data/response/responses.dart';

class SliderObject{
  String title;
  String subTitle;
  String image;

  SliderObject(this.title,this.subTitle,this.image);
}


class SliderViewObject{
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;
  SliderViewObject(this.sliderObject,this.currentIndex,this.numOfSlides);
}

// login models
class Customer{
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id,this.name,this.numOfNotifications);
}

class Contact{
  String phone;
  String email;
  String link;

  Contact(this.phone,this.email,this.link);
}

class Authentication{
  // should be nullable thought it is not string or int etc..
  Customer? customer;
  Contact? contact;

  Authentication(this.customer,this.contact);
}

class Service{
  int id;
  String title;
  String image;

  Service(this.id,this.title,this.image);
}

class BannerAd{
  int id;
  String title;
  String image;
  String link;


  BannerAd(this.id,this.title,this.image,this.link);
}

class Store{
  int id;
  String title;
  String image;

  Store(this.id,this.title,this.image);
}

class HomeData{
  List<Service> services;
  List<BannerAd> banners;
  List<Store> stores;

  HomeData(this.services,this.banners,this.stores);
}

class HomeObject{
  HomeData data;

  HomeObject(this.data);
}
class StoreDetails{
  int id;
  String title;
  String image;
  String details;
  String services;
  String about;

  StoreDetails(this.id,this.title,this.image,this.details,this.services,this.about);
}