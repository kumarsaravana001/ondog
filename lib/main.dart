import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/banner_bloc/homescreen_banner_bloc.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/category_list_bloc/category_list_bloc.dart';
import 'package:ondgo_flutter/bloc/login_bloc/login_bloc.dart';
import 'package:ondgo_flutter/bloc/signin_bloc/signin_bloc.dart';
import 'routers/app_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'utilities/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('loginBox');
  String? authToken = box.get('authToken');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  String initialRoute = authToken != null ? '/navbar' : '/login';
  print('Retrieved Auth Token: $authToken');
  runApp(
      //DevicePreview(
      //builder: (context) => MyApp(
      //authToken: authToken,
      //),
      //));
      MyApp(initialRoute: initialRoute));
}

class MyApp extends StatefulWidget {
  final String initialRoute;

  const MyApp({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider<HomeScreenBannerBloc>(
            create: (context) =>
                HomeScreenBannerBloc(BlocProvider.of<LoginBloc>(context)),
          ),
          BlocProvider(create: (context) => SignInBloc()),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          title: 'Ondgo',
          theme: ThemeData(useMaterial3: true),
        ),
      );
    });
  }
}

Future<void> storeLoginToken(String token) async {
  var box = Hive.box('loginBox');
  await box.put('authToken', token);
  print('Stored Auth Token: $token'); // Debug print
}

Future<void> clearLoginToken() async {
  var box = Hive.box('loginBox');
  await box.delete('authToken');
  print('Cleared Auth Token'); // Debug print
}
