import 'package:advanced_flutter_arabic/app/app.dart';
import 'package:advanced_flutter_arabic/app/di.dart';
import 'package:advanced_flutter_arabic/presentation/resources/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // make sure all done before opening the app
  await EasyLocalization.ensureInitialized();
  await initAppModule();

  /*
  We need to make MyApp as single instance
  this is not single instance
  we don't need that
  MyApp app1 = MyApp();
  MyApp app2 = MyApp();
  MyApp app3 = MyApp();
  */

  // Person p = Person(name, age); // default constructor
  // Person p = Person.fromJson(json); // named constructor

  runApp(
      EasyLocalization(path: ASSET_PATH_LOCALISATIONS,
          supportedLocales: const [
            ARABIC_LOCALE,
            ENGLISH_LOCALE
          ],
          child:Phoenix(child: MyApp())) // to restart the app when language changed
  );
}