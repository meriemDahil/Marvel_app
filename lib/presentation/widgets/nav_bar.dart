
import 'package:flutter/material.dart';
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
                iconSize: 40,
                currentIndex: index,
                onTap: (int index) {
                  setState(() {
                    this.index = index;
                  });
                },
                selectedItemColor: Color.fromARGB(255, 23, 3, 3),
                unselectedItemColor: Color.fromARGB(255, 23, 19, 8),
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                
                  BottomNavigationBarItem(
                    icon: Icon(Icons.star_rounded, color: Color(0xFF03285E)),
                    label: 'Favorite',
                  ),
                ],
              ),
            ),
          );
        }
      }
    
        
  
      
    
  