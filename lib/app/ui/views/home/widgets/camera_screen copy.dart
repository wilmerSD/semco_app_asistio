/* import "package:app_asistencia/app/ui/views/home/home_controller.dart";
import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";

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
  }

  @override
  Widget build(BuildContext context) {
    
    switch (_widgetState) {
      case WidgetState.NONE:
        return _buildScaffold(
            context, Center(child: CircularProgressIndicator(color:Colors.blue)));
      case WidgetState.LOADING:
        return _buildScaffold(
            context, Center(child: CircularProgressIndicator(color: Colors.red,)));
      case WidgetState.LOADED:
      return _buildScaffold(context, CameraPreview(_cameraController));
      case WidgetState.ERROR:
        return _buildScaffold(
            context, Center(child: Text("La camara no se pudo inicializar")));
    }
  }

  Widget _buildScaffold(BuildContext context, Widget body) {
    final homecontroller = Provider.of<HomeController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Camara"),
        /* elevation: 0, */
      ),
      body: body, 
      floatingActionButton:FloatingActionButton(
          onPressed: () {
          homecontroller.goToHome(context);
        },
        child: Icon(Icons.camera),
      
      ),
    );
  }

  Future initializeCamera() async {
    _widgetState = WidgetState.LOADING;
    if (mounted) //Para verificar si ya se creo el widget
      setState(() {});
    _cameras = await availableCameras();
    _cameraController = new CameraController(_cameras[0], ResolutionPreset.max);
    await _cameraController.initialize();

    if (_cameraController.value.hasError) {
      _widgetState = WidgetState.LOADING;
      if (mounted) //Para verificar si ya se creo el widget
        setState(() {});
    } else {
      _widgetState = WidgetState.LOADING;
    }
  }
}
 */

import "dart:io";
import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:semco_app_asistio/app/ui/components/btn_cancel.dart";
import "package:semco_app_asistio/app/ui/views/home/home_provider.dart";
import "package:semco_app_asistio/core/theme/app_colors.dart";

class CameraScreenCopy extends StatefulWidget {
  const CameraScreenCopy({super.key});

  @override
  State<CameraScreenCopy> createState() => _CameraScreenState();
}

enum WidgetState { NONE, LOADING, LOADED, ERROR }

class _CameraScreenState extends State<CameraScreenCopy> {
  WidgetState _widgetState = WidgetState.NONE;
  late List<CameraDescription> _cameras;
  late CameraController _cameraController;
  File? _imageFile; // Variable para almacenar la foto tomada

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    
    switch (_widgetState) {
      case WidgetState.NONE:
        return _buildScaffold(
            context,const Center(child: CircularProgressIndicator(color:Colors.blue)));
      case WidgetState.LOADING:
        return _buildScaffold(
            context, Center(child: CircularProgressIndicator(color: AppColors.primary(context),)));
      case WidgetState.LOADED: 
            return 
        _buildScaffold(context, Stack(
          children: [
              CameraPreview(_cameraController),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                        color:  Color.fromRGBO(255, 255, 255, .8),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: BtnCancel(text:"Capturar",onTap: (){
                        _takePicture();
                      },)),
                  )
                ],
              ),
              
          ],
        ) 
        );
      case WidgetState.ERROR:
        return _buildScaffold(
          context, Stack(
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
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, .8),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: BtnCancel(text:"Capturar",onTap: () async{  
                        _takePicture();
                      },)),
                  )
                ],
              ),]) /* Center(child: Text("La camara no se pudo inicializar")) */);
    }
  }

  Widget _buildScaffold(BuildContext context, Widget body) {
    final homecontroller = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: body, 
    );
  }
  /* Widget _buildScaffold(BuildContext context, Widget body) {
    final homecontroller = Provider.of<HomeController>(context);
    return Scaffold(
      body: body, 
    );
  } */

  Future<void> _takePicture() async {
    try {
      /* await _initializeControllerFuture; */
      final XFile xfile = await _cameraController.takePicture();
      // Actualizar el estado con la foto tomada
      setState(() {
        _imageFile = File(xfile.path);
      });
      print('Foto tomada😎');
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
      _cameraController =
          CameraController(_cameras[1], ResolutionPreset.low);
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
 


