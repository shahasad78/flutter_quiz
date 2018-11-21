import 'dart:math';
import 'package:flutter/material.dart';

class AnswerIcon extends StatelessWidget {

  final Animation<double> _animation;
  final double _animationValue;
  final bool _answer;

  AnswerIcon({Animation<double> animation, double animationValue, bool answer})
      : this._animation = animation,
        this._animationValue = animationValue,
        this._answer = answer;

  @override
  Widget build(BuildContext context) {
    final IconData icon = _answer ? Icons.check : Icons.clear;
    final Color iconColor = _answer ? Colors.lightGreen : Colors.red;

    return new Icon(icon, color: iconColor, size: _animation.value * _animationValue,);
  }
}


class CorrectWrongOverlay extends StatefulWidget {

  final bool _isCorrect;
  final String _message;

  final VoidCallback _onTap;

  CorrectWrongOverlay({bool isCorrect, VoidCallback onTap})
      : this._isCorrect = isCorrect,
        this._message = isCorrect ? "Correct" : "Wrong",
        this._onTap = onTap;

  @override
  State createState() => new CorrectWrongOverlayState();
}

class CorrectWrongOverlayState extends State<CorrectWrongOverlay> with SingleTickerProviderStateMixin {

  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;
  
  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(duration: new Duration(milliseconds: 2000), vsync: this);
    _iconAnimation = new CurvedAnimation(parent: _iconAnimationController, curve: Curves.elasticOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }


  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.black54,
      child: new InkWell(
        onTap: () => widget._onTap(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: new Transform.rotate(
                  angle: _iconAnimation.value * 2 * pi,
                  child: new AnswerIcon(
                    animation: _iconAnimation,
                    animationValue: 80.0,
                    answer: widget._isCorrect,
                  )
              ),
            ),
            new Padding(padding: new EdgeInsets.only(bottom: 20.0)),
            new Text(widget._message, style: new TextStyle(color: Colors.white, fontSize: 30.0, fontStyle: FontStyle.italic, fontWeight:  FontWeight.normal),)
          ],
        ),
      ),
    );
  }
}