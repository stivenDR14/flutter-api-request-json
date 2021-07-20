

import 'dart:async';

import 'package:flutter_prueba_api_json/User/repository/json_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class DatosBloc implements Bloc{

  final _json_repository = JsonRepository();

  //stream - cargando
  final controllerTrigguerCarga=StreamController.broadcast();
  Stream cargaTriggerStream() => controllerTrigguerCarga.stream;


  //Casos de uso

  //TRANSFERENCIA DE DATOS
  //1. Obtener datos de endpoint
  Future getDataEnd()=> _json_repository.getDataJson();

//UTILIDADES
  //1. estado de carga
  void setTriggerCarga(estado){
    controllerTrigguerCarga.sink.add(estado);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controllerTrigguerCarga.close();
  }

}