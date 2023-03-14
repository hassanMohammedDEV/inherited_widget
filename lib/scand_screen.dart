import 'package:flutter/material.dart';
import 'package:inherited_wedget/counter_provider.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = CounterProvider.of(context);

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Second screen'),
      ),
      body: Center(
        child: Text(provider!.counter.toString()),
      ),
    );
  }
}
