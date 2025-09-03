import 'package:flutter/material.dart';
import 'package:pingvite/features/auth/signin/presentation/pages/signin_page.dart';
import 'package:pingvite/features/create_event_screen/presentation/pages/create_event_screen.dart';
import 'package:pingvite/features/dashboard/presentation/pages/dashboard.dart';

class AppRoutes {
  static const String signin = '/signin';
  static const String dashboard = '/dashboard';
  static const String createEvent = '/createEvent';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signin:
        return MaterialPageRoute(builder: (_) => const SigninPage());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const Dashboard());
      case createEvent:
        return MaterialPageRoute(builder: (_) => const CreateEventScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
