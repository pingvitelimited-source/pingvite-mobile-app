import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/core/utils/theme_helper.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/bulk_upload_contacts/presentation/widgets/bulk_upload_bottom_button.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/bulk_upload_contacts/presentation/widgets/bulk_upload_contact_list_view.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/bulk_upload_contacts/presentation/widgets/bulk_upload_header.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/bulk_upload_contacts/presentation/widgets/bulk_upload_stats_row.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/data/sample_contacts_data.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';

class BulkUploadContactsPage extends StatefulWidget {
  const BulkUploadContactsPage({super.key});

  @override
  State<BulkUploadContactsPage> createState() => _BulkUploadContactsPageState();
}

class _BulkUploadContactsPageState extends State<BulkUploadContactsPage> {
  late List<Map<String, String>> _contacts;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _contacts = List.from(SampleContactsData.attendees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeHelper.backgroundColor(context),
      appBar: const CustomAppBar.withBackButton(title: Constants.bulkUpload),
      body: SafeArea(
        child: Column(
          children: [
            // Header with upload field and button
            BulkUploadHeader(onUploadFile: _handleUploadFile),

            // Stats row
            BulkUploadStatsRow(totalContacts: _contacts.length),

            SizedBox(height: 16.rpx),

            // Scrollable contacts list
            Expanded(
              child: BulkUploadContactListView(
                contacts: _contacts,
                onContactDelete: _deleteContact,
              ),
            ),

            // Bottom button
            BulkUploadBottomButton(
              isLoading: _isLoading,
              onPressed: _handleImportContacts,
            ),
          ],
        ),
      ),
    );
  }

  void _handleUploadFile() {
    debugPrint('Upload file tapped');
  }

  void _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  void _handleImportContacts() {
    if (_contacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: AppTexts(text: 'No contacts to import')),
      );
      return;
    }

    setState(() => _isLoading = true);

    debugPrint('Importing ${_contacts.length} contacts');

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pop(context);
      }
    });
  }
}
