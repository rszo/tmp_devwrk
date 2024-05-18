import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/house.dart';
import 'models/page_enum.dart';
import 'models/page_param.dart';
import 'models/search_option.dart';
import 'pages/home.dart';
import 'pages/house.dart';
import 'pages/search.dart';
import 'pages/unknown.dart';

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
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    // Handle '/'
    if (uri.pathSegments.isEmpty) {
      return _AppRoutePath.home();
    }
    // Handle '/search'
    else if (uri.pathSegments[0] == 'search') {
      if (uri.pathSegments.length == 2) {
        var id = int.tryParse(uri.pathSegments[1]);
        if (id != null) return _AppRoutePath.search(id);
      }
      return _AppRoutePath.search(0);
    }
    // Handle '/house/:id'
    else if (uri.pathSegments[0] == 'house') {
      if (uri.pathSegments.length == 2) {
        var id = int.tryParse(uri.pathSegments[1]);
        if (id != null) return _AppRoutePath.details(id);
      }
    }
    // Handle unknown routes
    return _AppRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(_AppRoutePath configuration) {
    if (configuration.isUnknown) {
      return const RouteInformation(location: '/404');
    }
    if (configuration.isHomePage) {
      return const RouteInformation(location: '/');
    }
    if (configuration.isSearchPage) {
      return RouteInformation(location: '/search/${configuration.searchId}');
    }
    if (configuration.isDetailsPage) {
      return RouteInformation(location: '/house/${configuration.houseId}');
    }
    return null;
  }
}

class _AppRouterDelegate extends RouterDelegate<_AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<_AppRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  SearchPageParam? _searchParam;
  HousePageParam? _houseParam;
  bool _show404;

  _AppRouterDelegate()
      : navigatorKey = GlobalKey<NavigatorState>(),
        _show404 = false;

  @override
  _AppRoutePath get currentConfiguration {
    if (_show404) {
      return _AppRoutePath.unknown();
    } else if (_searchParam != null) {
      return _AppRoutePath.search(_searchParam!.id);
    } else if (_houseParam != null) {
      return _AppRoutePath.details(_houseParam!.id);
    } else {
      return _AppRoutePath.home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: const ValueKey('HomePage'),
          child: HomePage(onPressed: _handleSearchTapped),
        ),
        if (_show404)
          MaterialPage(
            key: const ValueKey('UnknownPage'),
            child: UnknownPage(onPressed: _handleTapped),
          )
        else if (_searchParam != null)
          MaterialPage(
            key: const ValueKey('SearchPage'),
            child: SearchPage.fromAsset(
              // param: _searchParam!,
              onTapped: _handleHouseTapped,
            ),
          )
        else if (_houseParam != null)
          HousePage(obj: _houseParam!)
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _searchParam = null;
        _houseParam = null;
        _show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(_AppRoutePath configuration) async {
    if (configuration.isUnknown) {
      _searchParam = null;
      _houseParam = null;
      _show404 = true;
      return;
    }

    if (configuration.isSearchPage) {
      final ids = jsonDecode(
        await rootBundle.loadString('assets/json/1.json'),
      )['result'] as List;
      if (!ids.contains(configuration.searchId)) {
        _show404 = true;
        return;
      }
      _searchParam = SearchPageParam(configuration.searchId!);
    } else {
      _searchParam = null;
    }

    if (configuration.isDetailsPage) {
      final ids = jsonDecode(
        await rootBundle.loadString('assets/json/2.json'),
      )['result'] as List;
      if (!ids.contains(configuration.houseId)) {
        _show404 = true;
        return;
      }
      _houseParam = HousePageParam(configuration.houseId!);
    } else {
      _houseParam = null;
    }

    _show404 = false;
  }

  void _handleTapped(Segment segment) {
    _searchParam = null;
    _houseParam = null;
    if (segment == Segment.home) {
      _show404 = false;
    }
    notifyListeners();
  }

  void _handleSearchTapped(SearchOption option) {
    _searchParam = SearchPageParam(option.id);
    _houseParam = null;
    notifyListeners();
  }

  void _handleHouseTapped(HouseEntry entry) {
    _searchParam = null;
    _houseParam = HousePageParam(entry.id);
    notifyListeners();
  }
}

class _AppRoutePath {
  final Segment segment;
  final int? searchId;
  final int? houseId;
  final bool isUnknown;

  _AppRoutePath(this.segment, this.isUnknown)
      : searchId = null,
        houseId = null;

  _AppRoutePath.home() : this(Segment.home, false);

  _AppRoutePath.search(this.searchId)
      : segment = Segment.search,
        houseId = null,
        isUnknown = false;

  _AppRoutePath.details(this.houseId)
      : segment = Segment.house,
        searchId = null,
        isUnknown = false;

  _AppRoutePath.unknown() : this(Segment.home, true);

  bool get isHomePage => segment == Segment.home && !isUnknown;

  bool get isSearchPage => searchId != null;

  bool get isDetailsPage => houseId != null;
}
