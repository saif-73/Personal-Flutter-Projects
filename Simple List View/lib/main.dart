import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sigma',
      debugShowCheckedModeBanner: false, // Hides the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

// Stateful widget for the home screen
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List of items to display in the list view
  final List<Item> itemDetailsList = [
    Item(
      title: 'SAIFULLAH',
      subTitle: '03000000000',
      detail: 'He lives in Karachi.\nHis age is 19',
    ),
    Item(
      title: 'ABDULLAH',
      subTitle: '03500000000',
      detail: 'He lives in Karachi.\nHis age is 17',
    ),
    Item(
      title: 'SALMAN',
      subTitle: '03450000000',
      detail: 'He lives in Lahore.\nHis age is 21',
    ),
    Item(
      title: 'FAREED',
      subTitle: '030444444444',
      detail: 'He lives in Karachi.\nHis age is 40',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Simple List View',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true, // Center the title in the app bar
      ),
      body: ListView.builder(
        itemCount: itemDetailsList.length, // Number of items in the list
        itemBuilder: (context, index) {
          final item = itemDetailsList[index]; // Get item at the current index
          return ListTile(
            title: Text(item.title), // Display the title of the item
            subtitle: Text(item.subTitle), // Display the subtitle of the item
            onTap: () => _showDetailScreen(
                context, item), // Navigate to detail screen on tap
          );
        },
      ),
    );
  }

  // Method to navigate to the detail screen
  void _showDetailScreen(BuildContext context, Item item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailScreen(item: item), // Pass item to DetailScreen
      ),
    );
  }
}

// Model class for item data
class Item {
  final String title;
  final String subTitle;
  final String detail;

  Item({
    required this.title,
    required this.subTitle,
    required this.detail,
  });
}

// Stateless widget for the detail screen
class DetailScreen extends StatelessWidget {
  final Item item;

  const DetailScreen({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title), // Display the title of the item in the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the start
          children: [
            Text(
              item.title, // Display the title
              style: Theme.of(context)
                  .textTheme
                  .titleLarge, // Apply large title style
            ),
            const SizedBox(height: 8.0), // Space between elements
            Text(
              item.subTitle, // Display the subtitle
              style: Theme.of(context)
                  .textTheme
                  .titleMedium, // Apply medium title style
            ),
            const SizedBox(height: 16.0), // Space between elements
            Text(
              item.detail, // Display the detail
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium, // Apply medium body style
            ),
          ],
        ),
      ),
    );
  }
}
