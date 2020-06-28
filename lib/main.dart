import 'package:camera/camera.dart';
import 'package:confidence_detector/widgets/detector.widget.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  // Get a specific camera from the list of available cameras.
  final camera = cameras[1];
  runApp(MaterialApp(
    title: 'Confidence Detector',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: App(
      camera: camera,
    ),
    debugShowCheckedModeBanner: false,
  ));
}

class App extends StatefulWidget {
  App({Key key, @required this.camera}) : super(key: key);
  final CameraDescription camera;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Wait until the controller is initialized before displaying the
      // camera preview.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              children: [CameraPreview(_controller), DetectorWidget()],
            );
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
