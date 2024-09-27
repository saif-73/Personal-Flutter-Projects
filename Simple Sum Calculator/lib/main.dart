import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController no1Controller =
      TextEditingController(); // Controller for the first text field
  final TextEditingController no2Controller =
      TextEditingController(); // Controller for the second text field
  Widget setting = const Icon(Icons.add); // Initial widget for the button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 400,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: Colors.black), // Border for the container
            borderRadius:
                BorderRadius.circular(30), // Rounded corners for the container
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Minimum size of the column
            mainAxisAlignment: MainAxisAlignment
                .spaceAround, // Space elements evenly with extra space around
            children: [
              SizedBox(
                width: 250,
                child: _myTextField(
                    no1Controller, 'Enter first number'), // First text field
              ),
              SizedBox(
                width: 250,
                child: _myTextField(
                    no2Controller, 'Enter second number'), // Second text field
              ),
              const SizedBox(
                  height: 60), // Spacer between the text fields and button
              MouseRegion(
                onEnter: (_) {
                  setState(() {
                    // Change button appearance when mouse enters
                    setting = Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.blue[600],
                      ),
                    );
                  });
                },
                onExit: (_) {
                  setState(() {
                    // Revert button appearance when mouse exits
                    setting = const Icon(
                      Icons.add,
                      size: 30,
                    );
                  });
                },
                child: SizedBox(
                  width: 200,
                  height: 100,
                  child: OutlinedButton(
                    onPressed:
                        _changedButtonSetting, // Update button setting on press
                    child:
                        setting, // Display current widget (text or icon) on the button
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Updates the displayed widget to show the result of the calculation.
  void _changedButtonSetting() {
    // Parse the numbers from text fields, default to 0 if parsing fails
    double number1 = double.tryParse(no1Controller.text) ?? 0;
    double number2 = double.tryParse(no2Controller.text) ?? 0;

    // Determine font size based on the length of the result
    double textSize = ('${number1 + number2}').length < 10 ? 28 : 18;

    setState(() {
      // Update the button to show the result of the calculation
      setting = Text(
        '${number1 + number2}',
        style: TextStyle(
          fontSize: textSize,
          color: Colors.red[400],
        ),
      );
    });
  }

  /// Creates a TextField with a given controller and hint text.
  TextField _myTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller, // Controller for managing text input
      decoration: InputDecoration(
        hintText: hint, // Hint text for the input field
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10), // Rounded corners for the input border
          borderSide: const BorderSide(
              color: Colors.black, width: 1.25), // Border color and width
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              10), // Rounded corners for the input border when focused
          borderSide: const BorderSide(
              color: Colors.blue,
              width: 1.25), // Border color and width when focused
        ),
      ),
    );
  }
}
