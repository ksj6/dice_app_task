import 'package:flutter/material.dart';
import 'dice_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
  static const String id = '/splash_screen';
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _animation2 = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.repeat(reverse: true);

    Future.delayed(Duration(seconds: 4), () {
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => Mylogin()));
      Navigator.pushReplacementNamed(context, DiceScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/dice_background_4.gif'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 50, left: 40),
          //   child: Text(
          //     "WELCOME TO THE DICE GAME!",
          //     style: TextStyle(fontSize: 20, color: Colors.white),
          //   ),
          // ),
          Positioned(
            left: 50,
            top: 100,
            child: ScaleTransition(
              scale: _animation2,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Positioned(
            right: 50,
            top: 150,
            child: ScaleTransition(
              scale: _animation2,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Center(
            child: ScaleTransition(
              scale: _animation,
              child: Image.asset(
                'images/dice_2.gif',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 70,
            bottom: 100,
            child: ScaleTransition(
              scale: _animation2,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Positioned(
            right: 70,
            bottom: 150,
            child: ScaleTransition(
              scale: _animation2,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
