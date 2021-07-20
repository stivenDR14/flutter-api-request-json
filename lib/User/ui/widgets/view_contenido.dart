
import 'package:flutter/material.dart';
import 'package:flutter_prueba_api_json/User/model/usuario.dart';

class ContenidoView extends StatelessWidget {

  Usuario user;

  ContenidoView({Key key,@required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: user!=null? user.itemKey.entries.map<Widget>((item)=>
      item.key!=null?Column(
        children: [
          ListTile(
            title: Text(
              item.key,
              textAlign: TextAlign.left,
            ),
            subtitle: Text(
              user.itemKey[item.key].toString(),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 10,),
          Divider(thickness: 5,)
        ],
      )
          : ListTile(
        title: Text(
          "Presiona el botón de actualizar ",
          textAlign: TextAlign.left,
        ),
        subtitle: Text(
          "y selecciona alguno de los items del menú...",
          textAlign: TextAlign.left,
        ),
      )


      ).toList():[Text("Presiona el botón actualizar, luego selecciona un usuario del menú")],
    );
  }
}
