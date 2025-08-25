import 'package:flutter/material.dart';

class ProfileDetailTile extends StatelessWidget{
  String title;
  String value;

  ProfileDetailTile({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style:Theme.of(context).textTheme.bodyMedium),
      subtitle: Text(value),
    );
  }
}
