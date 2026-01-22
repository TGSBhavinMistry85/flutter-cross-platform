import 'package:flutter/material.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_application_1/platform_window.dart';
import 'package:flutter_application_1/license-validator/license_validator.dart';
import 'core/routing/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Prepares Flutter’s engine before use anything that talks to the platform (OS)

  await initDesktopWindow();

  // Load environment variables
  //await dotenv.load(fileName: ".env");

  bool valid = await LicenseValidator.isLicenseValid();
  if (!valid) {
    runApp(const MaterialApp(
      home: Scaffold(
        body: Center(child: Text("Invalid License. Application is locked.")),
      ),
    ));
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}