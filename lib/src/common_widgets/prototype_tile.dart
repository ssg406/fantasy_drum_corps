import 'package:flutter/material.dart';

class PrototypeTile extends StatelessWidget {
  const PrototypeTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        width: 50,
        height: 25,
        color: Colors.black12,
      ),
      subtitle: Container(
        width: 100,
        height: 40,
        color: Colors.black12,
      ),
    );
  }
}
