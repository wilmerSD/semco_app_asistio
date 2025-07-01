import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semco_app_asistio/app/ui/views/recoverpass/recover_password_controller.dart';

class RecoverPasswordView extends StatelessWidget {
  const RecoverPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recoverpassController = Provider.of<RecoverPassController>(context);
    return Scaffold(
      body: 
      Column(children: [
        
      ],)
    );
  }
}
