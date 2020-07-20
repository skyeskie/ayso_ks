import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:sailor/sailor.dart';
import 'package:sailor/src/errors/route_not_found.dart';
import 'package:sailor/src/models/arguments_wrapper.dart';

class SailorFake extends Fake implements Sailor {
  final Map<String, SailorRoute> _routeNameMappings = {};
  final Map<String, Map<String, SailorParam>> _routeParamsMappings = {};

  GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  void addRoutes(List<SailorRoute> routes) {
    if (routes != null && routes.isNotEmpty) {
      routes.forEach(addRoute);
    }
  }

  @override
  void addRoute(SailorRoute route) {
    assert(route != null, "'route' argument cannot be null.");

    //Go ahead and force no duplicate adds in mock
    assert(!_routeNameMappings.containsKey(route.name));

    // Prepare route params
    final routeParams = <String, SailorParam>{};

    if (route.params != null) {
      for (final sailorParam in route.params) {
        //Go ahead and force no duplicate adds in mock
        assert(!routeParams.containsKey(sailorParam.name));
        routeParams[sailorParam.name] = sailorParam;
      }
    }

    _routeNameMappings[route.name] = route;
    _routeParamsMappings[route.name] = routeParams;
  }

  @override
  // ignore: missing_return
  Future<T> call<T>(
    String name, {
    BaseArguments args,
    NavigationType navigationType = NavigationType.push,
    dynamic result,
    bool Function(Route<dynamic> route) removeUntilPredicate,
    List<SailorTransition> transitions,
    Duration transitionDuration,
    Map<String, dynamic> params,
    CustomSailorTransition customTransition,
  }) {
    //Go ahead and keep main assertions
    assert(name != null);
    assert(navigationType != null);
    assert(navigationType != NavigationType.pushAndRemoveUntil ||
        removeUntilPredicate != null);

    if (!_routeNameMappings.containsKey(name)) {
      if (options.handleNameNotFoundUI) {
        attempts.add(RoutingAttempt(
          name: '{{PageNotFound}}',
          type: NavigationType.push,
        ));
      }
      throw RouteNotFoundError(name: name);
    }

    final routeParams = _routeParamsMappings[name];
    if (routeParams != null) {
      routeParams.forEach((key, value) {
        // Type of paramter passed should be the same
        // when type is declared.
        if (params.containsKey(value.name) && params[value.name] != null) {
          final passedParamType = params[value.name].runtimeType;
          assert(passedParamType == value.paramType);
        }

        // All paramters that are 'required' should be passed.
        final isMissingRequiredParam = value.isRequired &&
            (params == null || !params.containsKey(value.name));

        assert(!isMissingRequiredParam);
      });
    }

    final argsWrapper = ArgumentsWrapper(
      baseArguments: args,
      transitions: transitions,
      transitionDuration: transitionDuration,
      transitionCurve: null, //Probably a bug in Sailor; call doesn't have
      params: params,
      routeParams: _routeParamsMappings[name],
      customTransition: customTransition,
    );

    // Evaluate if the route can be opend using route guard.
    final route = _routeNameMappings[name];

    // Skip route guards. We just care about routing attempt

    attempts.add(RoutingAttempt(
      name: name,
      route: route,
      args: args,
      params: params,
      removeUntilPredicate: removeUntilPredicate,
      type: navigationType,
      wrapper: argsWrapper,
    ));
  }

  @override
  RouteFactory generator() {
    return (settings) => MaterialPageRoute(
          builder: (context) => Container(),
        );
  }

  // MOCK ACCESS POINTS
  List<RoutingAttempt> attempts = [];

  void clear() {
    _routeNameMappings.clear();
    _routeParamsMappings.clear();
    attempts.clear();
  }
}

class RoutingAttempt {
  RoutingAttempt({
    @required this.name,
    this.route,
    this.args,
    this.params,
    this.removeUntilPredicate,
    @required this.type,
    this.wrapper,
  });

  String name;
  SailorRoute route;
  BaseArguments args;
  Map<String, dynamic> params;
  bool Function(Route<dynamic> route) removeUntilPredicate;
  NavigationType type;
  ArgumentsWrapper wrapper;
}
