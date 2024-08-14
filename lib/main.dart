
import 'package:assignment_task/utilities/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'features/auth/login/login_view.dart';
import 'features/get_classes_and_search/manager/logic.dart';
import 'features/get_grades_and_search/manager/logic_get_grades.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Make the status bar transparent
    statusBarIconBrightness: Brightness.dark, // Set the icon brightness (dark or light)
  ));
  await Future.delayed(Duration(seconds :1));{
    FlutterNativeSplash.remove();
  };
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        BlocProvider(create: (context)=>GetGradeubit()..getGrade(),),
        BlocProvider(create: (context)=>GetClassesCubit()..getClasses(),),

      ],
      child: MaterialApp(
         theme: ThemeData(
           scaffoldBackgroundColor: secondaryColor
         ),
        debugShowCheckedModeBanner: false,
        title: 'Assignment task',
        home: LoginView()
      ),
    );
  }
}

