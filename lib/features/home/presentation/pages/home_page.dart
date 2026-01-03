import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/core/enums/event_card_type.dart';
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
import 'package:pingvite/service_locator_dependencies.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final cardTheme = Theme.of(context).extension<AppCardTheme>()!;

    return Scaffold(
      backgroundColor: cardTheme.screenBackgroundColor,
      key: _scaffoldKey,
      appBar: CustomAppBar.withLocation(
        location: 'Mumbai',
        onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
        onLocationTap: () {
          // open city picker
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
            const HomeQuickActions(),
            Gap(15.gap),
            const EventCategoryStrip(),
            Gap(20.gap),
            EventSection(
              title: 'Discover Events',
              type: EventCardType.event,
              events: discoverEvents,
              onViewMore: () {},
            ),
            Gap(20.gap),
            EventSection(
              title: 'Discover Activities',
              type: EventCardType.activity,
              events: discoverActivities,
            ),
            Gap(20.gap),
            EventSection(
              title: 'Free Events',
              type: EventCardType.event,
              events: freeEvents,
            ),
            Gap(20.gap),
            EventSection(
              title: 'Conferences',
              type: EventCardType.event,
              events: conferenceEvents,
            ),
          ],
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
