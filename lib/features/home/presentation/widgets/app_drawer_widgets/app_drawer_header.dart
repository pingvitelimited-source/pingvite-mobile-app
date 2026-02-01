import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/core/utils/jwt_token_decoder.dart';
import 'package:pingvite/core/services/secure_storage_service.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class AppDrawerHeader extends StatefulWidget {
  final VoidCallback? onSegmentTap;

  const AppDrawerHeader({super.key, this.onSegmentTap});

  @override
  State<AppDrawerHeader> createState() => _AppDrawerHeaderState();
}

class _AppDrawerHeaderState extends State<AppDrawerHeader> {
  String _userName = 'User';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    try {
      final secureStorage = sl<SecureStorageService>();
      final token = await secureStorage.getAccessToken();

      if (token != null && token.isNotEmpty) {
        final firstName = JwtTokenDecoder.getFirstName(token) ?? 'User';

        if (mounted) {
          setState(() => _userName = firstName);
        }
      }
    } catch (e) {
      debugPrint('Error loading user name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      height: sl<SizeConfig>().rpx(80),
      padding: EdgeInsets.symmetric(horizontal: sl<SizeConfig>().rpx(20)),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.lightGradient, AppColors.darkGradient],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: AppTexts(
              text: Constants.drawerWelcomePrefix + _userName,
              style: textTheme.bold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          if (widget.onSegmentTap != null)
            GestureDetector(
              onTap: widget.onSegmentTap,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: AppImages.svgIcon(
                  context,
                  Constants.toggleIcon,
                  25,
                  25,
                  AppColors.darkPrimaryText,
                ),
              ),
            ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, color: AppColors.darkPrimaryText),
          ),
        ],
      ),
    );
  }
}
