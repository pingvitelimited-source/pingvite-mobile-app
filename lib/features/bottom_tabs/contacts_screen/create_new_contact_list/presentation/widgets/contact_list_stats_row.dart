import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/count_badge.dart';
import 'package:pingvite/core/theme/app_colors.dart';

/// Widget displaying Total Contacts and Selected counts
class ContactListStatsRow extends StatelessWidget {
  final int totalContacts;
  final int selectedCount;

  const ContactListStatsRow({
    super.key,
    required this.totalContacts,
    required this.selectedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CountBadge(
          label: 'Total Contacts',
          count: totalContacts,
          badgeColor: AppColors.labelBlue,
        ),
        CountBadge(
          label: 'Selected',
          count: selectedCount,
          badgeColor: AppColors.labelBlue,
        ),
      ],
    );
  }
}
