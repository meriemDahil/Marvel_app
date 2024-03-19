import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/cubit/cubit_cubit.dart';
import 'package:marvel/presentation/screens/sign_up.dart';
import 'package:marvel/presentation/widgets/custom_text_field.dart';
import 'package:marvel/presentation/widgets/elevated_botton.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
    return  Container(
                //height: 30,
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Column(
                  children: [
                    CustomTextField(hintText: 'email', label: 'email', submitted: true, controller: _emailController,),
                    SizedBox(height: MediaQuery.of(context).size.height/40,),
                    CustomTextField(hintText: 'password', label: 'password', submitted: true,controller: _passwordController,),
                    SizedBox(height: MediaQuery.of(context).size.height/40,),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('You don\'t have an account?  ',style: TextStyle(color: Colors.white,fontSize: 18),),
                  GestureDetector(
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  SignUp()),
                      );
                      
                    },
                    child: Text('Sign up here',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18,decoration: TextDecoration.underline,decorationColor: Colors.white),))
                ],
              ),
              GestureDetector(
                    onTap: () {
                     
                      context.read<CubitCubit>().signUp(
                            email: _emailController.text, 
                            password: _passwordController.text, 
                          );
                    },
                    child: CustomElevaredButton(),
                  ),
                  ],
                ),
              );
  }
}