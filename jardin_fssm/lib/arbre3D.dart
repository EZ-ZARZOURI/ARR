import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class Arbre3DPage extends StatefulWidget {
  @override
  _Arbre3DPageState createState() => _Arbre3DPageState();
}

class _Arbre3DPageState extends State<Arbre3DPage> {
  late Object jet;

  @override
  void initState() {
    jet = Object(fileName: "assets/jet/Tree.obj");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 54, 244, 212),
        title: Text("Arbre 3D"),
      ),
      body: Stack(
        children: [
          Center(
            child: ClipOval(
              child: Container(
                width: 200, // Ajustez la largeur et la hauteur selon vos besoins
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/télécharger.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Cube(
              onSceneCreated: (Scene scene) {
                scene.world.add(jet);
              },
            ),
          ),
        ],
      ),
    );
  }
}
