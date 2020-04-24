import 'package:cazdata_frontend/util/colors.dart';
import 'package:flutter/material.dart';

class DataProtectionWidget extends StatelessWidget {
  const DataProtectionWidget();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        "Valoramos tu privacidad",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        textAlign: TextAlign.center,
      ),
      content: new Text(
        "Nosotros y nuestros partners usamos algunas tecnologías como “cookies” en nuestra aplicación para personalizar el contenido del usuario. Gracias a esto ofrecemos a nuestros usuarios una experiencia que se ajuste al uso que de de este. Pulsa “Aceptar” abajo para consentir el uso de esta tecnología en nuestra aplicación. Pues cambiar tu elección en cualquier momentos en el menú de ajustes",
        style: TextStyle(fontSize: 12),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        new ButtonBar(
          buttonMinWidth: 125,
          alignment: MainAxisAlignment.center,
          children: [
            new FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: primaryColor)),
              child:
                  new Text("No acepto", style: TextStyle(color: primaryColor)),
              onPressed: () {},
            ),
            new FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: primaryColor)),
              color: primaryColor,
              child: new Text("Acepto", style: TextStyle(color: Colors.white)),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
