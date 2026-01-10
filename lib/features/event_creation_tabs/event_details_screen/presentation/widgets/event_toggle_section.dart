import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_card_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class EventToggleSection extends StatelessWidget {
  final bool eventLive;
  final bool promotion;
  final bool registration;
  final bool ticketing;
  final bool rsvp;
  final ValueChanged<bool> onEventLiveChanged;
  final ValueChanged<bool> onPromotionChanged;
  final ValueChanged<bool> onRegistrationChanged;
  final ValueChanged<bool> onTicketingChanged;
  final ValueChanged<bool> onRsvpChanged;

  const EventToggleSection({
    super.key,
    required this.eventLive,
    required this.promotion,
    required this.registration,
    required this.ticketing,
    required this.rsvp,
    required this.onEventLiveChanged,
    required this.onPromotionChanged,
    required this.onRegistrationChanged,
    required this.onTicketingChanged,
    required this.onRsvpChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ToggleRow(
          label: "Event Live",
          value: eventLive,
          onChanged: onEventLiveChanged,
        ),
        Gap(sl<SizeConfig>().rpx(16)),
        _ToggleRow(
          label: "Promotion",
          value: promotion,
          onChanged: onPromotionChanged,
        ),
        Gap(sl<SizeConfig>().rpx(16)),
        _ToggleRow(
          label: "Registration",
          value: registration,
          onChanged: onRegistrationChanged,
        ),
        Gap(sl<SizeConfig>().rpx(16)),
        _ToggleRow(
          label: "Ticketing",
          value: ticketing,
          onChanged: onTicketingChanged,
        ),
        Gap(sl<SizeConfig>().rpx(16)),
        _ToggleRow(label: "RSVP", value: rsvp, onChanged: onRsvpChanged),
      ],
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final cardTheme = Theme.of(context).extension<AppCardTheme>()!;
    final screenWidth = MediaQuery.of(context).size.width;
    final toggleWidth = screenWidth * 0.6; // 60% of screen width for alignment

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: toggleWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTexts(
                text: label,
                style: textTheme.body2.copyWith(
                  fontWeight: FontWeight.w500,
                  color: cardTheme.sectionLabelColor,
                ),
              ),
              Transform.scale(
                scale: 0.9,
                child: Switch(
                  value: value,
                  onChanged: onChanged,
                  activeThumbColor: AppColors.white,
                  activeTrackColor: AppColors.blue,
                  inactiveThumbColor: AppColors.white,
                  inactiveTrackColor: AppColors.grey.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
