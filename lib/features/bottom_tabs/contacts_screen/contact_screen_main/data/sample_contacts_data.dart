import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/data/contact_list_data.dart';

class SampleContactsData {
  static List<Map<String, String>> get attendees => [
    {
      "name": "Alice Johnson",
      "email": "alice@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Bob Wilson",
      "email": "bob@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Charlie Brown",
      "email": "charlie@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "David Miller",
      "email": "david@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Emma Davis",
      "email": "emma@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Frank Garcia",
      "email": "frank@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Grace Lee",
      "email": "grace@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Henry Taylor",
      "email": "henry@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Iris Anderson",
      "email": "iris@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Jack Thompson",
      "email": "jack@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Kate Williams",
      "email": "kate@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Liam Rodriguez",
      "email": "liam@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Maya Patel",
      "email": "maya@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Noah Martinez",
      "email": "noah@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Olivia Lopez",
      "email": "olivia@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Paul Gonzalez",
      "email": "paul@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Quinn White",
      "email": "quinn@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Rachel Green",
      "email": "rachel@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Steve Smith",
      "email": "stevesmith@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Tina Turner",
      "email": "tina@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Uma Singh",
      "email": "uma@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Victor Hugo",
      "email": "victor@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Wendy Clark",
      "email": "wendy@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Xavier King",
      "email": "xavier@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Yara Ali",
      "email": "yara@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
    {
      "name": "Zoe Parker",
      "email": "zoe@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    },
  ];

  static List<ContactListData> get contactLists => [
    const ContactListData(
      name: 'Mumbai Events - 1',
      createdDate: '01-11-2025',
      contactCount: 180,
      tags: ['Marketing'],
    ),
    const ContactListData(
      name: 'Finance Workshop',
      createdDate: '12-10-2025',
      contactCount: 320,
      tags: ['Finance'],
    ),
    const ContactListData(
      name: 'Startups',
      createdDate: '01-11-2025',
      contactCount: 436,
      tags: ['Startups'],
    ),
    const ContactListData(
      name: 'Online sessions',
      createdDate: '06-04-2024',
      contactCount: 1024,
      tags: ['Online'],
    ),
    const ContactListData(
      name: 'Wedding guests',
      createdDate: '15-11-2025',
      contactCount: 43,
      tags: ['Wedding', 'Guest List'],
    ),
  ];
}
