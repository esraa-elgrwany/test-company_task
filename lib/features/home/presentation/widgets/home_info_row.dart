import 'package:flutter/material.dart';

class HomeInfoRow extends StatelessWidget{
  String title;
  String value;
  HomeInfoRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title: ",
            style: Theme.of(context).textTheme.bodyMedium),
        Expanded(
          child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
