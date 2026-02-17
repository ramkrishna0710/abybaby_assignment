import 'package:assignment_abybaby/features/auth/login/screens/login_screen.dart';
import 'package:assignment_abybaby/features/auth/register/screen/register_screen.dart';
import 'package:assignment_abybaby/features/notification/screen/dealer_notification_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/splash/screen/splash_screen.dart';
import '../my_app.dart';
import 'app_routes.dart';

enum TransitionType {
  fade,
  slide,
  fadeSlide,
  scale,
  scaleOut,
  bottomToTop,
  dockGrow,
  topRightGrow,
  bottomRightGrow,
  none,
}

class AppRouterConfig {
  late final GoRouter router = GoRouter(
    routes: _routes,
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: AppRoute.root,
  );

  late final _routes = <RouteBase>[
    GoRoute(
      path: AppRoute.root,
      name: AppRoute.root,
      pageBuilder: (context, state) => buildTransitionPage(
        child: const SplashScreen(),
        state: state,
        type: TransitionType.scale,
      ),
    ),
    GoRoute(
      path: AppRoute.login,
      name: AppRoute.login,
      pageBuilder: (context, state) => buildTransitionPage(
        child: const LoginScreen(),
        state: state,
        type: TransitionType.scale,
      ),
    ),
    GoRoute(
      path: AppRoute.register,
      name: AppRoute.register,
      pageBuilder: (context, state) => buildTransitionPage(
        child: const RegisterScreen(),
        state: state,
        type: TransitionType.scale,
      ),
    ),
    GoRoute(
      path: AppRoute.dealerNotificationListScreen,
      name: AppRoute.dealerNotificationListScreen,
      pageBuilder: (context, state) => buildTransitionPage(
        child: const DealerNotificationListScreen(),
        state: state,
        type: TransitionType.slide,
      ),
    ),
  ];

  void dispose() {}

  CustomTransitionPage buildTransitionPage({
    required Widget child,
    required GoRouterState state,
    int duration = 300,
    TransitionType type = TransitionType.slide,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: Duration(milliseconds: duration),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (type) {
          case TransitionType.fade:
            return FadeTransition(opacity: animation, child: child);
          case TransitionType.slide:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0), // right to left
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case TransitionType.scale:
            return ScaleTransition(scale: animation, child: child);
          case TransitionType.scaleOut:
            final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            );

            final scale = Tween<double>(begin: 1.55, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            );

            return FadeTransition(
              opacity: fade,
              child: ScaleTransition(scale: scale, child: child),
            );
          case TransitionType.bottomToTop:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1), // 👈 bottom to top
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case TransitionType.fadeSlide:
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );

            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.05), // small slide from bottom
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          case TransitionType.dockGrow:
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );

            return Align(
              alignment: Alignment.bottomCenter,
              child: ScaleTransition(
                alignment: Alignment.bottomCenter, // 👈 grow from bottom
                scale: Tween<double>(
                  begin: 0.2, // start small like dock icon
                  end: 1.0,
                ).animate(curved),
                child: FadeTransition(opacity: curved, child: child),
              ),
            );

          case TransitionType.none:
            return child;

          case TransitionType.topRightGrow:
          case TransitionType.bottomRightGrow:
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );

            return Align(
              alignment: type == TransitionType.topRightGrow
                  ? Alignment.topRight
                  : Alignment.bottomRight,
              child: ScaleTransition(
                alignment: type == TransitionType.topRightGrow
                    ? Alignment.topRight
                    : Alignment.bottomRight,
                scale: Tween<double>(
                  begin: 0.2, // start very small
                  end: 1.0,
                ).animate(curved),
                child: FadeTransition(opacity: curved, child: child),
              ),
            );
        }
      },
    );
  }
}
