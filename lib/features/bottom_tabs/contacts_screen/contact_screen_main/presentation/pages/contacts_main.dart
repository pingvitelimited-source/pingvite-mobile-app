import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/constants/enum_tabs.dart';
import 'package:pingvite/core/custom_widgets/custom_fab.dart';
import 'package:pingvite/core/custom_widgets/reusable_tab_widget.dart';
import 'package:pingvite/core/model/tab_item.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/data/contact_list_data.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/data/contact_model.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/data/sample_contacts_data.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/presentation/widgets/all_contacts_view.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/presentation/widgets/all_lists_view.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/presentation/widgets/contact_options_dialog.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/create_new_contact/presentation/pages/create_new_contacts_page.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/create_new_contact_list/presentation/pages/create_new_contact_list_page.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/bulk_upload_contacts/presentation/pages/bulk_upload_contacts_page.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';

class ContactsMain extends StatefulWidget {
  const ContactsMain({super.key});

  @override
  State<ContactsMain> createState() => _ContactsMainState();
}

class _ContactsMainState extends State<ContactsMain> {
  int _selectedIndex = 0;
  List<ContactModel> _contactModels = [];
  List<ContactListData> _contactLists = [];

  static const List<String> _tabs = [
    Constants.allContacts,
    Constants.allList,
    Constants.completed,
    Constants.draft,
  ];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    _contactLists = SampleContactsData.contactLists;
    _contactModels = _prepareContactModels(SampleContactsData.attendees);
  }

  List<ContactModel> _prepareContactModels(
    List<Map<String, String>> attendees,
  ) {
    final models = attendees.map((attendee) {
      final firstLetter = attendee['name']!.substring(0, 1).toUpperCase();
      return ContactModel(data: attendee, tagIndex: firstLetter);
    }).toList();

    models.sort((a, b) => a.data['name']!.compareTo(b.data['name']!));
    SuspensionUtil.sortListBySuspensionTag(models);
    SuspensionUtil.setShowSuspensionStatus(models);

    return models;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar.withBackButton(title: 'My Contacts'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: ReusableTabWidget(
              style: TabStyle.boxy,
              showContent: false,
              tabs: _tabs.map((title) => TabItem(title: title)).toList(),
              onTabChanged: (index) {
                setState(() => _selectedIndex = index);
              },
            ),
          ),
          Expanded(child: _buildTabContent()),
        ],
      ),
      floatingActionButton: CustomFAB(
        onPressed: () => _showContactOptions(context),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_tabs[_selectedIndex]) {
      case Constants.allList:
        return AllListsView(
          contactLists: _contactLists,
          onEdit: _handleEditList,
          onDelete: _handleDeleteList,
        );
      case Constants.allContacts:
      default:
        return AllContactsView(contactModels: _contactModels);
    }
  }

  void _handleEditList(ContactListData listData) {}

  void _handleDeleteList(ContactListData listData) {}

  Future<void> _showContactOptions(BuildContext context) async {
    final navigator = Navigator.of(context);
    final action = await ContactOptionsDialog.show(context);
    if (action == null || !mounted) return;

    switch (action) {
      case ContactAction.createContact:
        navigator.push(
          MaterialPageRoute(builder: (_) => const CreateNewContactsPage()),
        );
        break;
      case ContactAction.createList:
        navigator.push(
          MaterialPageRoute(builder: (_) => const CreateNewContactListPage()),
        );
        break;
      case ContactAction.bulkUpload:
        navigator.push(
          MaterialPageRoute(builder: (_) => const BulkUploadContactsPage()),
        );
        break;
    }
  }
}
