import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingvite/core/custom_widgets/custom_fab.dart';
import 'package:pingvite/core/utils/jwt_token_decoder.dart';
import 'package:pingvite/core/services/secure_storage_service.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/data/contact_model.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/domain/entities/contact_entity.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/presentation/widgets/all_contacts_view.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/presentation/widgets/contact_options_dialog.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/create_new_contact/presentation/widgets/create_new_contacts_wrapper.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/presentation/bloc/contact_list_bloc.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class ContactsMain extends StatefulWidget {
  const ContactsMain({super.key});

  @override
  State<ContactsMain> createState() => _ContactsMainState();
}

class _ContactsMainState extends State<ContactsMain> {
  int _userId = 0;

  @override
  void initState() {
    super.initState();
    _initUserAndFetchContacts();
  }

  Future<void> _initUserAndFetchContacts() async {
    try {
      final secureStorage = sl<SecureStorageService>();
      final token = await secureStorage.getAccessToken();

      if (token != null && token.isNotEmpty) {
        final userId = JwtTokenDecoder.getUserId(token);
        if (userId != null) {
          setState(() => _userId = userId);
          // Fetch contacts using BLoC
          if (mounted) {
            context.read<ContactListBloc>().add(
              FetchContactListEvent(userId: userId),
            );
          }
        }
      }
    } catch (e) {
      debugPrint('Error decoding token: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar.withBackButton(title: 'My Contacts'),
      body: BlocBuilder<ContactListBloc, ContactListState>(
        builder: (context, state) {
          if (state is ContactListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContactListSuccess) {
            return _buildContactsView(state.contacts);
          } else if (state is ContactListFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ContactListBloc>().add(
                        RefreshContactListEvent(userId: _userId),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: CustomFAB(
        onPressed: () => _showCreateContactOption(context),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildContactsView(List<Contact> contacts) {
    if (contacts.isEmpty) {
      return const Center(child: Text('No contacts found'));
    }

    // Convert Contact entities to ContactModel for display
    final contactModels = _convertToContactModels(contacts);

    return AllContactsView(contactModels: contactModels);
  }

  List<ContactModel> _convertToContactModels(List<Contact> contacts) {
    final models = contacts.map((contact) {
      final firstLetter = contact.contactName.substring(0, 1).toUpperCase();
      return ContactModel(
        data: {
          'name': contact.contactName,
          'email': contact.email,
          'mobile': contact.mobile,
          'id': contact.id.toString(),
        },
        tagIndex: firstLetter,
      );
    }).toList();

    models.sort((a, b) => a.data['name']!.compareTo(b.data['name']!));
    SuspensionUtil.sortListBySuspensionTag(models);
    SuspensionUtil.setShowSuspensionStatus(models);

    return models;
  }

  Future<void> _showCreateContactOption(BuildContext context) async {
    final navigator = Navigator.of(context);
    final action = await ContactOptionsDialog.show(context);
    if (action == null || !mounted) return;

    switch (action) {
      case ContactAction.createContact:
        navigator.push(
          MaterialPageRoute(
            builder: (_) => const CreateNewContactsPageWrapper(),
          ),
        );
        break;
      case ContactAction.createList:
        // Will add later
        break;
      case ContactAction.bulkUpload:
        // Will add later
        break;
    }
  }
}
