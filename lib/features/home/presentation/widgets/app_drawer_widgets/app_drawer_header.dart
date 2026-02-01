import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/core/utils/jwt_token_decoder.dart';
import 'package:pingvite/core/services/secure_storage_service.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class AppDrawerHeader extends StatefulWidget {
  const AppDrawerHeader({super.key});

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AppTexts(text: 'Welcome, $_userName', style: textTheme.bold),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, color: AppColors.darkPrimaryText),
          ),
        ],
      ),
    );
  }
}
