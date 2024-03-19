import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/cubit/cubit_cubit.dart';
import 'package:marvel/presentation/screens/favorite.dart';

class CustomDrawer extends StatelessWidget {
  
  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // ListTile(
          //   title: Text('Go To Favorite'),
          //   onTap: (){
          //     Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>  FavoriteScreen()),
          //   );
          //   },
          // ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Logout'),
                Icon(Icons.logout)
              ],
            ),
            onTap: (){
               context.read<CubitCubit>().signOut();
            },
          ),
          
        ],
      ),
    );
  }
}
