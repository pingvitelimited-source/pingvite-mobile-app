import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/data/sample_contacts_data.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/create_new_contact_list/presentation/widgets/contact_list_bottom_button.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/create_new_contact_list/presentation/widgets/contact_list_header.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/create_new_contact_list/presentation/widgets/contact_list_view.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';

class CreateNewContactListPage extends StatefulWidget {
  const CreateNewContactListPage({super.key});

  @override
  State<CreateNewContactListPage> createState() =>
      _CreateNewContactListPageState();
}

class _CreateNewContactListPageState extends State<CreateNewContactListPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final Set<int> _selectedIndices = {};
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
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar.withBackButton(title: 'Contact List'),
      body: SafeArea(
        child: Column(
          children: [
            // Fixed header section
            ContactListHeader(
              formKey: _formKey,
              totalContacts: _contacts.length,
              selectedCount: _selectedIndices.length,
            ),

            // Scrollable contacts list
            Expanded(
              child: ContactListView(
                contacts: _contacts,
                selectedIndices: _selectedIndices,
                onContactTap: _toggleSelection,
                onContactDelete: _deleteContact,
              ),
            ),

            // Bottom button
            ContactListBottomButton(
              isLoading: _isLoading,
              onPressed: _handleUpdateContactList,
            ),
          ],
        ),
      ),
    );
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  void _deleteContact(int index) {
    setState(() {
      _selectedIndices.remove(index);
      // Update indices greater than removed index
      final updatedIndices = _selectedIndices
          .map((i) => i > index ? i - 1 : i)
          .toSet();
      _selectedIndices.clear();
      _selectedIndices.addAll(updatedIndices);
      _contacts.removeAt(index);
    });
  }

  void _handleUpdateContactList() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value;

      setState(() => _isLoading = true);
      debugPrint('Form Data: $formData');
      debugPrint('Selected Contacts: ${_selectedIndices.length}');

      // Simulate API call
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() => _isLoading = false);
          Navigator.pop(context);
        }
      });
    }
  }
}
