import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/data/contact_model.dart';
import 'package:pingvite/features/event_creation_tabs/attendees_screen/presentation/widgets/attendees_tile.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class AllContactsView extends StatelessWidget {
  final List<ContactModel> contactModels;

  const AllContactsView({super.key, required this.contactModels});

  static const List<String> _indexLetters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  @override
  Widget build(BuildContext context) {
    final maxAllowed = SizeConfig.screenHeight / _indexLetters.length;

    return AzListView(
      data: contactModels,
      itemCount: contactModels.length,
      padding: EdgeInsets.symmetric(
        horizontal: sl<SizeConfig>().rpx(15),
        vertical: sl<SizeConfig>().rpx(5),
      ),
      indexBarItemHeight: maxAllowed.clamp(14, 22),
      indexBarMargin: const EdgeInsets.symmetric(vertical: 12),
      itemBuilder: (context, index) {
        return AttendeeTile(
          attendee: contactModels[index].data,
          isVisible: false,
        );
      },
      susItemBuilder: (context, index) {
        final model = contactModels[index];
        return Container(
          height: 40,
          width: double.infinity,
          padding: EdgeInsets.only(left: sl<SizeConfig>().rpx(15)),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? const Color(0xFFF5F5F5)
                : const Color(0xFF2A2A2A),
          ),
          child: Text(
            model.getSuspensionTag(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.lightPrimaryText
                  : AppColors.darkPrimaryText,
            ),
          ),
        );
      },
      indexBarData: _indexLetters,
      indexBarOptions: IndexBarOptions(
        needRebuild: true,
        downTextStyle: const TextStyle(fontSize: 12, color: Colors.white),
        downItemDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.circleColor1,
        ),
      ),
    );
  }
}
