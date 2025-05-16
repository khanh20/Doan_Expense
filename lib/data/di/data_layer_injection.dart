

import 'package:flutter_application_1/data/di/module/network_module.dart';
import 'package:flutter_application_1/data/di/module/repository_module.dart';

class DataLayerInjection {
  static Future<void> configureDataLayerInjection() async {

    
    await NetworkModule.configureNetworkModuleInjection();
    await RepositoryModule.configureRepositoryModuleInjection();
  }
}
