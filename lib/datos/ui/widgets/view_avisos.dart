
import 'package:flutter/material.dart';

class Avisos{
  String textoAviso;
  BuildContext contextAviso;

  Avisos({Key key,this.textoAviso, @required this.contextAviso});



  void mostrarMensaje(){
    ScaffoldMessenger.of(contextAviso).showSnackBar(SnackBar(
      content: Text(textoAviso),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    ));
  }

}