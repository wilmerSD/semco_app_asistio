import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semco_app_asistio/app/ui/components/btn_primary_ink.dart';
import 'package:semco_app_asistio/app/ui/components/field_form.dart';
import 'package:semco_app_asistio/app/ui/views/recoverpass/recover_password_provider.dart';
import 'package:semco_app_asistio/app/ui/views/recoverpass/widgets/leading.dart';
import 'package:semco_app_asistio/app/ui/views/recoverpass/widgets/text_back_login.dart';
import 'package:semco_app_asistio/app/ui/views/recoverpass/widgets/text_tittle.dart';

class RecoverPasswordEmail extends StatelessWidget {
  const RecoverPasswordEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverpassController = Provider.of<RecoverPassProvider>(context);

    /* 📌 Input de email */
    Widget inputEmail = FieldForm(
      label: "Email",
      hintText: "Ingrese correo email",
      textInputType: TextInputType.emailAddress,
      textEditingController: recoverpassController.ctrlEmail,
    );

    /* 📌 btn para enviar código de verificación */
    Widget getCodeVerification = BtnPrimaryInk(
      text: recoverpassController.isLoading ? "Enviando..." : "Obtener código",
      loading: recoverpassController.isLoading,
      onTap: () => recoverpassController.validateEmail(context),
    );

    Widget backLogin = Column(
      children: [
        InkWell(
          onTap: () => recoverpassController.goToLogin(context),
          child: Center(child: TextBackLogin()),
        ),
        SizedBox(height: 15.0),
      ],
    );

    return Scaffold(
      appBar: AppBar(leading: Leading()),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20.0,
          children: [
            TextTittle(
              tittle: '¿Olvidaste tu contraseña',
              subTittle:
                  'No te preocupes, eso pasa. Por favor, ingrese su email asociado con su cuenta',
            ),
            inputEmail,
            getCodeVerification,
            const Spacer(),
            backLogin,
          ],
        ),
      ),
    );
  }
}
