import 'package:flutter/material.dart';
import 'package:markdown_notifier/markdown_notifier.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final queryLogic = NotificationQueryLogic(
      url:
          "https://raw.githubusercontent.com/Flajt/markdown_notifier/master/NOTIFICATIONS.md",
      queryDuration: const Duration(minutes: 1));
  final dir = await getTemporaryDirectory();
  await queryLogic.init(dir.path);
  runApp(MyApp(
    queryLogic: queryLogic,
  ));
}

class MyApp extends StatelessWidget {
  final NotificationQueryLogic queryLogic;
  const MyApp({super.key, required this.queryLogic});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        queryLogic: queryLogic,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final NotificationQueryLogic queryLogic;
  const MyHomePage({Key? key, required this.queryLogic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Scaffold(
      body: SizedBox(
          child: Center(
        child: InfoButton(
          notificationQueryLogic: queryLogic,
        ),
      )),
    ));
  }
}
