import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:delayed_display/delayed_display.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          child: Center(
            child: Stack(
              children: [
                Center(
                  child: ColumnSuper(
                    innerDistance: -size.height * 0.25,
                    children: [
                      RowSuper(
                        innerDistance: -size.width * 0.3,
                        children: [
                          DelayedColorElement(
                            suffix: 'orange',
                            delay: 600,
                          ),
                          DelayedColorElement(
                            suffix: 'red',
                            delay: 1200,
                          ),
                        ],
                      ),
                      RowSuper(
                        innerDistance: -size.width * 0.4,
                        children: [
                          DelayedColorElement(
                            suffix: 'blue',
                            delay: 0,
                          ),
                          DelayedColorElement(
                            suffix: 'purple',
                            delay: 900,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    scale: 2,
                    //color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DelayedColorElement extends StatelessWidget {
  final int delay;
  final String suffix;
  const DelayedColorElement({
    this.delay,
    this.suffix,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      fadingDuration: Duration(microseconds: 0),
      slidingBeginOffset: Offset(0.0, 0.0),
      delay: Duration(milliseconds: delay),
      child: ColorElements(
        suffix: suffix,
      ),
    );
  }
}

class ColorElements extends StatefulWidget {
  final String suffix;

  const ColorElements({
    this.suffix,
    Key key,
  }) : super(key: key);

  @override
  _ColorElementsState createState() => _ColorElementsState();
}

class _ColorElementsState extends State<ColorElements>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _heightAnimation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    );

    _controller.forward().whenComplete(() {
      print('done');
    });

    _heightAnimation = Tween<double>(
      begin: 0,
      end: 250,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void>.delayed(Duration(milliseconds: 300));
    return AnimatedBuilder(
        animation: _controller,
        builder: (ctx, _) {
          return Container(
            height: _heightAnimation.value,
            child: Image.asset(
              'assets/images/${widget.suffix}.png',
            ),
          );
        });
  }
}
