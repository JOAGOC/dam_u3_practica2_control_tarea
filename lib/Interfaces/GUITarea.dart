import 'package:dam_u3_practica2_control_tarea/DBDrivers/db_materia.dart';
import 'package:dam_u3_practica2_control_tarea/DBDrivers/db_tarea.dart';
import 'package:dam_u3_practica2_control_tarea/Models/materia.dart';
import 'package:flutter/material.dart';
import '../Models/tarea.dart';
import 'Estilo.dart';

class GUITarea {
  static final String txtidmateria = "";
  static final f_entrega = TextEditingController();
  static final txtdescripcion = TextEditingController();
  static DateTime fecha = DateTime.now();
  static var fechaseleccionada = TextEditingController();

  static void agregarTarea(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Estilo.fondoDialogo,
          child: Container(
            height: 450,
            child: ListView(
              padding: Estilo.paddingDialogo,
              children: [
                Center(
                  child: Text('Agregar Nueva Tarea',
                      style: Estilo.tituloDialogo),
                ),
                Estilo.espacioEntreCampos,
                Text("Materia", style: Estilo.labelstyleField,),
                Estilo.espacioEntreCampos,
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101));
                    if (picked != null && picked != fecha) {
                      fecha = picked;
                    }
                    // ignore: unnecessary_null_comparison
                    fechaseleccionada.text = fecha == null
                        ? 'No se ha seccionado fecha'
                        : fecha.toLocal().toIso8601String().split('T')[0];
                  },
                  child: const Text('Seleccionar fecha'),
                ),
                Estilo.espacioEntreCampos,
                TextField(
                  controller: txtdescripcion,
                  decoration: InputDecoration(
                    labelText: "Descripcion",
                    labelStyle: Estilo.labelstyleField,
                    suffixIcon: Icon(Icons.notes_rounded),
                  ),
                  style: Estilo.labelstyleorange,
                ),
                Estilo.espacioEntreCampos,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: Estilo.estiloAceptarFormulario,
                      onPressed: () {
                        Tarea t = Tarea(
                            idmateria: ,
                            f_entrega: f_entrega.text,
                            descripcion: txtdescripcion.text
                        );
                        DBTarea.registrar(t);
                        Navigator.pop(context);
                        txtdescripcion.clear();

                      },
                      child: Text('Agregar',style:Estilo.estiloTextoBoton),
                    ),
                    ElevatedButton(
                      style: Estilo.estiloCancelarFormulario,
                      onPressed: () {
                        Navigator.pop(context);
                        txtdescripcion.clear();
                      },
                      child: Text('Cancelar',style: Estilo.estiloTextoBoton),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}