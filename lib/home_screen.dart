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
                    }, icon: const Icon(Icons.add))
                  ],
                );
              }
            ),
        ),
      );
  }
}
