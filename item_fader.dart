
import 'package:flutter/material.dart';

class ItemFader extends StatefulWidget {
  final Widget child;
  final int index;
  final int maxIndex;
  final int animationDuration;
  final int maxDuration;

  const ItemFader({Key key, @required this.child, @required this.index,
   this.maxIndex = 6, this.animationDuration = 150, this.maxDuration = 600 }) : super(key: key);

  @override
  _ItemFaderState createState() => _ItemFaderState();
}

class _ItemFaderState extends State<ItemFader>
    with SingleTickerProviderStateMixin {
  int position = 1;
  AnimationController _animationController;
  Animation _animation;

  void show() {
    setState(() => position = 1);
    _animationController.forward();
  }

  void hide() {
    setState(() => position = -1);
    _animationController.reverse();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.maxDuration),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    Future.delayed(
      Duration(
        milliseconds: widget.index < widget.maxIndex ? widget.animationDuration * widget.index : widget.animationDuration * widget.maxIndex
        )
    ).then((_){
      show();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 10 * position * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
