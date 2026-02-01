import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/create_new_contact/presentation/pages/create_new_contacts_page.dart';
import 'package:pingvite/features/contacts/presentation/bloc/create_contact_bloc.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class CreateNewContactsPageWrapper extends StatelessWidget {
  const CreateNewContactsPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateContactBloc>(
      create: (_) => sl<CreateContactBloc>(),
      child: const CreateNewContactsPage(),
    );
  }
}
