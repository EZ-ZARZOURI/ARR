import 'package:flutter/material.dart';

class MoreInfoPage extends StatelessWidget {
  final String qrData; // Tu peux passer les données du QR Code à cette page

  MoreInfoPage(this.qrData);

  @override
  Widget build(BuildContext context) {
    // Ici, tu peux ajouter d'autres informations que tu souhaites afficher
    // Utilise ces informations en fonction de tes besoins
    // Par exemple, si tu as des détails supplémentaires dans une liste, tu peux les afficher ainsi :

    List<String> additionalInfo = ['Info 1', 'Info 2', 'Info 3'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 54, 244, 212),
        title: Text('Informations supplémentaires'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Détails du code QR :',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                qrData,
                style: TextStyle(fontSize: 16),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
