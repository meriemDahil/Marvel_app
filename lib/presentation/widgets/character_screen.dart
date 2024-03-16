import 'package:flutter/material.dart';

class CharacterScreen extends StatelessWidget {
  final String char_name;
  final int char_id;
  final String imageUrl;
   CharacterScreen({super.key, required this.char_name, required this.char_id, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
   
    return Container(
        padding: EdgeInsets.all(10),
        height: 420,
        width: 250,
        margin: EdgeInsets.only(bottom: 10,),
        
         decoration :BoxDecoration(
            border: Border.all(color: Colors.white),),

      child: Column(children: [
        Container(
          height: 300,
          width: 250,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          decoration :BoxDecoration(
            border: Border.all(color: Colors.white),
            
            image :DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover
              ),)
               ),
        Text(char_name,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.bold),),
        Text('$char_id',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.bold),),
      ],),


    );
  }
}