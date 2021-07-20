import 'package:flutter/material.dart';
import 'package:flutter_prueba_api_json/User/bloc/bloc_datos.dart';
import 'package:flutter_prueba_api_json/User/model/usuario.dart';
import 'package:flutter_prueba_api_json/User/ui/widgets/view_avisos.dart';
import 'package:flutter_prueba_api_json/User/ui/widgets/view_carga.dart';
import 'package:flutter_prueba_api_json/User/ui/widgets/view_contenido.dart';
import 'package:flutter_prueba_api_json/User/ui/widgets/view_lista_opciones.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
class GeneralScreen extends StatefulWidget {
  GeneralScreen({Key key, @required this.title});


  final String title;

  @override
  _GeneralScreenState createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {

  DatosBloc datosBloc;
  List datos=[];
  Usuario detallesUser;

  void _realizarGet(BuildContext contexto) {
    datosBloc.setTriggerCarga(true);
    datosBloc.getDataEnd().then((value) {
      setState(() {
        datos=value.data;
      });
      print("datos: $datos");
      Avisos(contextAviso: contexto, textoAviso: "Actualizado.").mostrarMensaje();
    }).onError((error, stackTrace) {
      Avisos(contextAviso: contexto, textoAviso: "Error: $error").mostrarMensaje();
    }).whenComplete(() => datosBloc.setTriggerCarga(false));
  }

  void _opcionListaPressed(item){
    print("item presionado");
    setState(() {
      detallesUser=Usuario(user: item);
    });
    // change app state...
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    datosBloc=BlocProvider.of(context);
    return Scaffold(
        appBar:
        AppBar(
          flexibleSpace: CargaView(),
          title: Column(
            children: [
              Text(widget.title),
            ],
          ),
        ),
        body: ContenidoView(user: detallesUser,),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                ),
                child: Text(
                  'Datos disponibles:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListaOpcionesView(datos: datos, onPressed: _opcionListaPressed,)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>_realizarGet(context),
          tooltip: 'Recargar',
          child: Icon(Icons.refresh),
        ),
    );
  }
}
