import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/bukken.dart';
import 'pages/home.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  // TODO: https://github.com/flutter/flutter/blob/2.5.0/packages/flutter_tools/templates/skeleton/lib/src/app.dart.tmpl
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  final _routeInformationParser = _AppRouteInformationParser();
  final _routerDelegate = _AppRouterDelegate();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      routeInformationParser: _routeInformationParser,
      routerDelegate: _routerDelegate,
    );
  }
}

class _AppRouteInformationParser extends RouteInformationParser<_AppRoutePath> {
  @override
  Future<_AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) {
    // TODO: implement parseRouteInformation
    throw UnimplementedError();
  }
}

class _AppRouterDelegate extends RouterDelegate<_AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<_AppRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  _AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  Future<void> setNewRoutePath(_AppRoutePath configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }
}

class _AppRoutePath {
  final int? id;
  final bool isUnknown;

  _AppRoutePath.home()
      : id = null,
        isUnknown = false;

  _AppRoutePath.details(this.id) : isUnknown = false;

  _AppRoutePath.unknown()
      : id = null,
        isUnknown = true;

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;
}
