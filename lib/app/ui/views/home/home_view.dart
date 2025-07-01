import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semco_app_asistio/app/ui/components/alert_dialog_comp.dart';
import 'package:semco_app_asistio/app/ui/views/home/home_controller.dart';
import 'package:semco_app_asistio/app/ui/views/home/widgets/appBar_home.dart';
import 'package:semco_app_asistio/app/ui/views/home/widgets/camera_screen%20copy.dart';
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
      final homecontroller = Provider.of<HomeController>(
        context,
        listen: false,
      );
      homecontroller.timeProvider();
      homecontroller.initializeLocalization();
    });
    confettiController.addListener(() {
      setState(() {
        isPlaying = confettiController.state == ConfettiControllerState.playing;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('hola home');
    final homecontroller = Provider.of<HomeController>(context, listen: false);
    String dateFormatted =
        '${homecontroller.getDayName()} ${homecontroller.getDayNumber()} de ${homecontroller.getMontName()}';
    Widget toolTip = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 33.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Container(
              // color: Colors.amber,
              child: Text(
                homecontroller.currentTime,
                style: AppTextStyle(context).bold45(
                  color: AppColors.textQuaternaryBasic(context),
                  fontWeight: FontWeight.bold,
                  // height: 5.0
                ),
                textHeightBehavior: TextHeightBehavior(),
              ),
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
      backgroundColor: AppColors.backgroundColor(context),
      drawer: const DrawerMenuApp(),
      body: Stack(
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
              //     homecontroller.activateConffeti();
              //   },
              //   child: Container(color:Colors.red, height: 40,),
              // ),
              const Expanded(child: CameraScreen()),
              /* SizedBox(
                height: 10,
              ), */
            ],
          ),

          Positioned(
            top: 50.0,
            child: ConfettiWidget(
              gravity: 1.0,
              confettiController: homecontroller.confettiController,
              blastDirection: pi / 2,
              numberOfParticles: 300,
              maxBlastForce: 50,
              emissionFrequency: 0.2,
              blastDirectionality: BlastDirectionality.explosive,
            ),
          ),
        ],
      ),
    );
  }
}
