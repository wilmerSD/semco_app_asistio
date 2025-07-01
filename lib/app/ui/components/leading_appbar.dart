import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class LeadingAppbar extends StatelessWidget {
const LeadingAppbar({ super.key });

  @override
  Widget build(BuildContext context){
    return IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Bootstrap.arrow_left,
              size: 20,
              color: Colors.white,
            ),
          );
  }
}