import 'package:flutter/material.dart';
import 'package:pingvite/features/auth/signin/presentation/pages/signin_page.dart';

class AppRoutes {
  static const String signin = '/signin';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signin:
        return MaterialPageRoute(builder: (_) => const SigninPage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
