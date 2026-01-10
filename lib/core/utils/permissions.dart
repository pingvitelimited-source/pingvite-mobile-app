import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pingvite/core/custom_widgets/app_primary_buttons.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionManager {
  static const String _locationAskedKey = 'location_permission_asked';
  static const String _cameraAskedKey = 'camera_permission_asked';

  static Future<bool> hasLocationBeenAsked() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_locationAskedKey) ?? false;
  }

  static Future<bool> hasCameraBeenAsked() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_cameraAskedKey) ?? false;
  }

  static Future<void> markLocationAsAsked() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_locationAskedKey, true);
  }

  static Future<void> markCameraAsAsked() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_cameraAskedKey, true);
  }

  static Future<void> requestLocationPermission() async {
    await Permission.location.request();
  }

  static Future<void> requestCameraPermissions() async {
    await [Permission.camera, Permission.storage, Permission.photos].request();
  }
}

// Location Permission Dialog
class LocationPermissionDialog extends StatefulWidget {
  final VoidCallback onComplete;

  const LocationPermissionDialog({super.key, required this.onComplete});

  @override
  State<LocationPermissionDialog> createState() =>
      _LocationPermissionDialogState();
}

class _LocationPermissionDialogState extends State<LocationPermissionDialog> {
  bool _isRequesting = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;

    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on,
                size: 48,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 16),
              AppTexts(
                text: 'Location Permission',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              AppTexts(
                text:
                    'We need access to your location to provide location-based services and find nearby features.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isRequesting ? null : _handleDeny,
                      child: const AppTexts(text: 'Not Now'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppPrimaryButton(
                      title: 'Allow',
                      textTheme: textTheme,
                      buttonTheme: buttonTheme,
                      onPressed: _handleAllow,
                      isLoading: _isRequesting,
                      backgroundColor: AppColors.blue,
                      buttonTextColor: Colors.white,
                      textStyle: textTheme.body.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleAllow() async {
    setState(() => _isRequesting = true);

    await PermissionManager.requestLocationPermission();
    await PermissionManager.markLocationAsAsked();

    if (mounted) {
      Navigator.of(context).pop();
      widget.onComplete();
    }
  }

  Future<void> _handleDeny() async {
    await PermissionManager.markLocationAsAsked();

    if (mounted) {
      Navigator.of(context).pop();
      widget.onComplete();
    }
  }
}

// Camera Permission Dialog
class CameraPermissionDialog extends StatefulWidget {
  final VoidCallback onComplete;

  const CameraPermissionDialog({super.key, required this.onComplete});

  @override
  State<CameraPermissionDialog> createState() => _CameraPermissionDialogState();
}

class _CameraPermissionDialogState extends State<CameraPermissionDialog> {
  bool _isRequesting = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;

    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.camera_alt,
                size: 48,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 16),
              AppTexts(
                text: 'Camera & Gallery Permission',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              AppTexts(
                text:
                    'We need access to your camera and gallery to take photos, scan documents, and select images.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isRequesting ? null : _handleDeny,
                      child: const AppTexts(text: 'Not Now'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppPrimaryButton(
                      title: 'Allow',
                      textTheme: textTheme,
                      buttonTheme: buttonTheme,
                      onPressed: _handleAllow,
                      isLoading: _isRequesting,
                      backgroundColor: AppColors.blue,
                      buttonTextColor: Colors.white,
                      textStyle: textTheme.body.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleAllow() async {
    setState(() => _isRequesting = true);

    await PermissionManager.requestCameraPermissions();
    await PermissionManager.markCameraAsAsked();

    if (mounted) {
      Navigator.of(context).pop();
      widget.onComplete();
    }
  }

  Future<void> _handleDeny() async {
    await PermissionManager.markCameraAsAsked();

    if (mounted) {
      Navigator.of(context).pop();
      widget.onComplete();
    }
  }
}
