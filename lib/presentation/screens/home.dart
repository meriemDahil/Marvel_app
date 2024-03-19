
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/cubit/charactercubit_cubit.dart';
import 'package:marvel/presentation/cubit/charactercubit_state.dart';
import 'package:marvel/presentation/cubit/theme_cubit.dart';
import 'package:marvel/presentation/screens/character_details_screen.dart';
import 'package:marvel/presentation/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';



class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  bool _showFullList = false; 

  @override
  void initState() {
    super.initState();
    context.read<CharactersCubit>().fetchMarvelCharacters();
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

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return Scaffold(
      appBar: AppBar(
       
        title: Image.asset('assets/marvel-removebg-preview.png',height: MediaQuery.of(context).size.height/10,),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              themeCubit.toggleTheme();
            },
            icon: Icon(_getThemeIcon(themeCubit.state)), 
          ),
        ],
      ),
      
      body: CustomScrollView(
        slivers: [
          BlocBuilder<CharactersCubit, CharactersState>(
            builder: (context, state) {
              if (state is CharactersLoading) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()));
              } else if (state is CharactersLoaded) {
                final characters = _showFullList
                    ? state.characters
                    : state.characters.take(10).toList(); 
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final character = characters[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CharacterDetailsScreen(character: character),
                            ),
                          );
                        },
                        leading: Image.network(
                          character.imageUrl,
                          width: 70,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          character.name,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        subtitle: Text(
                          'ID: ${character.id}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.insert_link),
                          onPressed: () => _launchURL(character.wikiUrl),
                        ),
                      );
                    },
                    childCount: characters.length,
                  ),
                );
              } else if (state is CharactersError) {
                return const SliverToBoxAdapter(child: Center(child: Text('No data available')));
              } else {
                return const SliverToBoxAdapter(child: Center(child: Text('Unknown state')));
              }
            },
          ),
          SliverToBoxAdapter(
            child: _buildShowMoreButton(),
          ),
        ],
      ),
      drawer: CustomDrawer(),
    );
  
  }

  Widget _buildShowMoreButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          setState(() {
            _showFullList = !_showFullList;
          });
        },
        child: Text(
          _showFullList ? 'Show Less' : 'Show More',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  
  IconData _getThemeIcon(ThemeModeType themeMode) {
    return themeMode == ThemeModeType.light ? Icons.wb_sunny : Icons.nightlight_round;
  }
}
