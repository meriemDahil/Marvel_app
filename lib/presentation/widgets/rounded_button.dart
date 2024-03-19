
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedButton extends StatefulWidget {
  IconData icon;
  RoundedButton({super.key,required this.icon});
 

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height /19,
      width: MediaQuery.of(context).size.width/9,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),),
      child: Center(
        child: IconButton(
         icon:Icon( widget.icon),
          color:  Theme.of(context).primaryColor,
           onPressed: () { 
              Navigator.pop(context);
           }, 
        ),),
     

    );
  }
}