import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:path/path.dart' as path;
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_card_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/connectivity_helper.dart';
import 'package:pingvite/core/utils/show_snackbar.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/create_new_contact/presentation/widgets/contact_image_picker.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/create_new_contact/presentation/widgets/contact_type_dropdown.dart';
import 'package:pingvite/features/contacts/domain/entities/contact.dart';
import 'package:pingvite/features/contacts/presentation/bloc/create_contact_bloc.dart';
import 'package:pingvite/features/contacts/presentation/bloc/create_contact_event.dart';
import 'package:pingvite/features/contacts/presentation/bloc/create_contact_state.dart';
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
  String? _contactTypeError;

  int _getContactTypeValue(String? type) {
    switch (type?.toLowerCase()) {
      case 'family':
        return 1;
      case 'friends':
      case 'friend':
        return 2;
      case 'business':
      case 'work':
        return 3;
      default:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    final cardTheme = Theme.of(context).extension<AppCardTheme>()!;

    return Scaffold(
      backgroundColor: cardTheme.screenBackgroundColor,
      appBar: CustomAppBar.withBackButton(title: Constants.createNewContact),
      body: SafeArea(
        child: BlocListener<CreateContactBloc, CreateContactState>(
          listener: (context, state) {
            if (state is CreateContactSuccess) {
              showSnackBar(
                context,
                state.message,
                backgroundColor: Colors.green,
              );
              Navigator.pop(context);
            } else if (state is CreateContactFailure) {
              final errorMessage = state.error.contains('No internet')
                  ? 'No internet connection. Please check your network.'
                  : state.error;
              showSnackBar(
                context,
                errorMessage,
                backgroundColor: AppColors.red,
              );
            }
          },
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ContactTypeDropdown(
                          buttonTheme: buttonTheme,
                          selectedValue: _selectedContactType,
                          onChanged: (value) {
                            setState(() {
                              _selectedContactType = value;
                              _contactTypeError = null;
                            });
                          },
                        ),
                        if (_contactTypeError != null)
                          Padding(
                            padding: EdgeInsets.only(left: 12.rpx, top: 8.rpx),
                            child: Text(
                              _contactTypeError!,
                              style: TextStyle(
                                color: AppColors.red,
                                fontSize: 12.rpx,
                              ),
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: 40.rpx),

                    // Create New Contact Button
                    BlocBuilder<CreateContactBloc, CreateContactState>(
                      builder: (context, state) {
                        final isLoading = state is CreateContactLoading;

                        return SizedBox(
                          width: double.infinity,
                          child: AppButtonFactory.build(
                            context: context,
                            type: ButtonType.gradient,
                            title: Constants.createNewContact,
                            isLoading: isLoading,
                            onPressed: isLoading ? () {} : _handleCreateContact,
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 32.rpx),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleCreateContact() async {
    // Check internet connectivity first
    final hasInternet = await ConnectivityHelper.hasInternetConnection();
    if (!mounted) return;

    if (!hasInternet) {
      showSnackBar(
        context,
        'No internet connection. Please check your network.',
        backgroundColor: AppColors.red,
      );
      return;
    }

    // Validate contact type
    if (_selectedContactType == null || _selectedContactType!.isEmpty) {
      setState(() {
        _contactTypeError = 'Please select a contact type';
      });
      if (!mounted) return;

      showSnackBar(
        context,
        'Please select a contact type',
        backgroundColor: AppColors.red,
      );
      return;
    }

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value;

      final name = formData?['full_name'] as String?;
      final email = formData?['email_field'] as String?;
      final phone = formData?['phone_field'] as String?;

      if (name == null || email == null || phone == null) {
        if (!mounted) return;

        showSnackBar(
          context,
          'Please fill all required fields',
          backgroundColor: AppColors.red,
        );
        return;
      }

      String? base64Image;
      String? imageExtension;

      if (_selectedImage != null) {
        try {
          final imageBytes = await _selectedImage!.readAsBytes();
          if (!mounted) return;

          base64Image = base64Encode(imageBytes);
          imageExtension = path.extension(_selectedImage!.path);
        } catch (e) {
          debugPrint('Error converting image to base64: $e');
        }
      }

      final contact = Contact(
        contactName: name,
        email: email,
        mobile: phone,
        contactType: _getContactTypeValue(_selectedContactType),
      );

      if (!mounted) return;

      context.read<CreateContactBloc>().add(
        CreateContactSubmitted(
          contact: contact,
          base64Image: base64Image,
          imageExtension: imageExtension,
        ),
      );
    }
  }
}
