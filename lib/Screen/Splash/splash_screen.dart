import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';

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
                          ColorElements(
                            suffix: 'orange',
                            milliseconds: 300,
                          ),
                          ColorElements(
                            suffix: 'red',
                            milliseconds: 100,
                          ),
                        ],
                      ),
                      RowSuper(
                        innerDistance: -size.width * 0.4,
                        children: [
                          ColorElements(
                            suffix: 'blue',
                            milliseconds: 150,
                          ),
                          ColorElements(
                            suffix: 'purple',
                            milliseconds: 200,
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

class ColorElements extends StatefulWidget {
  final int milliseconds;
  final String suffix;

  const ColorElements({
    this.milliseconds,
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
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _controller.forward();

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
    return AnimatedBuilder(
        animation: _controller,
        builder: (ctx, _) {
          return Container(
            height: _heightAnimation.value,
            child: Image.asset(
              'assets/images/${widget.suffix}.png',
              scale: 2,
            ),
          );
        });
  }
}
