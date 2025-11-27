import 'package:elevator/data/network/exception_handler.dart';
import 'package:elevator/domain/models/next_appointment_model.dart';
import 'package:elevator/domain/models/user_data_model.dart';

const CACHE_USER_DATA_KEY = "CACHE_USER_DATA_KEY";
const CACHE_NEXT_APPOINTMENT_KEY = "CACHE_NEXT_APPOINTMENT_KEY";
const CACHE_USER_DATA_INTERNAL = 5 * 60 * 1000; // 5 min
const CACHE_NEXT_APPOINTMENT_INTERNAL = 3 * 60 * 1000; // 3 min
// const CACHE_USER_DATA_INTERNAL = 10 * 1000; // 10 sec for testing

abstract class LocalDataSource {
  Future<GetUserInfo> getUserData();

  Future<NextAppointmentModel> getNextAppointment();

  Future<void> saveUserDataToCache(GetUserInfo userInfo);

  Future<void> saveNextAppointmentToCache(NextAppointmentModel nextAppointmentModel);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<GetUserInfo> getUserData() async {
    CachedItem? cachedItem = cacheMap[CACHE_USER_DATA_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_USER_DATA_INTERNAL)) {
      return cachedItem.data;
    }
    throw ExceptionHandler.handle(DataSource.CACHE_ERROR);
  }

  @override
  Future<void> saveUserDataToCache(GetUserInfo userInfo) async {
    cacheMap[CACHE_USER_DATA_KEY] = CachedItem(userInfo);
  }

  @override
  Future<NextAppointmentModel> getNextAppointment() async {
    CachedItem? cachedItem = cacheMap[CACHE_NEXT_APPOINTMENT_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_NEXT_APPOINTMENT_INTERNAL)) {
      return cachedItem.data;
    }
    throw ExceptionHandler.handle(DataSource.CACHE_ERROR);
  }

  @override
  Future<void> saveNextAppointmentToCache(NextAppointmentModel nextAppointmentModel) async {
    cacheMap[CACHE_NEXT_APPOINTMENT_KEY] = CachedItem(nextAppointmentModel);
  }

  @override
  void clearCache() => cacheMap.clear();

  @override
  void removeFromCache(String key) => cacheMap.remove(key);
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isExpired = currentTimeInMillis - cacheTime <= expirationTimeInMillis;
    return isExpired;
  }
}