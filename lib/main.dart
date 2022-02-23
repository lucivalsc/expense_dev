import 'package:expense_dev/theme/cores.dart';
import 'package:expense_dev/view/login/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Cores.cinzaBar,
      statusBarBrightness: Brightness.dark,
      //Ícones superior e inferior
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Cores.cinza,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Cores.cinza,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Cores.azulEscuro,
          ),
        ),
      ),
      home: const SplashWidget(),
    );
  }
}
