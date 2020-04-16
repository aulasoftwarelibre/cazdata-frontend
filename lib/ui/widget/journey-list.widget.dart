import 'package:cazdata_frontend/services/bloc/journey.bloc.dart';
import 'package:cazdata_frontend/services/networking/index.dart';
import 'package:cazdata_frontend/ui/widget/journey-tile.widget.dart';
import 'package:flutter/material.dart';


class JourneysList extends StatelessWidget {

  JourneysList();

  Widget build(BuildContext context) {
    final JourneyBloc _bloc = JourneyBloc();
    _bloc.getJournies();


    return StreamBuilder<Response<dynamic>>(
        stream: _bloc.journeyStreamJourneys,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
                break;

              case Status.COMPLETED:
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.data.journies.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),                            
                            child: JourneyTile(journey: snapshot.data.data.journies[index]),
                          );
                        }));
                break;
              case Status.ERROR:
                return Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Error al recibir jornadas",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                );
                break;
            }
          }
          return Container();
        });
  }
}