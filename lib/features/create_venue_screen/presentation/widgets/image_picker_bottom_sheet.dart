import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final VoidCallback onCameraSelected;
  final VoidCallback onGallerySelected;
  final VoidCallback onFilesSelected;

  const ImagePickerBottomSheet({
    super.key,
    required this.onCameraSelected,
    required this.onGallerySelected,
    required this.onFilesSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Title
          AppTexts(
            text: 'Select Image',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBottomSheetOption(
                context: context,
                icon: Icons.camera_alt,
                label: 'Camera',
                onTap: onCameraSelected,
              ),
              _buildBottomSheetOption(
                context: context,
                icon: Icons.photo_library,
                label: 'Gallery',
                onTap: onGallerySelected,
              ),
              _buildBottomSheetOption(
                context: context,
                icon: Icons.folder,
                label: 'Files',
                onTap: onFilesSelected,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Cancel button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const AppTexts(text: 'Cancel'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            AppTexts(
              text: label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
