import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/core/enums/event_card_type.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_card_theme.dart';
import 'package:pingvite/core/utils/banner_image.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:pingvite/features/home/presentation/widgets/app_drawer_widgets/app_drawer.dart';
import 'package:pingvite/features/home/presentation/widgets/event_catergory_widgets/event_category_strip.dart';
import 'package:pingvite/features/home/presentation/widgets/event_widgets/event_section.dart';
import 'package:pingvite/features/home/presentation/widgets/quick_action_widgets/home_quick_actions.dart';
import 'package:pingvite/features/location_selection/presentation/bloc/location_bloc.dart';
import 'package:pingvite/features/location_selection/data/repositories/location_repository.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String? _selectedCity;

  @override
  void initState() {
    super.initState();
    _selectedCity = null;
    // Clear any pending snackbars when entering home
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
      }
    });
    _checkLocationAndNavigate();
  }

  Future<void> _checkLocationAndNavigate() async {
    // Check if location is already saved
    final locationRepo = sl<LocationRepository>();
    final isSaved = await locationRepo.isLocationSaved();

    if (!mounted) return;

    if (!isSaved) {
      // First login - navigate to location selection
      if (mounted) {
        Navigator.of(
          context,
          rootNavigator: true,
        ).pushNamed(AppRoutes.locationSelection).then((result) {
          if (result is Map<String, dynamic>) {
            final cityName = result['city'] as String?;
            if (cityName != null && mounted) {
              setState(() {
                _selectedCity = cityName;
              });
            }
          }
        });
      }
    } else {
      // Already saved - load location
      context.read<LocationBloc>().add(const LoadCurrentLocationEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardTheme = Theme.of(context).extension<AppCardTheme>()!;

    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationLoaded) {
          setState(() {
            _selectedCity = state.cityName;
          });
        } else if (state is CitySelected) {
          setState(() {
            _selectedCity = state.cityName;
          });
        }
      },
      child: Scaffold(
        backgroundColor: cardTheme.screenBackgroundColor,
        key: _scaffoldKey,
        appBar: CustomAppBar.withLocation(
          location: _selectedCity ?? 'Select City',
          onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
          onLocationTap: () {
            Navigator.pushNamed(context, AppRoutes.locationSelection).then((
              result,
            ) {
              if (result is Map<String, dynamic>) {
                final cityName = result['city'] as String?;
                if (cityName != null) {
                  setState(() {
                    _selectedCity = cityName;
                  });
                  _showLocationUpdateToast(cityName);
                }
              }
            });
          },
        ),
        drawer: const AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(sl<SizeConfig>().rpx(15)),
                child: TextFieldFactory.search(
                  context: context,
                  buttonTheme: Theme.of(context).extension<AppButtonTheme>()!,
                  onChanged: (value) {
                    // live search
                  },
                  onSearchTap: () {
                    // search icon tapped
                  },
                ),
              ),
              Gap(sl<SizeConfig>().rpx(5)),
              BannerImage(),
              Gap(15.gap),
              HomeQuickActions(selectedCity: _selectedCity),
              Gap(15.gap),
              const EventCategoryStrip(),
              Gap(20.gap),
              EventSection(
                title: 'Discover Events',
                type: EventCardType.event,
                events: discoverEvents,
                onViewMore: () => _navigateToEventsList(
                  'Discover Events',
                  discoverEvents,
                  EventCardType.event,
                ),
              ),
              Gap(20.gap),
              EventSection(
                title: 'Discover Activities',
                type: EventCardType.activity,
                events: discoverActivities,
                onViewMore: () => _navigateToEventsList(
                  'Discover Activities',
                  discoverActivities,
                  EventCardType.activity,
                ),
              ),
              Gap(20.gap),
              EventSection(
                title: 'Free Events',
                type: EventCardType.event,
                events: freeEvents,
                onViewMore: () => _navigateToEventsList(
                  'Free Events',
                  freeEvents,
                  EventCardType.event,
                ),
              ),
              Gap(20.gap),
              EventSection(
                title: 'Conferences',
                type: EventCardType.event,
                events: conferenceEvents,
                onViewMore: () => _navigateToEventsList(
                  'Conferences',
                  conferenceEvents,
                  EventCardType.event,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToEventsList(
    String title,
    List<EventCardData> events,
    EventCardType type,
  ) {
    Navigator.pushNamed(
      context,
      AppRoutes.eventsList,
      arguments: {'title': title, 'events': events, 'type': type},
    );
  }

  void _showLocationUpdateToast(String cityName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.location_on, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: AppTexts(
                text: 'Your location is updated to $cityName',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(sl<SizeConfig>().rpx(16)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sl<SizeConfig>().rpx(10)),
        ),
      ),
    );
  }
}

