import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/constants/enum_tabs.dart';
import 'package:pingvite/core/custom_widgets/reusable_tab_widget.dart';
import 'package:pingvite/core/model/tab_item.dart';
import 'package:pingvite/features/event_creation_tabs/template_screen/presentation/widgets/tab_content.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({super.key});

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  int _selectedIndex = 0;

  final List<String> tabs = [
    Constants.allTemplate,
    Constants.wedding,
    Constants.birthday,
    Constants.corporate,
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
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
    );
  }

  Widget _buildTabContent(String tabName) {
    final dummyData = [
      {
        "id": 1,
        "title": "Graduation",
        "imageUrl": "https://picsum.photos/400/400",
      },
      {
        "id": 2,
        "title": "Grand Opening",
        "imageUrl": "https://picsum.photos/500",
      },
      {
        "id": 3,
        "title": "Webinar",
        "imageUrl": "https://picsum.photos/600/350",
      },
      {
        "id": 4,
        "title": "Night Party",
        "imageUrl": "https://picsum.photos/200",
      },
      {
        "id": 5,
        "title": "Pool Party",
        "imageUrl": "https://picsum.photos/500/300",
      },
      {
        "id": 6,
        "title": "Pool Party",
        "imageUrl": "https://picsum.photos/200/300",
      },
      {
        "id": 7,
        "title": "Pool Party",
        "imageUrl": "https://picsum.photos/400/300",
      },
      {
        "id": 8,
        "title": "Pool Party",
        "imageUrl": "https://picsum.photos/600/300",
      },
      {
        "id": 9,
        "title": "Pool Party",
        "imageUrl": "https://picsum.photos/550/300",
      },
      {
        "id": 10,
        "title": "Pool Party",
        "imageUrl": "https://picsum.photos/600/400",
      },
      {
        "id": 11,
        "title": "Pool Party",
        "imageUrl": "https://picsum.photos/200/300",
      },
      {
        "id": 12,
        "title": "Pool Party",
        "imageUrl": "https://picsum.photos/500/300",
      },
      {
        "id": 13,
        "title": "Pool Party",
        "imageUrl": "https://picsum.photos/500/300",
      },
      {
        "id": 14,
        "title": "Pool Party",
        "imageUrl": "https://picsum.photos/200/400",
      },
      {
        "id": 15,
        "title": "Pool Party",
        "imageUrl": "https://picsum.photos/300/350",
      },
    ];

    return TemplateGrid(templates: dummyData);
  }
}
