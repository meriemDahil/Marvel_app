
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:marvel/data/repository/local/notification.dart';
import 'package:marvel/data/repository/local/notification.dart';
import 'package:marvel/presentation/cubit/cubit_cubit.dart';
import 'package:marvel/presentation/widgets/custom_text_field.dart';
import 'package:marvel/presentation/widgets/elevated_botton.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  
       Container(
                  //height: 30,
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Column(
                    
                    children: [
                     
                      CustomTextField(hintText: 'email', label: 'email', submitted: true, controller: _emailController,),
                      SizedBox(height: MediaQuery.of(context).size.height/40,),
                      CustomTextField(hintText: 'password', label: 'password', submitted: true,controller: _passwordController,),
                      SizedBox(height: MediaQuery.of(context).size.height/40,),
                      
               
                ElevatedButton(
                      onPressed: () {
                      
                        context.read<CubitCubit>().signUp(
                              email: _emailController.text,
                              password: _passwordController.text, 
                        
                            );
                   LocalNotification.ShowSimpleNotification(title: 'Marvel app',body: 'Welcome To Marvel Comic World', payload: '');         
                            },
                      child: const CustomElevaredButton(),
                    ),
                    ],
                  ),
                
    );
  }
}