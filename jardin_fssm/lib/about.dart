import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 54, 244, 212),
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informations sur l\'application :',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Cette application permet de scanner les codes QR du jardin FSSM pour écouter des informations audio et regarder la lecture d\'une vidéo informative associée. Elle offre également une visualisation en direct du jardin grâce à la caméra du téléphone, offrant ainsi une expérience interactive et éducative aux utilisateurs.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              Divider(height: 1, color: Colors.grey),
              SizedBox(height: 20),
              Text(
                'À propos du jardin FSSM :',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'La Faculté des sciences Semlalia abrite également un jardin botanique qui comprend plus de 300 variétés de plantes. Cette dernière est l’une des principales institutions de l’Université CADY AAYAD. Fondée en 1978, elle a connu un formidable élan dans l’éducation, la recherche scientifique et la collaboration. Cela a donné à l’université une position privilégiée parmi l’enseignement supérieur du pays.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Center(
                child: Image.asset(
                  'assets/image.jpeg',
                  width: 200,
                  height: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
