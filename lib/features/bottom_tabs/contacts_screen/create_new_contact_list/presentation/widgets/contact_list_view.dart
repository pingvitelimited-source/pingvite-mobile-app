import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/selectable_contact_tile.dart';
import 'package:pingvite/core/utils/size_extension.dart';

/// ListView widget for displaying selectable contacts
class ContactListView extends StatelessWidget {
  final List<Map<String, String>> contacts;
  final Set<int> selectedIndices;
  final Function(int) onContactTap;
  final Function(int) onContactDelete;

  const ContactListView({
    super.key,
    required this.contacts,
    required this.selectedIndices,
    required this.onContactTap,
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
        final isSelected = selectedIndices.contains(index);

        return SelectableContactTile(
          contact: contact,
          isSelected: isSelected,
          showSelection: true,
          showDeleteIcon: true,
          showDivider: true,
          onTap: () => onContactTap(index),
          onDelete: () => onContactDelete(index),
        );
      },
    );
  }
}
