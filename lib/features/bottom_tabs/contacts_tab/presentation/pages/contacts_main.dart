import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/constants/enum_tabs.dart';
import 'package:pingvite/core/custom_widgets/custom_fab.dart';
import 'package:pingvite/core/custom_widgets/reusable_tab_widget.dart';
import 'package:pingvite/core/model/tab_item.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/event_creation_tabs/attendees_screen/presentation/widgets/attendees_tile.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class ContactModel extends ISuspensionBean {
  final Map<String, String> data;
  final String tagIndex;

  ContactModel({required this.data, required this.tagIndex});

  @override
  String getSuspensionTag() => tagIndex;
}

class ContactsMain extends StatefulWidget {
  const ContactsMain({super.key});

  @override
  State<ContactsMain> createState() => _ContactsMainState();
}

class _ContactsMainState extends State<ContactsMain> {
  int _selectedIndex = 0;
  List<ContactModel> contactModels = [];

  final List<String> tabs = [
    Constants.allContacts,
    Constants.friends,
    Constants.completed,
    Constants.draft,
  ];

  @override
  void initState() {
    super.initState();
    _prepareContactsData();
  }

  void _prepareContactsData() {
    // Sample data with different names for testing alphabets
    final List<Map<String, String>> attendees = [
      {
        "name": "Alice Johnson",
        "email": "alice@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Bob Wilson",
        "email": "bob@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Charlie Brown",
        "email": "charlie@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "David Miller",
        "email": "david@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Emma Davis",
        "email": "emma@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Frank Garcia",
        "email": "frank@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Grace Lee",
        "email": "grace@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Henry Taylor",
        "email": "henry@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Iris Anderson",
        "email": "iris@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Jack Thompson",
        "email": "jack@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Kate Williams",
        "email": "kate@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Liam Rodriguez",
        "email": "liam@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Maya Patel",
        "email": "maya@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Noah Martinez",
        "email": "noah@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Olivia Lopez",
        "email": "olivia@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Paul Gonzalez",
        "email": "paul@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Quinn White",
        "email": "quinn@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Rachel Green",
        "email": "rachel@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Stave Smith",
        "email": "stavesmith@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Tina Turner",
        "email": "tina@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Uma Singh",
        "email": "uma@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Victor Hugo",
        "email": "victor@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Wendy Clark",
        "email": "wendy@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Xavier King",
        "email": "xavier@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Yara Ali",
        "email": "yara@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
      {
        "name": "Zoe Parker",
        "email": "zoe@gmail.com",
        "tag": "Friend",
        "image": Constants.sample,
      },
    ];

    // Convert to ContactModel for alphabetical sorting
    contactModels = attendees.map((attendee) {
      String firstLetter = attendee['name']!.substring(0, 1).toUpperCase();
      return ContactModel(data: attendee, tagIndex: firstLetter);
    }).toList();

    // Sort alphabetically
    contactModels.sort((a, b) => a.data['name']!.compareTo(b.data['name']!));
    SuspensionUtil.sortListBySuspensionTag(contactModels);
    SuspensionUtil.setShowSuspensionStatus(contactModels);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 12.0,
            ),
            child: ReusableTabWidget(
              style: TabStyle.boxy,
              showContent: false,
              tabs: tabs.map((title) => TabItem(title: title)).toList(),
              onTabChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
          Expanded(child: _buildTabContent(tabs[_selectedIndex])),
        ],
      ),
      floatingActionButton: CustomFAB(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.createEvent);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildTabContent(String tabName) {
    final indexLetters = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
    ];

    // Dynamically calculate item height based on screen height
    final maxAllowed = SizeConfig.screenHeight / indexLetters.length;

    return AzListView(
      data: contactModels,
      itemCount: contactModels.length,
      padding: EdgeInsets.symmetric(
        horizontal: sl<SizeConfig>().rpx(15),
        vertical: sl<SizeConfig>().rpx(5),
      ),
      indexBarItemHeight: maxAllowed.clamp(14, 22), // safe min/max range
      indexBarMargin: const EdgeInsets.symmetric(vertical: 12),
      itemBuilder: (context, index) {
        return AttendeeTile(
          attendee: contactModels[index].data,
          isVisible: false,
        );
      },
      susItemBuilder: (context, index) => Container(),
      indexBarData: indexLetters,
      indexBarOptions: IndexBarOptions(
        needRebuild: true,
        downTextStyle: const TextStyle(fontSize: 12, color: Colors.white),
        downItemDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.circleColor1,
        ),
      ),
    );
  }
}
