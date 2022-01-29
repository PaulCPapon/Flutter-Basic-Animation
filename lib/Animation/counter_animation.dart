import 'package:flutter/material.dart';


class CounterAnimator extends StatefulWidget {
  @override
  _CounterAnimatorState createState() => _CounterAnimatorState();
}

class _CounterAnimatorState extends State<CounterAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  int _counter = 0;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 5),
        vsync: this);
    animation = new Tween(begin: 0.0, end: 5.0).animate(_controller)
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        _controller.reverse(from: 2.5);
      } else if ( status == AnimationStatus.reverse) {
        this.setState((){
          _counter = _counter - 400;
          debugPrint("$_counter");
        });
      }

    })
    ..addListener((){
      this.setState((){
        debugPrint("Animation Tween ${animation.value}");


      });
    });

//    animation = new CurvedAnimation(parent: _controller,
//        curve: Curves.easeIn);

    _controller.addListener((){
      this.setState((){
        _counter++;
        debugPrint("print $_counter");
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        _controller.isAnimating
            ? (_counter).toStringAsFixed(2)
            : "Let a begin",
            style: new TextStyle(
              fontSize: 24.0 * animation.value + 16.0
            ),
      ),
      onTap: (){
        _controller.forward(from: 0.0);
      },
    );
  }
}
