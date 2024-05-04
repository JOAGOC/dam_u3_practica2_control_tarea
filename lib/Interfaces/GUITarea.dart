import 'package:dam_u3_practica2_control_tarea/DBDrivers/db_tarea.dart';
import 'package:dam_u3_practica2_control_tarea/Models/materia.dart';
import 'package:dam_u3_practica2_control_tarea/Models/tareas_materia.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Models/tarea.dart';
import 'Estilo.dart';

class GUITarea {
  static String txtidmateria = "";
  static final txtdescripcion = TextEditingController();
  static DateTime fecha = DateTime.now();
  static String fechaseleccionada = 'No se ha seccionado fecha';
  static late BuildContext context;
  static void Function() escuchador = () {};

  static void formularioTarea([Tarea? t]) {
    limpiar() {
      txtdescripcion.clear();
      fechaseleccionada = '';
      Navigator.pop(context);
    }

    if (t != null) {
      txtidmateria = t.idmateria;
      fechaseleccionada = t.f_entrega;
      txtdescripcion.text = t.descripcion;
    }
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Estilo.fondoDialogo,
          child: ListView(
            shrinkWrap: true,
            padding: Estilo.paddingDialogo,
            children: [
              Center(
                child: Text(
                    '${t == null ? "Agregar Nueva" : "Modificar"} Tarea',
                    style: Estilo.tituloDialogo),
              ),
              Estilo.espacioEntreCampos,
              Text(
                "Fecha: ${fechaseleccionada}",
                style: Estilo.labelstyleField,
              ),
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
                  fechaseleccionada = fecha == null
                      ? 'No se ha seccionado fecha'
                      : fecha.toLocal().toIso8601String().split('T')[0];
                  (context as Element).markNeedsBuild();
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
                          idtarea: t?.idtarea,
                          idmateria: GUITarea.materiaSeleccionada!.idmateria,
                          f_entrega: fechaseleccionada,
                          descripcion: txtdescripcion.text);
                      if (t == null) {
                        DBTarea.registrar(tarea);
                      } else {
                        DBTarea.modificar(tarea);
                      }
                      limpiar();
                      mensajeCRUD(
                          'Tarea ${t == null ? 'Registrada' : 'Actualizada'}');
                      escuchador();
                    },
                    child: Text('Agregar', style: Estilo.estiloTextoBoton),
                  ),
                  ElevatedButton(
                    style: Estilo.estiloCancelarFormulario,
                    onPressed: () {
                      Navigator.pop(context);
                      txtdescripcion.clear();
                    },
                    child: Text('Cancelar', style: Estilo.estiloTextoBoton),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Materia? materiaSeleccionada;

  static AppBar appBar() {
    return Estilo.appBarGeneral(materiaSeleccionada!.nombre, [
      IconButton(
          onPressed: () {
            GUITarea.formularioTarea();
          },
          icon: Icon(
            Icons.add,
            size: 30,
          ))
    ]);
  }

  static void mensajeCRUD(String s) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(content: Text(s)),
    );
  }

  static Future<Widget> listarTareas() async {
    if (materiaSeleccionada == null) {
      var tareas = await DBTarea.consultarTareas();
      if (tareas.isEmpty) {
        return sinTareasParaHoy();
      } else {
        return tareasParaHoy(tareas);
      }
    } else {
      var tareas =
          await DBTarea.consultarTareasEspecificas(materiaSeleccionada!);
      if (tareas.isEmpty) {
        return sinTareas();
      } else {
        return tareasParaMateria(tareas);
      }
    }
  }

  static Container tareasParaMateria(List<Tarea> tareas) {
    return Container(
        color: Colors.black,
        child: ListView(
          children: [
            ...Estilo.separar(List.generate(
              tareas.length,
              (index) => ListTile(
                title: Text(
                  tareas[index].descripcion,
                  style: Estilo.estiloMateriasDrawer,
                ),
                subtitle: Text('Fecha de entrega: ${tareas[index].f_entrega}',
                    style: Estilo.labelstyleField),
                leading: Text(
                  tareas[index].idtarea.toString(),
                  style: Estilo.estiloMateriasDrawer,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          formularioTarea(tareas[index]);
                          notify();
                        },
                        icon: Icon(
                          Icons.mode,
                          color: Estilo.colorIconosListTile,
                        )),
                    IconButton(
                        onPressed: () {
                          eliminarTarea(tareas[index]);
                          notify();
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Estilo.colorIconosListTile,
                        )),
                  ],
                ),
              ),
            ))
          ],
        ));
  }

  static Container sinTareas() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          'No hay tareas para esta materia',
          style: Estilo.estiloMateriasDrawer,
        ),
      ),
    );
  }

  static Container tareasParaHoy(List<TareasMateria> tareas) {
    return Container(
      color: Colors.black,
      child: ListView(
        padding: EdgeInsets.only(top: 8),
        children: [
          ...listaTareasParaHoy(tareas),
        ],
      ),
    );
  }

  static listaTareasParaHoy(List<TareasMateria> tareas) {
    var lista = List.generate(
      tareas.length,
      (index) => Dismissible(
        key: Key(tareas[index].idtarea.toString()),
        onDismissed: (direction) {
          DBTarea.eliminar(Tarea(
              idtarea: tareas[index].idtarea,
              idmateria: tareas[index].idmateria,
              f_entrega: tareas[index].f_entrega,
              descripcion: tareas[index].descripcion));
          notify();
          mensajeCRUD('Tarea Realizada!!');
        },
        child: ListTile(
          title: Text(
            tareas[index].descripcion,
            style: Estilo.estiloMateriasDrawer,
          ),
          subtitle: Text(
              '${tareas[index].nombre}\nFecha de entrega: ${tareas[index].f_entrega}',
              style: Estilo.labelstyleField),
          leading: Text(
            tareas[index].idtarea.toString(),
            style: Estilo.estiloMateriasDrawer,
          ),
        ),
      ),
    );
    return Estilo.separar(lista);
  }

  static Container sinTareasParaHoy() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          'No hay tareas para hoy',
          style: Estilo.estiloMateriasDrawer,
        ),
      ),
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
                notify();
              },
              child: Text('Si')),
          TextButton(onPressed: () => Navigator.pop(context), child: Text('No'))
        ],
      ),
    );
  }

  static void notify() {
    escuchador();
  }
}
