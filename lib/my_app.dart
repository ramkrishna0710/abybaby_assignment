import 'package:assignment_abybaby/data/repository/location/location_repository.dart';
import 'package:assignment_abybaby/domain/Location/location_bloc.dart';
import 'package:assignment_abybaby/domain/dealer/dealer_bloc.dart';
import 'package:assignment_abybaby/route/app_router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/auth/auth_repository.dart';
import 'data/repository/dealer/dealer_repository.dart';
import 'domain/auth/auth_bloc/auth_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouterConfig = AppRouterConfig();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository: AuthRepository()),
        ),
        BlocProvider(
          create: (context) => DealerBloc(dealerRepository: DealerRepository()),
        ),
        BlocProvider(
          create: (context) => LocationBloc(locationRepository: LocationRepository()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _appRouterConfig.router,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: child ?? const SizedBox.shrink(),
          );
        },
        theme: ThemeData.light(),
      ),
    );
  }
}
