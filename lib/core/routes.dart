import 'package:flutter/material.dart';
import 'package:pingvite/features/auth/signin/presentation/pages/signin_page.dart';
import 'package:pingvite/features/auth/signup/presentation/pages/signup_screen.dart';
import 'package:pingvite/features/create_event_screen/presentation/pages/create_event_screen.dart';
import 'package:pingvite/features/create_venue_screen/presentation/pages/create_venue_screen.dart';
import 'package:pingvite/features/dashboard/presentation/pages/dashboard.dart';
import 'package:pingvite/features/forgot_password/presentation/pages/forgot_password_screen.dart';

class AppRoutes {
  static const String signin = '/signin';
  static const String dashboard = '/dashboard';
  static const String createEvent = '/createEvent';
  static const String createVenue = '/createVenue';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgotPassword';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signin:
        final authType = settings.arguments as int?;
        return MaterialPageRoute(
          builder: (_) => SigninPage(authType: authType),
        );
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const Dashboard());
      case createEvent:
        return MaterialPageRoute(builder: (_) => const CreateEventScreen());
      case createVenue:
        return MaterialPageRoute(builder: (_) => const CreateVenueScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
