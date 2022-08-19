import 'package:advanced_flutter_arabic/data/network/error_handler.dart';
import 'package:advanced_flutter_arabic/data/response/responses.dart';

abstract class LocalDataSource{
  Future<HomeResponse> getHomeData();
  Future<void> saveHomeToCache(HomeResponse homeResponse);

  void clearCache();  // when logout as ex..
  void removeFromCache(String key);

  Future<StoreDetailsResponse> getStoreDetails();
  Future<void> saveStoreDetailsToCache(StoreDetailsResponse response);

}
const String CACHE_HOME_KEY = "CACHE_HOME_KEY";
const String CACHE_STORE_DETAILS_KEY = "CACHE_STORE_DETAILS_KEY";

const int CACHE_HOME_INTERVAL = 60*1000; // 1 minutes
const int CACHE_STORE_DETAILS__INTERVAL =60*1000;

class LocalDataSourceImpl implements LocalDataSource{

  // run time cache
  Map<String,CachedItem> cacheMap = {};

  @override
  Future<HomeResponse> getHomeData() async{
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if(cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)){
      // return response from cache
      return cachedItem.data;
    }else{
      // return no cache or not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }


  @override
  Future<void> saveStoreDetailsToCache(response) async{
    cacheMap[CACHE_STORE_DETAILS_KEY] = CachedItem(response);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() {
    CachedItem? cachedItem = cacheMap[CACHE_STORE_DETAILS_KEY];
    if(cachedItem != null && cachedItem.isValid(CACHE_STORE_DETAILS__INTERVAL)){
      // return response from cache
      return cachedItem.data;
    }else{
      // return no cache or not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

}
class CachedItem{
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtention on CachedItem{
  bool isValid(int expTime){
      int currentTime  = DateTime.now().millisecondsSinceEpoch;
      bool isValid = currentTime-cacheTime <= expTime;
      return isValid;
  }
}