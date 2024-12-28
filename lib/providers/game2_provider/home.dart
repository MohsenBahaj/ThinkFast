import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/game2_provider/game2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    initlizeation();
    super.initState();
  }

  initlizeation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call the method safely
      final provider = Provider.of<SequenceProvider>(context, listen: false);
      provider.generateSequence();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ThinkFast'),
      ),
      body: Consumer<SequenceProvider>(builder: (context, dynamic, child) {
        return Center(
          child: Container(
            child: Text(dynamic.sequence.toString()),
          ),
        );
      }),
    );
  }
}
