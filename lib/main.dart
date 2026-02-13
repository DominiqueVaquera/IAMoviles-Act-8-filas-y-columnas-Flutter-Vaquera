import 'package:flutter/material.dart';

void main() {
  runApp(const MiZoologicoApp());
}

/// DATA_MODEL for representing an animal block in the UI.
/// This model contains all the necessary information to render an individual square.
class AnimalBlockData {
  final Color backgroundColor;
  final IconData iconData;
  final String name;
  final Color textColor;

  /// Initializes an [AnimalBlockData] instance.
  /// The [textColor] is automatically calculated to provide a good contrast
  /// against the [backgroundColor] for improved readability.
  AnimalBlockData({
    required this.backgroundColor,
    required this.iconData,
    required this.name,
  }) : textColor = _getContrastingTextColor(backgroundColor);

  /// Determines a contrasting text color (either black or white)
  /// based on the luminance of the [background] color.
  /// This ensures text is readable on various background shades.
  static Color _getContrastingTextColor(Color background) {
    // A luminance value greater than 0.5 typically indicates a light color.
    // For light backgrounds, use black text; for dark backgrounds, use white text.
    return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}

class MiZoologicoApp extends StatelessWidget {
  const MiZoologicoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  /// Initializes the static list of [AnimalBlockData] objects.
  /// This data drives the content of each square in the UI.
  /// Initial UI data is initialized here, outside of the build function.
  static final List<AnimalBlockData> _animalBlocks = [
    AnimalBlockData(backgroundColor: Colors.orange, iconData: Icons.pets, name: "León"),
    AnimalBlockData(backgroundColor: Colors.yellow, iconData: Icons.landscape, name: "Jirafa"),
    AnimalBlockData(backgroundColor: Colors.pink, iconData: Icons.pool, name: "Flamenco"),
    AnimalBlockData(backgroundColor: Colors.green, iconData: Icons.bug_report, name: "Rana"),
    AnimalBlockData(backgroundColor: Colors.blue, iconData: Icons.waves, name: "Ballena"),
    AnimalBlockData(backgroundColor: Colors.red, iconData: Icons.catching_pokemon, name: "Zorro"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Zoológico Vaquera",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: const [
          Icon(Icons.pets, color: Colors.white), // Generic animal icon
          SizedBox(width: 15),
          Icon(Icons.hail, color: Colors.white), // Caretaker/person icon
          SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Increased margin around the entire content
        child: Column(
          children: [
            // Row 1: Orange and Yellow squares
            Expanded(
              child: Row(
                children: [
                  Expanded(child: AnimalSquareWidget(data: _animalBlocks[0])),
                  const SizedBox(width: 20), // Increased horizontal separation
                  Expanded(child: AnimalSquareWidget(data: _animalBlocks[1])),
                ],
              ),
            ),

            const SizedBox(height: 20), // Increased vertical separation between rows

            // Row 2: Pink and Green squares
            Expanded(
              child: Row(
                children: [
                  Expanded(child: AnimalSquareWidget(data: _animalBlocks[2])),
                  const SizedBox(width: 20), // Increased horizontal separation
                  Expanded(child: AnimalSquareWidget(data: _animalBlocks[3])),
                ],
              ),
            ),

            const SizedBox(height: 20), // Increased vertical separation between rows

            // Row 3: Blue and Red squares
            Expanded(
              child: Row(
                children: [
                  Expanded(child: AnimalSquareWidget(data: _animalBlocks[4])),
                  const SizedBox(width: 20), // Increased horizontal separation
                  Expanded(child: AnimalSquareWidget(data: _animalBlocks[5])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A custom widget to display an animal's icon and name within a colored square.
/// The icon and text colors are determined by the [AnimalBlockData] to ensure contrast.
class AnimalSquareWidget extends StatelessWidget {
  final AnimalBlockData data;

  const AnimalSquareWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [data.backgroundColor, data.backgroundColor.withOpacity(0.3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          children: [
            Icon(
              data.iconData,
              size: 48, // Icon size
              color: data.textColor, // Contrasting icon color
            ),
            const SizedBox(height: 8), // Spacing between icon and text
            Text(
              data.name,
              style: TextStyle(
                color: data.textColor, // Contrasting text color
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
