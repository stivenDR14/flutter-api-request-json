
import 'package:flutter/material.dart';
import 'package:flutter_prueba_api_json/datos/bloc/bloc_datos.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class CargaView extends StatelessWidget {

  DatosBloc datosBloc;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    datosBloc=BlocProvider.of(context);
    return handleCarga(context);
  }

  Widget handleCarga(BuildContext context){
    return StreamBuilder(
        stream: datosBloc.cargaTriggerStream(),
        builder: (_contextActual, AsyncSnapshot snapshot){
          bool retorno=false;
          if(!snapshot.hasData){
            retorno=false;
          }else{
            retorno=snapshot.data;
          }
          return barraSuperior(retorno);

        }
    );

  }

  Widget barraSuperior(bool cargando){
    return Visibility(
      visible: cargando,
      child: LinearProgressIndicator(
        color: Colors.lightGreenAccent,
        minHeight: 20,
      ),
    );
  }

}
