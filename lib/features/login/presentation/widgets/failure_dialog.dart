import 'package:flutter/material.dart';

class FailureDialog extends StatelessWidget{
  String msg;
   FailureDialog({super.key,required this.msg});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
        backgroundColor: Colors.grey[200],
        title: Text(
          "Error",
          style: TextStyle(color: Colors.black),
        ),
        content: Text(
          msg,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "okay",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
  }
}
