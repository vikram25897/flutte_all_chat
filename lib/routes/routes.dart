import 'package:chat/res/styles.dart';
import 'package:chat/screens/splash/splash.dart';
import 'package:chat/sockets/connection_manager.dart';
import 'package:flutter/material.dart';

final routeMap = <String, Widget Function(BuildContext)>{
  "/": (context) => SplashScreen()
};
final initialRoute = "/";

routes() {
  final ConnectionManager connectionManager = ConnectionManager();
  runApp(
    App(
        child: MaterialApp(
          routes: routeMap,
          initialRoute: initialRoute,
          theme: primaryTheme,
        ),
        connectionManager: connectionManager),
  );
}

class App extends InheritedWidget {
  final Widget child;
  final ConnectionManager connectionManager;
  const App({this.child, this.connectionManager}) : super(child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
  static App of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(App);
  }
}
