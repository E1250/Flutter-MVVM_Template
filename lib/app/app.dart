import 'package:advanced_flutter_arabic/app/app_preferences.dart';
import 'package:advanced_flutter_arabic/app/di.dart';
import 'package:advanced_flutter_arabic/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class MyApp extends StatefulWidget {
/*
   Can't be used as single instance and we need to use single instance
   or instantiate MyApp just one time
   so we can use it just one time
    we can't use next line
 */
   //const MyApp({Key? key}) : super(key: key); // default constructor

  // named constructor
  MyApp._internal(); // private constructor

  int appState = 0;

  static final MyApp _instance = MyApp._internal(); // singletone or single instance

  factory MyApp() => _instance; // factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocale().then((locale) {
      context.setLocale(locale);
      print("locale: ${locale.toString()}");
    });
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme:getApplicationTheme()
    );
  }
}


/* Lower section is not important, just for explanations  */

// explaining name constructors
class Person{
  late final String name;
  late final int age;

  Person(this.name,this.age);  // default constructor

  Person.fromjson(Map<String,dynamic> json){ // named constructor
    this.name = json['name'];
    this.age = json['age'];
  }
}
