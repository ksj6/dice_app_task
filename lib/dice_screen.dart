// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class DiceScreen extends StatefulWidget {
  @override
  _DiceScreenState createState() => _DiceScreenState();

  static const String id = '/dice_screen';
}

class _DiceScreenState extends State<DiceScreen>
    with SingleTickerProviderStateMixin {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;
  int total = 0;
  int temp = 1;
  int currentIndex = 0;

  // animation controller added for controlling the duration and type of animation
  late AnimationController _controller;
  late Animation<double> _animation;
  late CurvedAnimation animation;
  //late AnimationController _textAnimationController;
  //final ItemScrollController _scrollController = ItemScrollController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    //animate();
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.easeInCubic);
    animation.addListener(() {
      setState(() {});
      // print(_controller.value);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          // using the random integers for dice rolling
          leftDiceNumber = Random().nextInt(6) + 1;
          rightDiceNumber = Random().nextInt(6) + 1;
          total += (leftDiceNumber + rightDiceNumber);
        });
        _controller.reverse();
      }
    });
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
      reverseCurve: Curves.easeOut,
    ).drive(Tween<double>(begin: 0.0, end: 1.0));

    // _textAnimationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 500),
    // );
  }

  AudioPlayer player = AudioPlayer(); // generating (an object) for AudioPlayer

  Future<void> _playAudio() async {
    try {
      await player.setAsset('audio/dice_audio.mp3');
      await player.play();
    } catch (e) {
      // handle any errors here
    }
  }

// a funtion to dsiplay forward rolling of the dice
// ignore: non_constant_identifier_names
// roll_the_dice also contains the _playAudio function which will be then used in the onDoubleTap

  void roll_the_dice() {
    _controller.forward();
    _playAudio();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("images/background6.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.restore,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, DiceScreen.id);
                  });
                  // use .pushnamed and give the route of copy.dart where all the code of dice screen is exactly the
                  // the same in copy.dart and there , navigator.context.pushnaemed is used
                }),
            centerTitle: true,
            flexibleSpace: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(250)),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('images/appbar_image3.jpg'),
                  fit: BoxFit.cover,
                )),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(right: 150.0),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Text(
                    "DICE GAME ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize:
                          MediaQuery.of(context).size.width < 600 ? 18 : 24,
                    ),
                  );
                },
              ),
            ),
            backgroundColor: Colors.pink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(250)),
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Text(
                    'TOTAL',
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize:
                            MediaQuery.of(context).size.width < 600 ? 18 : 24,
                        fontWeight: FontWeight.w900),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              TotalCounter(total),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Timer.periodic(const Duration(milliseconds: 80),
                            (timer) {
                          temp++;
                          setState(() {
                            leftDiceNumber = Random().nextInt(6);
                            rightDiceNumber = Random().nextInt(6);
                          });
                          if (temp >= 13) {
                            timer.cancel();

                            setState(() {
                              temp = 1;
                            });
                          }
                        });
                        roll_the_dice();
                        _playAudio();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Image(
                          height: 200 - (animation.value) * 200,
                          image: AssetImage(
                            'images/dice_img$leftDiceNumber.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Timer.periodic(const Duration(milliseconds: 80),
                            (timer) {
                          temp++;
                          setState(() {
                            rightDiceNumber = Random().nextInt(6);
                            leftDiceNumber = Random().nextInt(6);
                          });
                          if (temp >= 13) {
                            timer.cancel();

                            setState(() {
                              temp = 1;
                            });
                          }
                        });
                        roll_the_dice();
                        _playAudio();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Image(
                          height: 200 - (animation.value) * 200,
                          image:
                              AssetImage('images/dice_img$rightDiceNumber.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Text(
                          "the total of the current roll:",
                          style: TextStyle(
                              color: Colors.white,
                              // using mediaquery here
                              fontSize: MediaQuery.of(context).size.width < 600
                                  ? 17
                                  : 22,
                              fontWeight: FontWeight.normal),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    '${leftDiceNumber + rightDiceNumber}',
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 45,
                        fontWeight: FontWeight.w800),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      // return MaterialApp(
      //   home: Container(
      //     decoration: BoxDecoration(
      //         image: DecorationImage(
      //             image: AssetImage("images/appbar_image1.jpg"),
      //             fit: BoxFit.cover)),
      //     child: Scaffold(
    );
  }
}

class TotalCounter extends StatelessWidget {
  final int total;

  TotalCounter(
    this.total,
  );

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: total),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Text(
          '$value',
          style: TextStyle(
            fontSize: 91,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
