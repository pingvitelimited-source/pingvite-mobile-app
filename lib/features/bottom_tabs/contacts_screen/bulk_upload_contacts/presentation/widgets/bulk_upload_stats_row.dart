import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/count_badge.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/size_extension.dart';

/// Widget displaying Total Contacts count for bulk upload
class BulkUploadStatsRow extends StatelessWidget {
  final int totalContacts;

  const BulkUploadStatsRow({super.key, required this.totalContacts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.rpx),
      child: Row(
        children: [
          CountBadge(
            label: 'Total Contacts',
            count: totalContacts,
            badgeColor: AppColors.labelBlue,
          ),
        ],
      ),
    );
  }
}
