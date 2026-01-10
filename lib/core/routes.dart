import 'package:flutter/material.dart';
import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/features/auth/signin/presentation/pages/signin_page.dart';
import 'package:pingvite/features/auth/signup/presentation/pages/signup_screen.dart';
import 'package:pingvite/features/booking_selection_screen/presentation/pages/booking_selection_page.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/presentation/pages/contacts_main.dart';
import 'package:pingvite/features/bottom_tabs/venue_screen/presentation/pages/venue_tab.dart';
import 'package:pingvite/features/create_event_screen/presentation/pages/create_event_screen.dart';
import 'package:pingvite/features/create_venue_screen/presentation/pages/create_venue_screen.dart';
import 'package:pingvite/features/dashboard/presentation/pages/dashboard.dart';
import 'package:pingvite/features/event_info_screen/presentation/pages/event_info.dart';
import 'package:pingvite/features/forgot_password/presentation/pages/forgot_password_screen.dart';
import 'package:pingvite/features/inital_screen/presentation/pages/initial_page.dart';
import 'package:pingvite/features/pay_screen/domain/pay_screen_args.dart';
import 'package:pingvite/features/pay_screen/presentation/pages/pay_screen.dart';
import 'package:pingvite/features/home/presentation/pages/home_page.dart';
import 'package:pingvite/features/location_selection/presentation/pages/location_selection_screen.dart';

class AppRoutes {
  static const String initial = '/initial';
  static const String signin = '/signin';
  static const String dashboard = '/dashboard';
  static const String home = '/home';
  static const String createEvent = '/createEvent';
  static const String createVenue = '/createVenue';
  static const String myContacts = '/myContacts';
  static const String myVenues = '/myVenues';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgotPassword';
  static const String eventInfo = '/eventInfo';
  static const String bookingSelection = '/bookingSelection';
  static const String pay = '/pay';
  static const String locationSelection = '/locationSelection';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (_) => const InitialPage());
      case signin:
        final authType = settings.arguments as int?;
        return MaterialPageRoute(
          builder: (_) => SigninPage(authType: authType),
        );
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const Dashboard());
      case createEvent:
        return MaterialPageRoute(builder: (_) => const CreateEventScreen());
      case createVenue:
        return MaterialPageRoute(builder: (_) => const CreateVenueScreen());
      case myContacts:
        return MaterialPageRoute(builder: (_) => const ContactsMain());
      case myVenues:
        return MaterialPageRoute(builder: (_) => const VenueTab());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case eventInfo:
        final data = settings.arguments as EventCardData?;
        return MaterialPageRoute(builder: (_) => EventInfo(data: data));
      case bookingSelection:
        final data = settings.arguments as EventCardData?;
        return MaterialPageRoute(
          builder: (_) => BookingSelectionPage(data: data),
        );
      case pay:
        final args = settings.arguments as PayScreenArgs;
        return MaterialPageRoute(builder: (_) => PayScreen(args: args));
      case locationSelection:
        return MaterialPageRoute(
          builder: (_) => const LocationSelectionScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