const discoverEvents = [
  EventCardData(
    image: 'assets/png/herobanner.png',
    title: 'Fintech Masterclass workshop',
    dateTime: '02 OCT | 02:00 PM',
    venue: 'Jio World Convention Center',
    price: 'From ₹100',
  ),
  EventCardData(
    image: 'assets/png/venue_image.png',
    title: 'Mumbai Founder Meet',
    dateTime: '27 OCT | 01:00 PM',
    venue: 'Somaiya Ground',
    price: 'From ₹500',
  ),
  EventCardData(
    image: 'assets/png/herobanner.png',
    title: 'Fintech Masterclass workshop',
    dateTime: '02 OCT | 02:00 PM',
    venue: 'Jio World Convention Center',
    price: 'From ₹100',
  ),
  EventCardData(
    image: 'assets/png/venue_image.png',
    title: 'Mumbai Founder Meet',
    dateTime: '27 OCT | 01:00 PM',
    venue: 'Somaiya Ground',
    price: 'From ₹500',
  ),
];

const freeEvents = [
  EventCardData(
    image: 'assets/png/herobanner.png',
    title: 'Fintech Masterclass workshop',
    dateTime: '02 OCT | 02:00 PM',
    venue: 'Jio World Convention Center',
    price: 'From ₹100',
  ),
  EventCardData(
    image: 'assets/png/venue_image.png',
    title: 'Mumbai Founder Meet',
    dateTime: '27 OCT | 01:00 PM',
    venue: 'Somaiya Ground',
    price: 'From ₹500',
  ),
  EventCardData(
    image: 'assets/png/herobanner.png',
    title: 'Fintech Masterclass workshop',
    dateTime: '02 OCT | 02:00 PM',
    venue: 'Jio World Convention Center',
    price: 'From ₹100',
  ),
  EventCardData(
    image: 'assets/png/venue_image.png',
    title: 'Mumbai Founder Meet',
    dateTime: '27 OCT | 01:00 PM',
    venue: 'Somaiya Ground',
    price: 'From ₹500',
  ),
  EventCardData(
    image: 'assets/png/herobanner.png',
    title: 'Fintech Masterclass workshop',
    dateTime: '02 OCT | 02:00 PM',
    venue: 'Jio World Convention Center',
    price: 'From ₹100',
  ),
  EventCardData(
    image: 'assets/png/venue_image.png',
    title: 'Mumbai Founder Meet',
    dateTime: '27 OCT | 01:00 PM',
    venue: 'Somaiya Ground',
    price: 'From ₹500',
  ),
];

const conferenceEvents = [
  EventCardData(
    image: 'assets/png/herobanner.png',
    title: 'Fintech Masterclass workshop',
    dateTime: '02 OCT | 02:00 PM',
    venue: 'Jio World Convention Center',
    price: 'From ₹100',
  ),
  EventCardData(
    image: 'assets/png/venue_image.png',
    title: 'Mumbai Founder Meet',
    dateTime: '27 OCT | 01:00 PM',
    venue: 'Somaiya Ground',
    price: 'From ₹500',
  ),
  EventCardData(
    image: 'assets/png/herobanner.png',
    title: 'Fintech Masterclass workshop',
    dateTime: '02 OCT | 02:00 PM',
    venue: 'Jio World Convention Center',
    price: 'From ₹100',
  ),
  EventCardData(
    image: 'assets/png/venue_image.png',
    title: 'Mumbai Founder Meet',
    dateTime: '27 OCT | 01:00 PM',
    venue: 'Somaiya Ground',
    price: 'From ₹500',
  ),
  EventCardData(
    image: 'assets/png/herobanner.png',
    title: 'Fintech Masterclass workshop',
    dateTime: '02 OCT | 02:00 PM',
    venue: 'Jio World Convention Center',
    price: 'From ₹100',
  ),
  EventCardData(
    image: 'assets/png/venue_image.png',
    title: 'Mumbai Founder Meet',
    dateTime: '27 OCT | 01:00 PM',
    venue: 'Somaiya Ground',
    price: 'From ₹500',
  ),
];

const discoverActivities = [
  EventCardData(image: Constants.banner, title: 'Bhandardara Trail'),
  EventCardData(image: Constants.banner, title: 'Lonavala Trail'),
];
