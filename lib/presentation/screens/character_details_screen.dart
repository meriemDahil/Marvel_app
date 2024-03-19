import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:marvel/data/models/character_model.dart';
import 'package:marvel/presentation/screens/favorite.dart';
import 'package:marvel/presentation/widgets/rounded_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
class CharacterDetailsScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character}) : super(key: key);

  @override
  _CharacterDetailsScreenState createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  late SharedPreferences _prefs;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _isFavorite = _prefs.containsKey(widget.character.id.toString());
    setState(() {});
  }

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      _prefs.remove(widget.character.id.toString());
    } else {
      final characterJson = jsonEncode(widget.character.toJson()); // Convert to JSON string
      _prefs.setString(widget.character.id.toString(), characterJson);
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

Future<void> _launchURL(String url) async {
    try {
    if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {

        throw 'Could not launch $url';
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to launch URL: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
 
Future<void> fetchAndLaunchUrl(String url ) async {
  final apiUrl = '$url?ts=1710631708304&apikey=6e145d4e69d4046cbb46449c730a4026&hash=f3adc377172cae4f961a7a8dc577a74a'; // Replace with the actual API URL
  final response = await http.get(Uri.parse(apiUrl));
  

    if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final data = jsonData['data'];
    final resultMap = data['results'][0];
    final urls = resultMap['urls'] as List<dynamic>?;

    if (urls != null) {
      String? urlToLaunch;

      for (var urlMap in urls) {
        String type = urlMap['type'];
        if (type == 'detail') {
          urlToLaunch = urlMap['url'];
          break;
        }
      }

      if (urlToLaunch != null) {
        _launchURL(urlToLaunch);
      } else {
        print('No URL with type "detail" found');
      }
    } else {
      print('URLs not found in the response');
    }
  } else {
    print('Failed to fetch data from API');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character.name),
        centerTitle: true,
        leading: RoundedButton(icon: Icons.arrow_back),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(left: 60,right: 60,top: 16,bottom: 16),

                child: Image.network(
                  widget.character.imageUrl,
                  width: MediaQuery.of(context).size.width,
                  height: 400.0, // Adjust as needed
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.character.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  
                ),
                Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
                onPressed: _toggleFavorite,
                child: Text(_isFavorite ? 'Remove from Favorites' : 'Add to Favorites',style: TextStyle(color:  Colors.black),),
              ),
            ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Comics:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.character.comics.length,
              itemBuilder: (context, index) {
                final comic = widget.character.comics[index];
                return ListTile(
                  title: Text(comic.title),
                  trailing: IconButton(
                    icon: Icon(Icons.open_in_browser),
                    onPressed: () async {
                      print(comic.url);
                     
                         
                           fetchAndLaunchUrl(comic.url);
                        
                    },
                  ),
                );
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
