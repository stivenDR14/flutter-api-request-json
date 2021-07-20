import 'package:flutter/material.dart';
import 'package:flutter_prueba_api_json/datos/bloc/bloc_datos.dart';
import 'package:flutter_prueba_api_json/datos/ui/widgets/view_avisos.dart';
import 'package:flutter_prueba_api_json/datos/ui/widgets/view_carga.dart';
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
  Map<String,dynamic> detalles={};

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
        body: ListView(
          children: detalles.entries.map<Widget>((item)=>
          item.key!=null?
          (item.key=="name" || item.key=="email" || item.key=="city" || item.key=="company")? Column(
                children: [
                  ListTile(
                    title: Text(
                      item.key=="name"?
                        "Nombre" :
                        item.key=="email"? "Correo":
                            item.key=="city"? "Ciudad":
                              item.key=="company"? "Nombre de compañia": "",
                      textAlign: TextAlign.left,
                    ),
                    subtitle: Text(
                      item.key=="company"?detalles[item.key]["name"].toString():detalles[item.key].toString(),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(thickness: 5,)
                ],
              ): Text("")
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


          ).toList(),
        ),
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
              Column(
                children:
                  datos.map<Widget>((item) =>
                    ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text(item["name"]),
                      onTap: () {
                        setState(() {
                          detalles=item;
                        });
                        // change app state...
                        Navigator.pop(context); // close the drawer
                        },
                    ),
                  ).toList()
              ),
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
