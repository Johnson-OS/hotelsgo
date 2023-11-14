import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hotelsgo/res/app_theme.dart';
import 'package:hotelsgo/screens/home/home_screen.dart';
import 'package:hotelsgo/services/hotels_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await initServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:(_,__) => MaterialApp(
            title: 'HotelsGo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF0C77BA),
                primary: const Color(0xFF0C77BA)
              ),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: const HomeScreen(),
      ),
    );

  }

}

Future<void> initServices() async {
  GetIt getIt = GetIt.instance;

  // services
  getIt.registerSingleton<AppTheme>(AppTheme());
  getIt.registerSingleton<HotelsService>(HotelsService());

}

