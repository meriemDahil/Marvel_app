
import 'package:flutter/material.dart';
import 'package:marvel/presentation/cubit/theme_cubit.dart';
import 'package:marvel/presentation/screens/favorite.dart';
import 'package:marvel/presentation/screens/home.dart';
import 'package:marvel/presentation/widgets/character_screen.dart';

class NavBar extends StatefulWidget {
 
  NavBar({super.key,});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  
  int index = 0;
  late List<Widget> screens = [
           CharactersScreen(),
           FavoriteScreen()
    ];

  @override
  Widget build(BuildContext context) {
             return Scaffold(
            body: screens[index],
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                elevation: 10,
                iconSize: 35,
                currentIndex: index,
                onTap: (int index) {
                  setState(() {
                    this.index = index;
                  });
                },
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Theme.of(context).primaryColor,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                
                  BottomNavigationBarItem(
                    icon: Icon(Icons.star_rounded, color: Theme.of(context).primaryColor),
                    label: 'Favorite',
                  ),
                ],
              ),
            ),
          );
        }
      }
    
        
  
      
    
  