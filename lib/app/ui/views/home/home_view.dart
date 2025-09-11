import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:semco_app_asistio/app/ui/components/alert_dialog_comp.dart';
import 'package:semco_app_asistio/app/ui/components/btn_primary_ink.dart';
import 'package:semco_app_asistio/app/ui/views/home/home_provider.dart';
import 'package:semco_app_asistio/app/ui/views/home/widgets/appBar_home.dart';
import 'package:semco_app_asistio/app/ui/views/home/widgets/camera_screen.dart';
import 'package:semco_app_asistio/app/ui/views/home/widgets/drawer_menu_app.dart';
import 'package:semco_app_asistio/app/ui/views/home/widgets/recomendations.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';
import 'package:semco_app_asistio/core/theme/app_text_style.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isPlaying = false;
  final confettiController = ConfettiController();
  @override
  void initState() {
    super.initState();
    isPlaying = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeProvider = Provider.of<HomeProvider>(
        context,
        listen: false,
      );
      homeProvider.timeProvider();
      homeProvider.initializeLocalization();
      homeProvider.getInfoAssistant();
    });
    confettiController.addListener(() {
      setState(() {
        isPlaying = confettiController.state == ConfettiControllerState.playing;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    String dateFormatted =
        '${homeProvider.getDayName()} ${homeProvider.getDayNumber()} de ${homeProvider.getMontName()}';
    Widget toolTip = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 33.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Consumer<HomeProvider>(
              builder: (context, homeProvider, child) {
                return Text(
                  homeProvider.currentTime,
                  style: AppTextStyle(context).bold45(
                    color: AppColors.textQuaternaryBasic(context),
                    fontWeight: FontWeight.bold,
                    // height: 5.0
                  ),
                  textHeightBehavior: TextHeightBehavior(),
                );
              },
            ),

            Text(
              dateFormatted,
              style: TextStyle(
                fontSize: 15.0,
                color: AppColors.textQuaternaryBasic(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.backgroundColor(context),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor(context),
                spreadRadius: 4,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.error_outline_rounded, color: Colors.amber),
            iconSize: 28,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialogComp(
                    headerTitle: 'Recomendaciones',
                    widgetContent: Recomendations(),
                  );
                },
              );
            },
          ),
        ),
      ],
    );

    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: AppColors.backgroundColor(context),
      drawer: const DrawerMenuApp(),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
               spacing: 10.0,
              mainAxisAlignment: MainAxisAlignment.start, // Espaciar widgets
        
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(children: [const AppBarHome(), toolTip]),
                ),
                //  InkWell(
                //   onTap: () {
                //     homeProvider.activateConffeti();
                //   },
                //   child: Container(color: Colors.red, height: 40,),
                // ),
                SizedBox(height: 15.0,),
                Consumer<HomeProvider>(
                  builder: (context, homeProvider, child) {
                    return homeProvider.infoAssistObject.asistenciaTipo == 'CO'
                        ? Spacer()
                        : const SizedBox();
                  },
                ),
                Consumer<HomeProvider>(
                  builder: (context, homeProvider, child) {
                    return homeProvider.infoAssistObject.asistenciaTipo == 'CO'
                        ? Container(
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor(context),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowColor(context),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              spacing: 20.0,
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: Lottie.asset(
                                    'assets/Animation_assistance_completed.json',
                                    repeat: false,
                                  ),
                                ),
                                Center(
                                  child: RichText(
                                    textAlign:  TextAlign.center,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '¡Felicidades!',
                                          style: AppTextStyle(context).bold18(color: AppColors.quaternaryConst),
                                        ),
                                        TextSpan(
                                          text:
                                              ' Has completado todas tus asistencias de hoy',
                                          style: AppTextStyle(
                                            context,
                                          ).bold18(fontWeight: FontWeight.w300,color: AppColors.quaternaryConst),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
        
                                BtnPrimaryInk(
                                  text: 'Ok, salir',
                                  onTap: () {
                                    homeProvider.goToLogin(context);
                                  },
                                ),
                                SizedBox(),
                              ],
                            ),
                          ),
                        )
                        : const Expanded(child: CameraScreen());
                  },
                ),
              ],
            ),
            Positioned(
              top: 50.0,
              child: ConfettiWidget(
                gravity: 1.0,
                confettiController: homeProvider.confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                blastDirection: pi / 2,
                numberOfParticles: 300,
                maxBlastForce: 50,
                emissionFrequency: 0.2,
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
