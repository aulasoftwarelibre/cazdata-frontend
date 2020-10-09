import 'package:auto_size_text/auto_size_text.dart';
import 'package:cazdata_frontend/features/hunter/middleware.dart';
import 'package:cazdata_frontend/models/hunter/hunter.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/widget/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel(
          hunter: store.state.hunterState.hunter,
          logout: () {
            store.dispatch(handleLogoutAction(context));
          }),
      builder: (BuildContext context, _ViewModel vm) => _profileView(context, vm),
    );
  }

  Widget _profileView(BuildContext context, _ViewModel vm) {
    List<Widget> getUserLevel(int journiesNumber) {
      Widget icon = Icon(
        Icons.star,
        color: Colors.yellow[600],
        size: 24.0,
        semanticLabel: 'Bullet',
      );
      List<Widget> icons = [icon];

      if (journiesNumber > 5) {
        icons.add(icon);
      }
      if (journiesNumber > 15) {
        icons.add(icon);
      }
      return icons;
    }

    final String userId = vm.hunter.id;
    final Query journeys = FirebaseFirestore.instance.collection('journeys').where('hunterId', isEqualTo: userId);

    return StreamBuilder<QuerySnapshot>(
      stream: journeys.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Error al cargar el perfil");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

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
                              'Cuenta',
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 12.0),
                        child: Text(
                          'Perfil',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                      ProfileWidget(
                          name: vm.hunter.displayName, location: vm.hunter.email, profilePic: vm.hunter.photoUrl),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AutoSizeText(
                                'Nivel Cazador',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: getUserLevel(snapshot.data.docs.length),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: FlatButton(
                              onPressed: () {
                                vm.logout();
                              },
                              color: Colors.red,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(18.0)),
                              child: Text("Cerrar sesión", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final Hunter hunter;
  final Function() logout;

  _ViewModel({
    @required this.hunter,
    @required this.logout,
  });
}
