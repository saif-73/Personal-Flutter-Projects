import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const HomeScreen(), // Set the home screen of the app
    );
  }
}

// Stateful widget for the home screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controllers for text fields
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  // List to hold contact information
  final List<Map<String, String>> informationForCard = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(88, 0, 0, 0),
        title: const Text(
          'Contact List',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 28,
            shadows: [Shadow(blurRadius: 0)],
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              tooltip: 'Add Contact',
              icon: const Icon(Icons.add, size: 25, color: Colors.black),
              onPressed: () => _showAddContactDialog(
                  context), // Show dialog to add a new contact
            ),
          ),
        ],
      ),
      body: buildListView(), // Display the list of contacts
    );
  }

  // Method to show dialog for adding a new contact
  void _showAddContactDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Info'),
          content: SizedBox(
            width: 300,
            height: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                myTextField(nameController, 'NAME',
                    'e.g., Haris Khan'), // Name input field
                const SizedBox(height: 20),
                myTextField(phoneNumberController, 'PHONE NO',
                    'e.g., 03XXXXXXXXX'), // Phone number input field
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 100,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      nameController.clear(); // Clear input fields
                      phoneNumberController.clear();
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      final nameOfPerson = nameController.text.trim();
                      final phoneOfPerson = phoneNumberController.text.trim();
                      if (nameOfPerson.isNotEmpty && phoneOfPerson.isNotEmpty) {
                        setState(() {
                          informationForCard.add({
                            'title': nameOfPerson,
                            'subtitle': phoneOfPerson,
                          });
                        });
                        nameController.clear();
                        phoneNumberController.clear();
                        Navigator.pop(context); // Close the dialog
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Row(
                              children: <Widget>[
                                Icon(Icons.info, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  'Fill both fields!',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Method to create a TextField widget with given parameters
  TextField myTextField(
      TextEditingController controller, String label, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w200,
          color: Colors.blue,
        ),
        hintStyle: const TextStyle(fontSize: 12),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.25, color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.25, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
      ),
    );
  }

  // Method to build the ListView displaying the list of contacts
  ListView buildListView() {
    return ListView.builder(
      itemCount: informationForCard.length,
      itemBuilder: (context, index) {
        final item = informationForCard[index];
        return Card(
          shape: const Border.fromBorderSide(
            BorderSide(
              width: 2,
              color: Color.fromARGB(206, 1, 151, 13),
            ),
          ),
          color: const Color.fromARGB(178, 139, 195, 74),
          elevation: 10,
          child: ListTile(
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    _showEditContactDialog(
                        context, item, index); // Show dialog to edit contact
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, item,
                        index); // Show dialog to confirm deletion
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            title: Text(
              item['title']!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              item['subtitle']!,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  // Method to show dialog for editing a contact
  void _showEditContactDialog(
      BuildContext context, Map<String, String> item, int index) {
    final TextEditingController nameController =
        TextEditingController(text: item['title']);
    final TextEditingController phoneNumberController =
        TextEditingController(text: item['subtitle']);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Contact'),
          content: SizedBox(
            width: 300,
            height: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                myTextField(nameController, 'NAME',
                    'e.g., Haris Khan'), // Name input field
                const SizedBox(height: 20),
                myTextField(phoneNumberController, 'PHONE NO',
                    'e.g., 03XXXXXXXXX'), // Phone number input field
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 100,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      final nameOfPerson = nameController.text.trim();
                      final phoneOfPerson = phoneNumberController.text.trim();
                      if (nameOfPerson.isNotEmpty && phoneOfPerson.isNotEmpty) {
                        setState(() {
                          informationForCard[index] = {
                            'title': nameOfPerson,
                            'subtitle': phoneOfPerson,
                          };
                        });
                        Navigator.pop(context); // Close the dialog
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Row(
                              children: <Widget>[
                                Icon(Icons.info, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  'Fill both fields!',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Method to show confirmation dialog for deleting a contact
  void _showDeleteConfirmationDialog(
      BuildContext context, Map<String, String> item, int index) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Do you want to delete!'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 100,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        informationForCard
                            .removeAt(index); // Remove contact from the list
                      });
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
