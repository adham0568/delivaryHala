library gradient_slide_to_act;

import 'dart:async';

import 'package:flutter/material.dart';

class SwipButton extends StatefulWidget {
  ///  the width of the SlidableButton
  final double width;

  ///  the height of the SlidableButton
  final double height;

  ///  the size of the draggable icon
  final double iconSize;

  /// the borderRAdius of the SlidableButton
  final double borderRadius;

  /// the text shown in the SlidableButton
  final String text;

  /// the style of the text shown in the SlidableButton
  final TextStyle? textStyle;

  /// the icon of the sliderButtonIcon [ wich the user drag]
  final IconData? sliderButtonIcon;

  /// the duration of the animation when the user slide the button
  final Duration animationDuration;

  /// this function will called when the user slide the button
  final VoidCallback onSubmit;

  /// the gradient of the submitted par of the container
  final Gradient? gradient;

  /// the background color of the button
  final Color backgroundColor;

  /// the icon when the user submit
  final IconData? submittedIcon;

  /// the  draggable icon of the SlidableButton
  final IconData dragableIcon;

  /// the background of the  draggable icon of the SlidableButton
  final Color? dragableIconBackgroundColor;

  /// you can also add your costom  draggable widget
  final Widget? draggableWidget;

  SwipButton(
      {Key? key,
        required this.onSubmit,
        required this.width,
        required this.height ,
        required this.iconSize,
        required this.borderRadius,
        required this.text,
        this.textStyle,
        required this.dragableIconBackgroundColor,
        this.submittedIcon,
        this.draggableWidget,
        this.dragableIcon = Icons.arrow_forward_ios,
        this.sliderButtonIcon,
        this.animationDuration = const Duration(milliseconds: 300),
        required this.gradient,
        required this.backgroundColor})
      : assert(width != double.infinity, "width should not be equal infinity"),
        assert(iconSize <= height,
        "the size of the icon {iconSize} should be < height"),
        super(key: key);

  @override
  State<SwipButton> createState() =>
      _SwipButtonState();
}

class _SwipButtonState extends State<SwipButton>
    with SingleTickerProviderStateMixin {
  /// default Values

  double _position = 0;
  bool _submitted = false;
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.width;
    double position_percent = _position / (widget.width - 2 * widget.height);
    setState(() {
      Timer(Duration(seconds: 3),(){      _submitted=false;_position=0;});
    });
    return AnimatedContainer(
      duration: widget.animationDuration,
      height: widget.height,
      width: _submitted ? widget.height : widget.width,
      decoration: BoxDecoration(// 0Xff172663
          borderRadius: BorderRadius.circular(widget.borderRadius),
          gradient: !_submitted ?  widget.gradient:widget.gradient),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(52),
        child: _submitted
            ? Icon(widget.submittedIcon ?? Icons.done,color: Colors.white,size: w/12,)
            : Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 70),
                      height: widget.height,
                      width: _position + widget.height,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(52),
                          gradient:LinearGradient(colors: [Colors.green,Colors.yellowAccent])),
                    ),
                  ],
                )),
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: Center(
                  child: Text(widget.text,
                      style:
                          TextStyle(
                              color: Colors.white, fontSize:w/18,fontWeight: FontWeight.bold)),
                )),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Row(
                children: [
                  GestureDetector(
                    onPanUpdate: (details) async {
                      _position += details.delta.dx;
                      if (_position < 0) {
                        _position = 0;
                        setState(() {});
                      } else if (_position >=
                          (widget.width - widget.height - 20)) {
                        _position = widget.width - widget.height;
                        if (!_submitted) {
                          _submitted = true;
                          setState(() {});
                          Duration _dur =
                              const Duration(milliseconds: 200) +
                                  (widget.animationDuration);
                          await Future.delayed(_dur);
                          if (mounted) widget.onSubmit();
                          return;
                        }
                        _submitted = true;
                        setState(() {});
                      }
                      setState(() {});

                    },
                    onPanEnd: (_) {
                      position_percent = 0;
                      _position = 0;
                      setState(() {});
                    },
                    child: AnimatedPadding(
                      duration: const Duration(milliseconds: 70),
                      padding: EdgeInsets.only(left: _position),
                      child: widget.draggableWidget ??
                          _draggableWidget(
                            iconSize: widget.height,
                            gradient: widget.gradient,
                            dragableIconBackground:
                            widget.dragableIconBackgroundColor,
                            dragableIcon: widget.dragableIcon,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _draggableWidget extends StatelessWidget {
  final double iconSize;
  final Gradient? gradient;
  final Color? dragableIconBackground;
  final IconData dragableIcon;

  const _draggableWidget(
      {Key? key,
        required this.iconSize,
        this.gradient,
        this.dragableIconBackground,
        required this.dragableIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Container(
      height: iconSize,
      width: iconSize,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(52),
          color: dragableIconBackground,
          gradient: dragableIconBackground != null ? null : gradient),
      alignment: Alignment.center,
      child:  Icon(dragableIcon,color: Colors.white,size: w/15,),
    );
  }
}
