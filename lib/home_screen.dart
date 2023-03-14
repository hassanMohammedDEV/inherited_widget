import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inherited_wedget/counter_provider.dart';
import 'package:inherited_wedget/scand_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = CounterProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const SecondScreen()));
          },
          icon: const Icon(Icons.arrow_forward),
        ),
      ),
      body: Center(
        child:
            StatefulBuilder(
              builder: (context,StateSetter setState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(provider!.counter.toString()),
                    IconButton(onPressed: (){
                      setState(()=> provider.counter ++);
                    }, icon: const Icon(Icons.add)),
                    PlayButton(
                      onPressed: () {
                      },
                    ),
                  ],
                );
              }
            ),
        ),
      );
  }
}

class PlayButton extends StatefulWidget {
  final bool initialIsPlaying;
  final IconData? playIcon;
  final double? playIconSize;
  final Color? playIconColor;
  final IconData? pauseIcon;
  final double? pauseIconSize;
  final Color? pauseIconColor;
  final VoidCallback onPressed;
  final Function? onPause;
  final Color? buttonBackgroundColor;
  final double? height;
  final double? width;

  const PlayButton({super.key,
    required this.onPressed,
    this.initialIsPlaying = false,
    this.playIcon,
    this.pauseIcon, this.buttonBackgroundColor, this.height, this.width, this.playIconColor, this.pauseIconColor, this.playIconSize, this.pauseIconSize, this.onPause,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(milliseconds: 300);
  static const _kRotationDuration = Duration(seconds: 5);

  bool? isPlaying;

  // rotation and scale animations
  AnimationController? _rotationController;
  AnimationController? _scaleController;
  double _rotation = 0;
  double _scale = 0.85;

  bool get _showWaves => !_scaleController!.isDismissed;

  void _updateRotation() => _rotation = _rotationController!.value * 2 * pi;
  void _updateScale() => _scale = (_scaleController!.value * 0.2) + 0.85;

  @override
  void initState() {
    isPlaying = widget.initialIsPlaying;
    _rotationController =
    AnimationController(vsync: this, duration: _kRotationDuration)
      ..addListener(() => setState(_updateRotation))
      ..repeat();

    _scaleController =
    AnimationController(vsync: this, duration: _kToggleDuration)
      ..addListener(() => setState(_updateScale));

    super.initState();
  }

  void _onToggle() {
    setState(() => isPlaying = !isPlaying!);

    if (_scaleController!.isCompleted) {
      if(widget.onPause!=null) widget.onPause!();
      _scaleController!.reverse();
    } else {
      _scaleController!.forward();
    }

    widget.onPressed();
  }

  Widget _buildIcon(bool isPlaying) {
    return SizedBox.expand(
      key: ValueKey<bool>(isPlaying),
      child: InkWell(
        onTap: _onToggle,
        child: isPlaying ? Icon(widget.pauseIcon??Icons.pause,color:
        widget.pauseIconColor?? Colors.black, size: widget.pauseIconSize ?? 25,)  :
        Icon(widget.pauseIcon??Icons.play_arrow,color:
        widget.pauseIconColor?? Colors.black,size: widget.playIconSize ?? 25),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height?? 50,
      width: widget.width?? 50,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_showWaves) ...[
              Blob(color: const Color(0xff0092ff), scale: _scale, rotation: _rotation),
              Blob(color: const Color(0xff4ac7b7), scale: _scale, rotation: _rotation * 2 - 30),
              Blob(color: const Color(0xffa4a6f6), scale: _scale, rotation: _rotation * 3 - 45),
            ],
            Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.buttonBackgroundColor?? Colors.white,
              ),
              child: AnimatedSwitcher(
                duration: _kToggleDuration,
                child: _buildIcon(isPlaying!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scaleController!.dispose();
    _rotationController!.dispose();
    super.dispose();
  }
}

class Blob extends StatelessWidget {
  final double rotation;
  final double scale;
  final Color color;

  const Blob({super.key, required this.color, this.rotation = 0, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(150),
              topRight: Radius.circular(240),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(180),
            ),
          ),
        ),
      ),
    );
  }
}
