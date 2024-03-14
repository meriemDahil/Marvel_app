import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/cubit/cubit_cubit.dart';
import 'package:marvel/presentation/widgets/custom_text_field.dart';

/*

class WelcomePage extends StatelessWidget {
  
  WelcomePage({super.key});
  final List<String> imageUrls = [
    'assets/poster1.jpg',
    'assets/poster2.jpg',
    'assets/poster3.jpg',
  ];
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[ PageView.builder(
          controller: _pageController,
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return Image.asset(
              imageUrls[index],
              fit: BoxFit.cover,
            );
          },
        ),
        Positioned(
          height: 100,
          bottom: 0,
          left: MediaQuery.of(context).size.width /3,
          right: 0,
          
          child: SmoothPageIndicator(
          controller: _pageController,
          count: imageUrls.length, 
          effect: const ExpandingDotsEffect(
            activeDotColor: Color.fromARGB(255, 2, 34, 61),
            dotHeight: 20,
            dotWidth: 20,
            dotColor: Colors.black
          ),))
      ]),
    );
  }
}
*/

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
    return Scaffold(
      backgroundColor: Colors.black,
       body: SingleChildScrollView(
         child: Column(
           children: [
             Container(
              height: MediaQuery.of(context).size.height/1.9,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/welcome.png"),
                  fit: BoxFit.contain,
                ),
              ),
              ),
              Container(
                //height: 30,
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Column(
                  children: [
                    CustomTextField(hintText: 'email', label: 'email', submitted: true, controller: _emailController,),
                    SizedBox(height: MediaQuery.of(context).size.height/40,),
                    CustomTextField(hintText: 'password', label: 'password', submitted: true,controller: _passwordController,),
                  ],
                ),
              ),
               SizedBox(height: MediaQuery.of(context).size.height/40,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You don\'t have an account?  ',style: TextStyle(color: Colors.white,fontSize: 18),),
                  Text('Sign up here',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18,decoration: TextDecoration.underline,decorationColor: Colors.white),)
                ],
              ),
              ElevatedButton(
                    onPressed: () {
                      // Call signIn method of AuthenticationCubit to handle authentication
                      context.read<CubitCubit>().signIn(
                            email: _emailController.text, // Get email from TextField
                            password: _passwordController.text, // Get password from TextField
                          );
                    },
                    child: Text('Sign In'),
                  ),
              
         
           ],
         ),
       ),
    );
  }
}