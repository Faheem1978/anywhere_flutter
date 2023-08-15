import 'package:get_it/get_it.dart';
import 'package:anywhere/core/services/api.dart';
import 'package:anywhere/core/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => Api());
  locator.registerLazySingleton(() => NavigationService());
}
