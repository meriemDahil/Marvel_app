import 'package:flutter/material.dart';
import 'package:marvel/presentation/screens/sign_in.dart';

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
              const SignIn(),
             
               
              
         
           ],
         ),
       ),
    );
  }
}