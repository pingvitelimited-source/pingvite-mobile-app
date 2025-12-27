import 'package:azlistview/azlistview.dart';

class ContactModel extends ISuspensionBean {
  final Map<String, String> data;
  final String tagIndex;

  ContactModel({required this.data, required this.tagIndex});

  @override
  String getSuspensionTag() => tagIndex;
}
