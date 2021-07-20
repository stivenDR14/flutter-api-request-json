
import 'package:flutter/material.dart';

class ListaOpcionesView extends StatelessWidget {

  List datos=[];
  final void Function(Map<String,dynamic>) onPressed;

  ListaOpcionesView({Key key,@required this.datos, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
        children:
        datos.map<Widget>((item) =>
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(item["name"]),
              onTap: () {
                onPressed(item);// close the drawer
              },
            ),
        ).toList()
    );
  }
}
