import 'package:flutter/material.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';

class Leading extends StatelessWidget {
const Leading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CircleAvatar(
            radius: 20.0,
            backgroundColor: const Color.fromARGB(26, 254, 144, 0),
            child: Icon(Icons.arrow_back, color: AppColors.quaternaryConst),
          ),
        );
  }
}