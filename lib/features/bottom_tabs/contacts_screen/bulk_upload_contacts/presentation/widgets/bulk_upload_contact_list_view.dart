import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/selectable_contact_tile.dart';
import 'package:pingvite/core/utils/size_extension.dart';

/// ListView widget for displaying contacts without selection
class BulkUploadContactListView extends StatelessWidget {
  final List<Map<String, String>> contacts;
  final Function(int) onContactDelete;

  const BulkUploadContactListView({
    super.key,
    required this.contacts,
    required this.onContactDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.rpx),
      physics: const BouncingScrollPhysics(),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];

        return SelectableContactTile(
          contact: contact,
          isSelected: false,
          showSelection: false,
          showDeleteIcon: true,
          showDivider: true,
          onDelete: () => onContactDelete(index),
        );
      },
    );
  }
}
