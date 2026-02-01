import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/presentation/bloc/contact_list_bloc.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/presentation/pages/contacts_main.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class ContactsMainPage extends StatelessWidget {
  const ContactsMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactListBloc>(
      create: (context) => sl<ContactListBloc>(),
      child: const ContactsMain(),
    );
  }
}
