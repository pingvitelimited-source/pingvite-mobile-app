import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/create_new_contact_list/presentation/widgets/contact_list_stats_row.dart';

/// Header section with text field and stats
class ContactListHeader extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final int totalContacts;
  final int selectedCount;

  const ContactListHeader({
    super.key,
    required this.formKey,
    required this.totalContacts,
    required this.selectedCount,
  });

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.rpx),
      child: FormBuilder(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 16.rpx),

            // Contact List Name TextField
            TextFieldFactory.name(
              context: context,
              buttonTheme: buttonTheme,
              name: 'contact_list_name',
              hintText: 'Contacts List Name',
              requiredError: 'List name is required',
              minLengthError: 'Name must be at least 2 characters',
            ),

            SizedBox(height: 24.rpx),

            // Stats Row
            ContactListStatsRow(
              totalContacts: totalContacts,
              selectedCount: selectedCount,
            ),

            SizedBox(height: 16.rpx),
          ],
        ),
      ),
    );
  }
}
