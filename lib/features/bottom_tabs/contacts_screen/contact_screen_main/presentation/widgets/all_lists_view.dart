import 'package:flutter/material.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/data/contact_list_data.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/presentation/widgets/contact_list_tile.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class AllListsView extends StatelessWidget {
  final List<ContactListData> contactLists;
  final void Function(ContactListData)? onEdit;
  final void Function(ContactListData)? onDelete;

  const AllListsView({
    super.key,
    required this.contactLists,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: sl<SizeConfig>().rpx(15),
        vertical: sl<SizeConfig>().rpx(10),
      ),
      itemCount: contactLists.length,
      itemBuilder: (context, index) {
        return ContactListTile(
          listData: contactLists[index],
          onEdit: onEdit != null ? () => onEdit!(contactLists[index]) : null,
          onDelete: onDelete != null
              ? () => onDelete!(contactLists[index])
              : null,
        );
      },
    );
  }
}
