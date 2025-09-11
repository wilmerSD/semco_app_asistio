import "dart:io";
import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:semco_app_asistio/app/ui/components/btn_cancel.dart";
import "package:semco_app_asistio/app/ui/components/btn_primary_ink.dart";
import "package:semco_app_asistio/app/ui/components/btn_secondary.dart";
import "package:semco_app_asistio/app/ui/components/field_form.dart";
import "package:semco_app_asistio/app/ui/views/home/home_provider.dart";
import "package:semco_app_asistio/core/theme/app_colors.dart";

class CameraScreenCopy2 extends StatefulWidget {
  const CameraScreenCopy2({super.key});

  @override
  State<CameraScreenCopy2> createState() => _CameraScreenState();
}

enum WidgetState { NONE, LOADING, LOADED, ERROR }

class _CameraScreenState extends State<CameraScreenCopy2> {
  WidgetState _widgetState = WidgetState.NONE;
  late List<CameraDescription> _cameras;
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    initializeCamera();
    // Future.microtask(() {
    //   Provider.of<HomeController>(context, listen: false).getInfoAssistant();
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homecontroller =
          Provider.of<HomeProvider>(context, listen: false);
      await homecontroller.initialize();
      homecontroller.getInfoAssistant();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    switch (_widgetState) {
      case WidgetState.NONE:
        return _buildScaffold(context,
            const Center(child: CircularProgressIndicator(color: AppColors.primaryConst)));
      case WidgetState.LOADING:
        return _buildScaffold(
            context,
            const Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryConst,
            )));
      case WidgetState.LOADED:
        final homecontroller =
            Provider.of<HomeProvider>(context, listen: true);

        Widget comment = FieldForm(
          label: "Comentario",
          maxlines: 2,
          hintText:
              "Ej: Buen día estimado(a) ...,\nEl motivo de mi tardanza es \n...Gracias de antemano por su comprención",
          textInputType: TextInputType.emailAddress,
          textEditingController: homecontroller.ctrlComment,
        );

        return _buildScaffold(
            context,
            Stack(
              children: [
                homecontroller.imageFile == null
                    ? CameraPreview(_cameraController)
                    : Column(
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          Center(
                              child: Image.file(
                                  /* height: 1500.h */ homecontroller
                                      .imageFile!)),
                        ],
                      ),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 5),
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0)),
                          color: AppColors.containerBtnCamera(context)
                        ),
                      ),
                    ),
                    homecontroller.imageFile == null
                        ? AnimatedAlign(
                            duration: const Duration(seconds: 15),
                            alignment: homecontroller.isCentered
                                ? Alignment.bottomCenter
                                : Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: BtnCancel(
                                text: homecontroller.imageFile == null
                                    ? "Capturar"
                                    : "Volver a capturar",
                                onTap: () {
                                  homecontroller.imageFile == null
                                      ? _takePicture()
                                      : initializeCamera();
                                  homecontroller.imageFile = null;
                                },
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  color: AppColors.backgroundColor(context),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.shadowColor(context),
                                      spreadRadius: 4,
                                      blurRadius: 7,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      BtnSecondary(
                                        text: homecontroller.imageFile == null
                                            ? "Capturar"
                                            : "Volver a capturar",
                                        onTap: () {
                                          homecontroller.getInfoAssistant();
                                          homecontroller.imageFile == null
                                              ? _takePicture()
                                              : initializeCamera();
                                          homecontroller.imageFile = null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      homecontroller
                                              .dataInfoAssistant.isNotEmpty
                                          ? BtnPrimaryInk(
                                              loading: homecontroller
                                                  .isRegisteredAssist,
                                              isGreen: true,
                                              text:
                                                  "REGISTRAR ${homecontroller.infoAssistObject.asistenciaTipoDescription}",
                                              onTap: () async {
                                                homecontroller
                                                    .postRegisterAssist(
                                                        context);
                                                
                                              })
                                          : const SizedBox(),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      comment
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ],
            ));
      case WidgetState.ERROR:
        return _buildScaffold(
            context,
            Stack(children: [
              /* Align(
              alignment: Alignment.bottomCenter,
              child: CameraPreview(_cameraController)), */
              /* CameraPreview(_cameraController), */
              Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, .8),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: BtnCancel(
                          text: "Capturar",
                          onTap: () async {
                            _takePicture();
                          },
                        )),
                  )
                ],
              ),
            ]) /* Center(child: Text("La camara no se pudo inicializar")) */);
    }
  }

  Widget _buildScaffold(BuildContext context, Widget body) {
    final homecontroller = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      body: body,
      /* floatingActionButton: FloatingActionButton(
       
          onPressed: () {
          homecontroller.goToHome(context);
          
        },
        foregroundColor: Colors.yellow,
        splashColor: Colors.blue,
        highlightElevation:10.0,
        isExtended: true,
        //backgroundColor: Colors.transparent,
        child: BtnCancel(text:"Capturar"),
        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat */
    );
  }

  Future<void> _takePicture() async {
    final homecontroller = Provider.of<HomeProvider>(context, listen: false);
    try {
      /* await _initializeControllerFuture; */
      final XFile xfile = await _cameraController.takePicture();
      final bytes = await xfile.readAsBytes();
      homecontroller.updateImageBytes(bytes); // <-- Crea esta función para guardar los bytes
      homecontroller.updateImageFile(File(xfile.path));
      setState(() {});
      /* setState(() {
        
        _imageFile = File(xfile.path);
      }); */
    } catch (e) {
      print('Error al tomar la foto: $e');
    }
  }

  Future initializeCamera() async {
    _widgetState = WidgetState.LOADING;
    if (mounted) {
      setState(() {});
    }
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        final camera = _cameras.firstWhere(
          (c) => c.lensDirection == CameraLensDirection.front,
          orElse: () => _cameras.first,
        );
        _cameraController = CameraController(camera, ResolutionPreset.low);
        // _cameraController = CameraController(_cameras[0], ResolutionPreset.low);
        await _cameraController.initialize();
        if (mounted) {
          setState(() {
            _widgetState = WidgetState.LOADED;
          });
        }
      } else {
        setState(() {
          _widgetState = WidgetState.ERROR;
        });
      }
    } catch (e) {
      setState(() {
        _widgetState = WidgetState.ERROR;
      });
      print("Error al inicializar la cámara: $e");
    }
  }
}
