import 'package:flutter/material.dart';
import '../model/emergency_contacts.dart';
import 'package:provider/provider.dart';



class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFCFE),
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "SOS Contacts",
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.w900, color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Image.asset("assets/phone_red.png"),
            onPressed: () {},
          )),
      body: FutureBuilder(
          future: Provider.of<EmergencyContacts>(context, listen: true)
              .checkForContacts(),
          builder: (context, AsyncSnapshot<List<String>> snap) {
            if (snap.data != null && snap.data!.isNotEmpty) {
              return Column(
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
                        Text("Swipe left to delete Contact"),
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
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (direction) => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("Are you sure?"),
                                    content: Text(
                                        "Do you want to delete this contact?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: Text("Yes")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text("No")),
                                    ],
                                  )),
                          key: Key(snap.data![index]),
                          // Provide a function that tells the app
                          // what to do after an item has been swiped away.
                          onDismissed: (direction) {
                            // Remove the item from the data source.

                            setState(() {
                              snap.data!.removeAt(index);
                              Provider.of<EmergencyContacts>(context,
                                      listen: false)
                                  .updateNewContactList(snap.data!);
                            });

                            // Then show a snackbar.
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('succesfuly deleted')));
                          },

                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                backgroundImage: AssetImage("assets/user.png"),
                              ),
                              title: Text(snap.data![index].split("***")[0]),
                              subtitle: Text(snap.data![index].split("***")[1]),
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
              );
            } else {
              return Center(
                child: Text("No Contacts found!"),
              );
            }
          }),
    );
  }
}
