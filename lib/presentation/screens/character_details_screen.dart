import 'package:flutter/material.dart';
import 'package:marvel/data/models/character_model.dart';
import 'package:url_launcher/url_launcher.dart';
class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(character.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              character.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Comics:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: character.comics.length,
              itemBuilder: (context, index) {
                final comic = character.comics[index];
                return ListTile(
                  title: Text(comic.title),
                  trailing: IconButton(
                    icon: Icon(Icons.open_in_browser),
                    onPressed: () async {
                      
                     final url = 'https://www.youtube.com/watch?v=k0zGEbiDJcQ';

try {
  print('Launching URL: ${comic.url}');
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    // Open the URL in a web browser
    await launchUrl(Uri.parse(comic.url));
  }
} catch (e) {
  // Handle the case when the URL can't be launched or the web browser fails to open
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Error'),
      content: Text('Failed to launch URL'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    ),
  );
}
                      // Open Comic URL
                      // Implement your logic to open URLs here
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
