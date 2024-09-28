import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // Entry point of the app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen, // Theme color for the app
      ),
      home: const HomeScreen(), // Home screen of the app
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isBoldChecked = false; // State for bold checkbox
  String? selectedValue =
      'EduAUVICWANTGuides-VariableFont_wght'; // Default font
  int? selectedFont = 12; // Default font size

  // List of available fonts
  static const List<String> fonts = [
    'EduAUVICWANTGuides-VariableFont_wght',
    'PlaywriteDEGrund-VariableFont_wght',
    'Poppins-LightItalic',
    'RobotoCondensed-VariableFont_wght',
    'BebasNeue-Regular',
    'DancingScript-VariableFont_wght',
    'SpicyRice-Regular',
    'IBMPlexMono-SemiBold',
  ];

  // Display names for the fonts
  static const List<String> shownFonts = [
    'EduAUVICWANTGuides',
    'PlaywriteDEGrund',
    'Poppins-LightItalic',
    'RobotoCondensed',
    'BebasNeue-Regular',
    'DancingScript',
    'SpicyRice-Regular',
    'IBMPlexMono-SemiBold',
  ];

  // List of available font sizes
  static const List<int> fontSizes = [
    6,
    8,
    10,
    12,
    14,
    16,
    18,
    20,
    22,
    24,
    26,
    28,
    30,
    32,
    34
  ];

  @override
  Widget build(BuildContext context) {
    // Get the device's screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen, // AppBar color
        centerTitle: true,
        title: const Text(
          'My Fonts App', // Title of the app
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Row containing the Bold checkbox, font dropdown, and size dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _checkBoxForBold(), // Checkbox for bold text
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(width: 1, color: Colors.black),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child:
                        _dropDownListForFonts(), // Dropdown for font selection
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(width: 1, color: Colors.black),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child:
                        _dropDownListForFontSizes(), // Dropdown for font size selection
                  ),
                ),
              ],
            ),
            // TextField for user input with customizable font settings
            Container(
              width: screenSize.width * 0.9, // 90% of the device's width
              height: screenSize.height * 0.65, // 65% of the device's height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1.5,
                  color: const Color.fromARGB(255, 58, 53, 53),
                ),
              ),
              child: TextField(
                maxLines: null,
                style: TextStyle(
                  fontFamily: selectedValue, // Selected font family
                  fontWeight: isBoldChecked
                      ? FontWeight.bold
                      : FontWeight.normal, // Bold or normal weight
                  fontSize: selectedFont!.toDouble(), // Selected font size
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(15), // Padding for text input
                  border: InputBorder.none, // No border for the text field
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dropdown for font sizes
  DropdownButton<int> _dropDownListForFontSizes() {
    return DropdownButton<int>(
      underline: const SizedBox(), // No underline for the dropdown
      items: fontSizes.map<DropdownMenuItem<int>>(
        (int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text(value.toString()), // Display size as text
          );
        },
      ).toList(),
      onChanged: (value) {
        setState(() {
          selectedFont = value; // Update selected font size
        });
      },
      value: selectedFont,
    );
  }

  // Dropdown for font selection
  DropdownButton<String> _dropDownListForFonts() {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(10),
      style: const TextStyle(fontSize: 15),
      underline: const SizedBox(), // No underline for the dropdown
      value: selectedValue,
      onChanged: (value) {
        setState(() {
          selectedValue = value; // Update selected font
        });
      },
      items: fonts.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            shownFonts[fonts.indexOf(value)], // Display name of the font
            style: TextStyle(
              fontFamily: fonts[fonts.indexOf(value)], // Apply font family
            ),
          ),
        );
      }).toList(),
    );
  }

  // Checkbox for bold text
  Container _checkBoxForBold() {
    return Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isBoldChecked, // Checkbox state
            onChanged: (value) {
              setState(() {
                isBoldChecked = value!; // Update bold state
              });
            },
          ),
          const Text(
            'Bold',
            style: TextStyle(
                fontWeight: FontWeight.bold), // Label for the checkbox
          ),
          const SizedBox(width: 3),
        ],
      ),
    );
  }
}
