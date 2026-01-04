import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_card_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

/// Reusable Image Upload Card widget
class ImageUploadCard extends StatefulWidget {
  final File? initialImage;
  final Function(File?)? onImageSelected;
  final double? height;

  const ImageUploadCard({
    super.key,
    this.initialImage,
    this.onImageSelected,
    this.height,
  });

  @override
  State<ImageUploadCard> createState() => _ImageUploadCardState();
}

class _ImageUploadCardState extends State<ImageUploadCard> {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    selectedImage = widget.initialImage;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Container(
      height: widget.height ?? sl<SizeConfig>().rpx(140),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.grey.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: selectedImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _SelectedImageView(
                selectedImage: selectedImage!,
                onRemove: _removeImage,
              ),
            )
          : _UploadPromptView(
              textTheme: textTheme,
              onTap: _showImagePickerBottomSheet,
            ),
    );
  }

  void _showImagePickerBottomSheet() {
    final cardTheme = Theme.of(context).extension<AppCardTheme>()!;

    showModalBottomSheet(
      context: context,
      backgroundColor: cardTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return _ImagePickerBottomSheet(
          onCameraSelected: _pickImageFromCamera,
          onGallerySelected: _pickImageFromGallery,
          onFilesSelected: _pickImageFromFiles,
        );
      },
    );
  }

  Future<void> _pickImageFromCamera() async {
    Navigator.pop(context);
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (image != null) {
        _updateSelectedImage(File(image.path));
      }
    } catch (e) {
      _showErrorSnackBar('Error accessing camera: $e');
    }
  }

  Future<void> _pickImageFromGallery() async {
    Navigator.pop(context);
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        _updateSelectedImage(File(image.path));
      }
    } catch (e) {
      _showErrorSnackBar('Error accessing gallery: $e');
    }
  }

  Future<void> _pickImageFromFiles() async {
    Navigator.pop(context);
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null && result.files.single.path != null) {
        _updateSelectedImage(File(result.files.single.path!));
      }
    } catch (e) {
      _showErrorSnackBar('Error picking file: $e');
    }
  }

  void _updateSelectedImage(File image) {
    setState(() {
      selectedImage = image;
    });
    widget.onImageSelected?.call(image);
  }

  void _removeImage() {
    setState(() {
      selectedImage = null;
    });
    widget.onImageSelected?.call(null);
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}

class _SelectedImageView extends StatelessWidget {
  final File selectedImage;
  final VoidCallback onRemove;

  const _SelectedImageView({
    required this.selectedImage,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(selectedImage, fit: BoxFit.cover),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class _UploadPromptView extends StatelessWidget {
  final AppTextTheme textTheme;
  final VoidCallback onTap;

  const _UploadPromptView({required this.textTheme, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: AppImages.svgIcon(
              context,
              Constants.imageUpload,
              36,
              36,
              AppColors.grey,
            ),
          ),
          SizedBox(height: sl<SizeConfig>().rpx(12)),
          AppTexts(
            text: Constants.uploadImage,
            style: textTheme.body.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

class _ImagePickerBottomSheet extends StatelessWidget {
  final VoidCallback onCameraSelected;
  final VoidCallback onGallerySelected;
  final VoidCallback onFilesSelected;

  const _ImagePickerBottomSheet({
    required this.onCameraSelected,
    required this.onGallerySelected,
    required this.onFilesSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final cardTheme = Theme.of(context).extension<AppCardTheme>()!;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Image Source',
            style: textTheme.semiBold.copyWith(
              fontSize: 18,
              color: cardTheme.sectionLabelColor,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOption(
                context: context,
                icon: Icons.camera_alt,
                label: 'Camera',
                onTap: onCameraSelected,
              ),
              _buildOption(
                context: context,
                icon: Icons.photo_library,
                label: 'Gallery',
                onTap: onGallerySelected,
              ),
              _buildOption(
                context: context,
                icon: Icons.folder,
                label: 'Files',
                onTap: onFilesSelected,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final cardTheme = Theme.of(context).extension<AppCardTheme>()!;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.blue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.blue, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: cardTheme.sectionLabelColor)),
        ],
      ),
    );
  }
}
