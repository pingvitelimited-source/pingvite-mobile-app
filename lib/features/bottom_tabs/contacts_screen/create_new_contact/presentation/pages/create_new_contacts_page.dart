import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/create_new_contact/presentation/widgets/contact_image_picker.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/create_new_contact/presentation/widgets/contact_type_dropdown.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';

class CreateNewContactsPage extends StatefulWidget {
  const CreateNewContactsPage({super.key});

  @override
  State<CreateNewContactsPage> createState() => _CreateNewContactsPageState();
}

class _CreateNewContactsPageState extends State<CreateNewContactsPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  File? _selectedImage;
  String? _selectedContactType;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;

    return Scaffold(
      backgroundColor: AppColors.homebackground,
      appBar: CustomAppBar.withBackButton(title: Constants.createNewContact),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.rpx),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 32.rpx),

                  // Image Picker
                  ContactImagePicker(
                    selectedImage: _selectedImage,
                    onImageSelected: (image) {
                      setState(() => _selectedImage = image);
                    },
                  ),

                  SizedBox(height: 40.rpx),

                  // Full Name Field
                  TextFieldFactory.name(
                    context: context,
                    buttonTheme: buttonTheme,
                    name: 'full_name',
                    hintText: 'Full Name',
                    requiredError: 'Full name is required',
                    minLengthError: 'Name must be at least 2 characters',
                  ),

                  SizedBox(height: 20.rpx),

                  // Email Field
                  TextFieldFactory.email(
                    context: context,
                    buttonTheme: buttonTheme,
                  ),

                  SizedBox(height: 20.rpx),

                  // Phone Number Field
                  TextFieldFactory.phone(
                    context: context,
                    buttonTheme: buttonTheme,
                  ),

                  SizedBox(height: 20.rpx),

                  // Contact Type Dropdown
                  ContactTypeDropdown(
                    buttonTheme: buttonTheme,
                    selectedValue: _selectedContactType,
                    onChanged: (value) {
                      setState(() => _selectedContactType = value);
                    },
                  ),

                  SizedBox(height: 40.rpx),

                  // Create New Contact Button
                  SizedBox(
                    width: double.infinity,
                    child: AppButtonFactory.build(
                      context: context,
                      type: ButtonType.gradient,
                      title: Constants.createNewContact,
                      isLoading: _isLoading,
                      onPressed: _handleCreateContact,
                    ),
                  ),

                  SizedBox(height: 32.rpx),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleCreateContact() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value;

      setState(() => _isLoading = true);

      debugPrint('Form Data: $formData');
      debugPrint('Selected Image: $_selectedImage');
      debugPrint('Contact Type: $_selectedContactType');

      // Simulate API call
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() => _isLoading = false);
          Navigator.pop(context);
        }
      });
    }
  }
}
