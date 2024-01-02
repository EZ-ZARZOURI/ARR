import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:video_player/video_player.dart';
import 'about.dart';
import 'arbre3D.dart';
import 'MoreInfoPage.dart'; // Importe le fichier MoreInfoPage.dart


late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jardin FSSM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AccueilPage(),
    );
  }
}

class AccueilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jardin FSSM'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo_faculte.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'APPLICATION JARDIN FSSM',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraPage(cameras)),
                );
              },
              child: Text('Scanner QR'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Arbre3DPage()), // Dirige vers Scanner3DPage
                );
              },
              child: Text('Arbre 3D'),
            ),
            SizedBox(height: 20), // Espacement entre les boutons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AboutPage()), // Navigation vers la page About
                );
              },
              child: Text('About'),
            ),
          ],
        ),
      ),
    );
  }
}

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraPage(this.cameras);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  final FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false; // Track if TTS is speaking
  bool showMoreInfoButton =
      false; // Track if the More Info button should be shown
  late String qrResult = ''; // Declare qrResult accessible within the class

  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    flutterTts.setStartHandler(() {
      setState(() {
        isSpeaking = true;
      });
    });
    flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
        showMoreInfoButton =
            true; // Show More Info button after audio/video completion
      });
    });

    _videoController = VideoPlayerController.asset('assets/your_video.mp4');
    _initializeVideoPlayerFuture = _videoController.initialize().then((_) {
      setState(() {});
    });
    _videoController.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoController.dispose();
    super.dispose();
  }

  Future<void> _scanQR() async {
    try {
      qrResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (qrResult != '-1') {
        print('Données du QR Code : $qrResult');
        await flutterTts.speak(qrResult);

        // Démarrer la lecture de la vidéo lors de la lecture audio du QR code
        _videoController.play();
        while (isSpeaking) {
          if (_videoController.value.position >=
              _videoController.value.duration) {
            _videoController.seekTo(Duration.zero);
          }
          await Future.delayed(Duration(milliseconds: 200));
        }

        // Naviguer vers MoreInfoPage après la fin de la lecture audio et vidéo

        setState(() {
          isSpeaking = false; // Arrête le TTS
          showMoreInfoButton =
              true; // Maintenant que la vidéo et l'audio sont terminés, affiche le bouton
        });
      } else {
        print('Scan annulé par l\'utilisateur');
      }
    } catch (ex) {
      print('Erreur : $ex');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Page de la Caméra'),
      ),
      body: Stack(
        children: [
          CameraPreview(_controller),
          // Afficher la vidéo en superposition quand la lecture audio est en cours
          if (isSpeaking && _videoController.value.isInitialized)
            Center(
              child: AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              ),
            ),
          // Afficher le bouton "More Info" après la fin de la lecture audio et vidéo
          if (showMoreInfoButton)
            Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MoreInfoPage(qrResult),
                    ),
                  );
                },
                child: Text('More Info'),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanQR,
        child: Icon(Icons.qr_code_scanner),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
