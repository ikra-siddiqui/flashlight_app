import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';

class FlashlightApp extends StatefulWidget {
  const FlashlightApp({super.key});

  @override
  State<FlashlightApp> createState() => _FlashlightAppState();
}

class _FlashlightAppState extends State<FlashlightApp>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  Color color = Colors.white;
  double fontSize = 20;
  bool isClicked = true;
  final controller = TorchController();
  final DecorationTween decorationTween = DecorationTween(
      begin: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 5,
                blurRadius: 20,
                offset: Offset(0, 0))
          ],
          border: Border.all(color: Colors.black)),
      end: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 173, 200, 248),
                spreadRadius: 30,
                blurRadius: 15,
                offset: Offset(0, 0))
          ]));
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      isClicked
                          ? 'https://images.unsplash.com/photo-1505381804491-e1e5bcfd8e97?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                          : 'https://images.unsplash.com/photo-1595565302791-ec72c034cf5c?q=80&w=1895&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    ))),
          ),
          GestureDetector(
            onTap: () {
              if (isClicked) {
                _animationController.forward();
                fontSize = 30;
                color = const Color.fromARGB(255, 177, 219, 239);
              } else {
                _animationController.reverse();
                fontSize = 20;
                color = Colors.white;
              }
              isClicked = !isClicked;
              controller.toggle();
              setState(() {});
            },
            child: Center(
              child: DecoratedBoxTransition(
                  decoration: decorationTween.animate(_animationController),
                  position: DecorationPosition.background,
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Center(
                        child: Icon(
                      Icons.power_settings_new,
                      color: isClicked
                          ? Colors.black
                          : const Color.fromARGB(255, 134, 208, 243),
                      size: 60,
                    )),
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.4,
            child: AnimatedDefaultTextStyle(
                child: Text(isClicked ? 'Flashlight ON' : 'Flashlight OFF'),
                style: TextStyle(
                  color: color,
                  fontSize: fontSize,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,
                ),
                duration: Duration(milliseconds: 200)),
          )
        ],
      ),
    );
  }
}
