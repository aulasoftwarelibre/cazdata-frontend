import 'package:cazdata_frontend/model/journey.dart';
import 'package:cazdata_frontend/services/bloc/journey.bloc.dart';
import 'package:cazdata_frontend/services/networking/index.dart';
import 'package:cazdata_frontend/services/repository/journey.repository.dart';
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
                return Container(
                    height: 400.0, // Change as per your requirement
                    width: 300.0,
                    child: ListView.builder(
                        itemCount: snapshot.data.data.journies.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),                            
                            child: JourneyTile(title: snapshot.data.data.journies[index].title, startTime: snapshot.data.data.journies[index].startTime),
                          );
                        }));
                break;
              case Status.ERROR:
                return Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Error retrieving journies",
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