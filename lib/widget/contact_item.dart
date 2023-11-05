import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rakhshak/constant.dart';
import '../model/emergency_contacts.dart';

class ContactItem extends StatefulWidget {
  ContactItem({
    Key? key,
  }) : super(key: key);

  static const height = 50.0;

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  int selectedContact = -1;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<EmergencyContacts>(context, listen: true)
            .checkForContacts(),
        builder: (context, AsyncSnapshot<List<String>> snap) {
          if (snap.data != null && snap.data!.isNotEmpty) {
            return Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            indent: 20,
                            endIndent: 20,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            indent: 20,
                            endIndent: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snap.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedContact = index;
                              });
                              Provider.of<EmergencyContacts>(context,
                                      listen: false)
                                  .saveSharingContacts(
                                      snap.data![index].split("***")[1]);
                            },
                            child: Container(
                              color: lightBackgroundColor,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  backgroundImage:
                                      AssetImage("assets/user.png"),
                                ),
                                title: Text(snap.data![index].split("***")[0]),
                                subtitle:
                                    Text(snap.data![index].split("***")[1]),
                                trailing: selectedContact == index
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text("No Contacts found!"),
            );
          }
        });
  }
}
