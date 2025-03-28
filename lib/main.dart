import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumplier/Config/config.dart';
import 'package:sumplier/screen/dashboard_screen/view/dashboard_page.dart';
import 'package:sumplier/screen/login_screen/view/login_page.dart';
import 'package:sumplier/screen/splash_screen/splash_page.dart';
import 'package:sumplier/screen/user_screen/view/user_page.dart';

import 'database/pref_helper.dart';
import 'enum/config_key.dart';
import 'model/company.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.init();

  Company? currentCompany = PrefHelper.getModel(ConfigKey.company.name,  (json) => Company.fromJson(json));

  if(currentCompany != null) {
    Config.instance.setCurrentCompany(currentCompany);
  }

  runApp(MyApp(initialRoute: currentCompany != null ? '/UserPage' : '/LoginPage'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/LoginPage', page: () => LoginPage()),
        GetPage(name: '/UserPage', page: () => UserPage()),
        GetPage(name: '/SplashPage', page: () => SplashPage()),
        GetPage(name: '/DashboardPage', page: () => DashboardPage())
      ],
    );
  }
}
