import 'package:dam_u3_practica2_control_tarea/DBDrivers/db_materia.dart';
import 'package:dam_u3_practica2_control_tarea/DBDrivers/db_tarea.dart';
import 'package:dam_u3_practica2_control_tarea/Models/materia.dart';
import 'package:flutter/material.dart';
import '../Models/tarea.dart';
import 'Estilo.dart';

class GUITarea {
  static String txtidmateria = "";
  static final txtdescripcion = TextEditingController();
  static DateTime fecha = DateTime.now();
  static var fechaseleccionada = TextEditingController();
  static late BuildContext context;

  static void agregarTarea([Tarea? t]) {
    limpiar() {
      txtdescripcion.clear();
      fechaseleccionada.clear();
      Navigator.pop(context);
    }
    if (t != null) {
      txtidmateria = t.idmateria;
      fechaseleccionada.text = t.f_entrega;
      txtdescripcion.text = t.descripcion;
    }
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
                  child:Text(
                      '${t == null ? "Agregar Nueva" : "Modificar"} Tarea',
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
                        Tarea tarea = Tarea(
                            idmateria: txtidmateria,
                            f_entrega: fechaseleccionada.text,
                            descripcion: txtdescripcion.text
                        );
                        if (t == null) {
                          DBTarea.registrar(tarea);
                        } else {
                          DBTarea.modificar(tarea);
                        }
                        limpiar();
                        mensajeCRUD(
                            'Materia ${t == null ? 'Registrada' : 'Actualizada'}'
                        );

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
  static void mensajeCRUD(String s) {
    showDialog(context: context, builder:(context) => AlertDialog(content: Text(s)),);
  }

  static Future<List<Widget>> listarTareas() async {
    var tareas = await DBTarea.consultar();
    return List.generate(
        tareas.length,
            (index) => ListTile(
                title: Text(
                  tareas[index].idtarea.toString(),
                  style: Estilo.estiloMateriasDrawer,
                ),
                leading: Text(
                  tareas[index].descripcion,
                  style: Estilo.estiloMateriasDrawer,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        agregarTarea(tareas[index]);
                        },
                        icon: Icon(Icons.mode)),
                    IconButton(
                        onPressed: () {
                          eliminarTarea(tareas[index]);
                          },
                        icon: Icon(Icons.delete)),
            ],
          ),
        )
    );
  }

  static void eliminarTarea(Tarea t) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Tarea?'),
        content: Text('La tarea va a ser eliminada'),
        actions: [
          TextButton(
              onPressed: () {
                DBTarea.eliminar(t);
                Navigator.pop(context);
                mensajeCRUD('La Tarea ha sido eliminada');
              },
              child: Text('Si')),
          TextButton(onPressed: () => Navigator.pop(context), child: Text('No'))
        ],
      ),
    );
  }

}