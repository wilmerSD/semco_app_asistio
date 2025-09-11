import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:semco_app_asistio/app/ui/components/btn_cancel.dart";
import "package:semco_app_asistio/app/ui/components/btn_primary_ink.dart";
import "package:semco_app_asistio/app/ui/components/btn_secondary.dart";
import "package:semco_app_asistio/app/ui/components/field_form.dart";
import "package:semco_app_asistio/app/ui/views/home/home_provider.dart";
import "package:semco_app_asistio/core/theme/app_colors.dart";

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

enum WidgetState { NONE, LOADING, LOADED, ERROR }

class _CameraScreenState extends State<CameraScreen> {
  WidgetState _widgetState = WidgetState.NONE;
  late List<CameraDescription> _cameras;
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    initializeCamera();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      await homeProvider.initialize();
      // await homeProvider.getInfoAssistant();
    });
  }

  @override
  void dispose() {
    print('DISPOSE CAMERA SCREEN');
    _cameraController.dispose();
    _cameraController.stopImageStream();
    // _cameraController.
    // _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('hola desde camara');
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    switch (_widgetState) {
      case WidgetState.NONE:
        return _buildScaffold(
          context,
          const Center(
            child: CircularProgressIndicator(color: AppColors.primaryConst),
          ),
        );
      case WidgetState.LOADING:
        return _buildScaffold(
          context,
          const Center(
            child: CircularProgressIndicator(color: AppColors.primaryConst),
          ),
        );
      case WidgetState.LOADED:
        Widget comment = FieldForm(
          label: "Comentario",
          maxlines: 2,
          hintText:
              "Ej: Buen día estimado(a) ...,\nEl motivo de mi tardanza es \n...Gracias de antemano por su comprención",
          textInputType: TextInputType.emailAddress,
          textEditingController: homeProvider.ctrlComment,
        );

        return _buildScaffold(
          context,
          Stack(
            children: [
              Consumer<HomeProvider>(
                builder: (context, provider, child) {
                  return provider.imageBytes == null
                      ? Center(
                        
                        // width: double.infinity,
                        child: CameraPreview(_cameraController))
                      : Column(
                        children: [
                          // SizedBox(height: 20.0),
                          Center(
                            // color: Colors.amber,
                            child: Image.memory(provider.imageBytes!),
                            /* Image.file(
                                  /* height: 1500.h */ homecontroller
                                      .imageFile!) */
                          ),
                        ],
                      );
                },
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
                          topLeft: Radius.circular(10.0),
                        ),
                        color: AppColors.containerBtnCamera(context),
                      ),
                    ),
                  ),
                  Consumer<HomeProvider>(
                    builder: (context, provider, child) {
                      return provider.imageBytes == null
                          ? AnimatedAlign(
                            duration: const Duration(seconds: 15),
                            alignment:
                                provider.isCentered
                                    ? Alignment.bottomCenter
                                    : Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: BtnCancel(
                                text:
                                    provider.imageBytes == null
                                        ? "Capturar"
                                        : "Volver a capturar",
                                onTap: () {
                                  provider.imageBytes == null
                                      ? _takePicture()
                                      : initializeCamera();
                                  provider.imageBytes = null;
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
                                    topLeft: Radius.circular(10.0),
                                  ),
                                  color: AppColors.backgroundColor(context),
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
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      BtnSecondary(
                                        text:
                                            provider.imageBytes == null
                                                ? "Capturar"
                                                : "Volver a capturar",
                                        onTap: () {
                                          provider.getInfoAssistant();
                                          provider.imageBytes == null
                                              ? _takePicture()
                                              : initializeCamera();
                                          provider.imageBytes = null;
                                        },
                                      ),
                                      const SizedBox(height: 15.0),
                                      provider.dataInfoAssistant.isNotEmpty
                                          ? BtnPrimaryInk(
                                            loading:
                                                provider.isRegisteredAssist,
                                            isGreen: true,
                                            text:
                                                "REGISTRAR ${provider.infoAssistObject.asistenciaTipoDescription}",
                                            onTap: () async {
                                              provider.postRegisterAssist(
                                                context,
                                              );
                                            },
                                          )
                                          : const SizedBox(),
                                      SizedBox(height: 15.0),
                                      comment,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      case WidgetState.ERROR:
        return _buildScaffold(
          context,
          Stack(
            children: [
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
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ) /* Center(child: Text("La camara no se pudo inicializar")) */,
        );
    }
  }

  Widget _buildScaffold(BuildContext context, Widget body) {
    return body;
    // final homecontroller = Provider.of<HomeController>(context);
    // return Scaffold(
    //   backgroundColor: AppColors.backgroundColor(context),
    //   body: body,
    //   /* floatingActionButton: FloatingActionButton(

    //       onPressed: () {
    //       homecontroller.goToHome(context);

    //     },
    //     foregroundColor: Colors.yellow,
    //     splashColor: Colors.blue,
    //     highlightElevation:10.0,
    //     isExtended: true,
    //     //backgroundColor: Colors.transparent,
    //     child: BtnCancel(text:"Capturar"),

    //   ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat */
    // );
  }

  Future<void> _takePicture() async {
    final homecontroller = Provider.of<HomeProvider>(context, listen: false);
    try {
      /* await _initializeControllerFuture; */
      final XFile xfile = await _cameraController.takePicture();
      final bytes = await xfile.readAsBytes();
      homecontroller.updateImageBytes(
        bytes,
      ); // <-- Crea esta función para guardar los bytes
      // homecontroller.updateImageFile(File(xfile.path));

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
