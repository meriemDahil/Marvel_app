
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/cubit/cubit_cubit.dart';
import 'package:marvel/presentation/widgets/custom_text_field.dart';

/*
Your public key
6e145d4e69d4046cbb46449c730a4026
Your private key
d03872f0015c414a6a711a852efbccd6cc17b61f
 */

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _name = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _name.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
                  //height: 30,
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Column(
                    
                    children: [
                      CustomTextField(hintText: 'name', label: 'name', submitted: true,controller: _name,),
                      SizedBox(height: MediaQuery.of(context).size.height/40,),
                      CustomTextField(hintText: 'email', label: 'email', submitted: true, controller: _emailController,),
                      SizedBox(height: MediaQuery.of(context).size.height/40,),
                      CustomTextField(hintText: 'password', label: 'password', submitted: true,controller: _passwordController,),
                      SizedBox(height: MediaQuery.of(context).size.height/40,),
                      
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('I already have an account?  ',style: TextStyle(color: Colors.white,fontSize: 18),),
                    Text('Sign in here',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18,decoration: TextDecoration.underline,decorationColor: Colors.white),)
                  ],
                ),
                ElevatedButton(
                      onPressed: () {
                        // Call SignUp method of AuthenticationCubit to handle authentication
                        context.read<CubitCubit>().signUp(
                              email: _emailController.text, // Get email from TextField
                              password: _passwordController.text, 
                              name: _name.text,// Get password from TextField
                            );
                            },
                      child: const Text('Sign Up'),
                    ),
                    ],
                  ),
                ),
    );
  }
}