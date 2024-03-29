import 'dart:math';

import 'package:bahn_bingo/domain/entity/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class BingoGridItem extends StatefulWidget {
  final EventItem item;
  final int cardNumber;
  const BingoGridItem(
      {super.key, required this.item, required this.cardNumber});

  @override
  State<BingoGridItem> createState() => _BingoGridItemState();
}

class _BingoGridItemState extends State<BingoGridItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    reaction((_) => widget.item.done, (done) {
      if (done) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..value = widget.item.done ? 0.0 : 1.0;
    _animation = Tween(end: 1.0, begin: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        color: Theme.of(context).colorScheme.surface,
        child: Observer(builder: (context) {
          if (_controller.isCompleted) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
          return AnimatedBuilder(
            animation: _animation,
            builder: (context, child) => Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0015)
                ..rotateY(pi * _animation.value),
              child: _animation.value <= 0.5
                  ? _buildFront()
                  : Transform.scale(scaleX: -1, child: _buildBack()),
            ),
          );
        }));
  }

  Widget _buildFront() {
    return Container(child: Center(child: Text(widget.cardNumber.toString())));
  }

  Widget _buildBack() {
    return Container(
        decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/logo.png"),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 0,
          blurRadius: 10,
          offset: const Offset(0, -5),
        ),
      ],
    ));
  }
}
