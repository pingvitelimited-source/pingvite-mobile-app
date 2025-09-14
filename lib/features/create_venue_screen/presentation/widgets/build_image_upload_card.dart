import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingvite/core/custom_widgets/app_card.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/create_venue_screen/presentation/widgets/image_picker_bottom_sheet.dart';
import 'package:pingvite/features/create_venue_screen/presentation/widgets/selected_image_view.dart';
import 'package:pingvite/features/create_venue_screen/presentation/widgets/upload_prompt_view.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class BuildImageUploadCard extends StatefulWidget {
  final AppTextTheme textTheme;
  final Function(File?)? onImageSelected;
  final File? initialImage;

  const BuildImageUploadCard({
    super.key,
    required this.textTheme,
    this.onImageSelected,
    this.initialImage,
  });

  @override
  State<BuildImageUploadCard> createState() => _BuildImageUploadCardState();
}

class _BuildImageUploadCardState extends State<BuildImageUploadCard> {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    selectedImage = widget.initialImage;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      borderColor: AppColors.imageUploadCardColor,
      margin: EdgeInsets.zero,
      borderRadius: 10,
      elevation: 0,
      backgroundColor: AppColors.imageUploadCardColor,
      child: SizedBox(
        height: sl<SizeConfig>().rpx(120),
        width: double.infinity,
        child: selectedImage != null
            ? SelectedImageView(
                selectedImage: selectedImage!,
                onRemove: _removeImage,
              )
            : UploadPromptView(
                textTheme: widget.textTheme,
                onTap: _showImagePickerBottomSheet,
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
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        _updateSelectedImage(File(result.files.single.path!));
      }
    } catch (e) {
      _showErrorSnackBar('Error accessing files: $e');
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  File? getSelectedImage() => selectedImage;
}
