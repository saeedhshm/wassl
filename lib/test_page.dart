import 'package:flutter/material.dart';

import 'helpers/constants/print_ln.dart';

class TestCodesPage extends StatefulWidget {

  @override
  State<TestCodesPage> createState() => _TestCodesPageState();
}

class _TestCodesPageState extends State<TestCodesPage> {
  var groupValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Menu'),
      ),
      body: Container(
        color: Colors.white,

      ),
    );
  }
}


