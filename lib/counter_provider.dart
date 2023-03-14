import 'package:flutter/material.dart';
// ignore: must_be_immutable
class CounterProvider extends InheritedWidget{
  CounterProvider({super.key, required super.child});

  int counter = 0;

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    // TODO: implement updateShouldNotify
    return oldWidget.counter != counter;
  }

  static CounterProvider? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType();
}