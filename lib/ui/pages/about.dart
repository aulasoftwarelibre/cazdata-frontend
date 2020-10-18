import 'package:cazdata_frontend/ui/widget/about-species-list.widget.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: PageScrollPhysics(),
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Acerca de',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Está aplicación ha sido desarrollada por el Aula de Software Libre de la Universidad de Córdoba. Los recursos gráficos utilizados pertenecen a sus correspondientes autores.',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      'Recursos gráficos',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      'Los recursos gráficos utilizados pertenecen a sus correspondientes autores.',
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(child: AnimalSpeciesList()),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
