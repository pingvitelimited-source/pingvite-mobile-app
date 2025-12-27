import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/create_venue_screen/presentation/widgets/image_picker_bottom_sheet.dart';

class ContactImagePicker extends StatefulWidget {
  final File? selectedImage;
  final ValueChanged<File?> onImageSelected;

  const ContactImagePicker({
    super.key,
    this.selectedImage,
    required this.onImageSelected,
  });

  @override
  State<ContactImagePicker> createState() => _ContactImagePickerState();
}

class _ContactImagePickerState extends State<ContactImagePicker> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return GestureDetector(
      onTap: _showImagePickerBottomSheet,
      child: Container(
        width: 140.rpx,
        height: 140.rpx,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.imageUploadCardColor,
          image: widget.selectedImage != null
              ? DecorationImage(
                  image: FileImage(widget.selectedImage!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: widget.selectedImage == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImages.svgIcon(
                    context,
                    Constants.imageUpload,
                    40,
                    40,
                    AppColors.grey.withValues(alpha: 0.5),
                  ),
                  SizedBox(height: 8.rpx),
                  AppTexts(
                    text: Constants.uploadImage,
                    style: textTheme.accent.copyWith(
                      color: AppColors.grey.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8.rpx),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 16.rpx,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _showImagePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return ImagePickerBottomSheet(
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
        widget.onImageSelected(File(image.path));
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
        widget.onImageSelected(File(image.path));
      }
    } catch (e) {
      _showErrorSnackBar('Error accessing gallery: $e');
    }
  }

  Future<void> _pickImageFromFiles() async {
    Navigator.pop(context);
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null && result.files.single.path != null) {
        widget.onImageSelected(File(result.files.single.path!));
      }
    } catch (e) {
      _showErrorSnackBar('Error picking file: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.red),
    );
  }
}
