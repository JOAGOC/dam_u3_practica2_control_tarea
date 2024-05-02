import 'package:dam_u3_practica2_control_tarea/DBDrivers/db_materia.dart';
import 'package:dam_u3_practica2_control_tarea/Models/materia.dart';
import 'package:flutter/material.dart';
import 'Estilo.dart';

class GUIMateria {
  static final List<String> semestre = [
    "AGO-DIC2023",
    "ENE-JUN2023",
    "ENE-JUN2024",
    "AGO-DIC2024",
    "ENE-JUN2022",
    "AGO-DIC20242"
  ];
  static var txtsemestre = semestre.first;
  static final txtidmateria = TextEditingController();
  static final txtnombre = TextEditingController();
  static final txtdocente = TextEditingController();
  static List<void Function()> suscriptores = [];
  static late BuildContext context;

  static void suscribir(void Function() x) {
    suscriptores.add(x);
  }

  static void formularioMateria([Materia? m]) {
    limpiar() {
      txtidmateria.clear();
      txtdocente.clear();
      txtnombre.clear();
      txtsemestre = semestre.first;
      Navigator.pop(context);
    }

    if (m != null) {
      txtidmateria.text = m.idmateria;
      txtdocente.text = m.docente;
      txtnombre.text = m.nombre;
      txtsemestre = m.semestre;
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
                    '${m == null ? "Agregar Nueva" : "Modificar"} Materia',
                    style: Estilo.tituloDialogo),
              ),
              Estilo.espacioEntreCampos,
              TextField(
                readOnly: m != null,
                controller: txtidmateria,
                decoration: InputDecoration(
                  labelText: "ID Materia",
                  labelStyle: Estilo.labelstyleField,
                  suffixIcon: Icon(Icons.book),
                ),
                style: Estilo.labelstyleorange,
              ),
              Estilo.espacioEntreCampos,
              TextField(
                controller: txtnombre,
                decoration: InputDecoration(
                  labelText: "Nombre",
                  labelStyle: Estilo.labelstyleField,
                  suffixIcon: Icon(Icons.school_sharp),
                ),
                style: Estilo.labelstyleorange,
              ),
              Estilo.espacioEntreCampos,
              TextField(
                controller: txtdocente,
                decoration: InputDecoration(
                  labelText: "Docente",
                  labelStyle: Estilo.labelstyleField,
                  suffixIcon: Icon(Icons.person_pin_rounded),
                ),
                style: Estilo.labelstyleorange,
              ),
              Estilo.espacioEntreCampos,
              Text(
                "Semestre",
                style: Estilo.labelstyleField,
              ),
              DropdownButtonFormField(
                  style: Estilo.labelstyleField,
                  dropdownColor: Colors.black,
                  icon: const Icon(Icons.access_time),
                  value: txtsemestre,
                  items: semestre.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  onChanged: (value) => txtsemestre = value!),
              Estilo.espacioEntreCampos,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: Estilo.estiloAceptarFormulario,
                    onPressed: () {
                      Materia nm = Materia(
                          idmateria: txtidmateria.text,
                          nombre: txtnombre.text,
                          semestre: txtsemestre,
                          docente: txtdocente.text);
                      if (m == null) {
                        DBMateria.registrar(nm);
                      } else {
                        DBMateria.modificar(nm);
                      }
                      limpiar();
                      mensajeCRUD(
                          'Materia ${m == null ? 'Registrada' : 'Actualizada'}');
                      notify();
                    },
                    child: Text('Agregar', style: Estilo.estiloTextoBoton),
                  ),
                  ElevatedButton(
                    style: Estilo.estiloCancelarFormulario,
                    onPressed: () {
                      limpiar();
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

  static Future<List<Widget>> listarMaterias() async {
    var materias = await DBMateria.consultar();
    return List.generate(
        materias.length,
        (index) => ListTile(
              title: Text(
                materias[index].nombre,
                style: Estilo.estiloMateriasDrawer,
              ),
              leading: Text(
                materias[index].idmateria,
                style: Estilo.estiloMateriasDrawer,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        formularioMateria(materias[index]);
                      },
                      icon: Icon(Icons.mode)),
                  IconButton(
                      onPressed: () {
                        eliminarMateria(materias[index]);
                      },
                      icon: Icon(Icons.delete)),
                ],
              ),
            ));
  }

  static void notify() {
    for (var element in suscriptores) {
      element();
    }
  }

  static void mensajeCRUD(String s) {
    showDialog(context: context, builder:(context) => AlertDialog(content: Text(s)),);
  }

  static void eliminarMateria(Materia m) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Materia?'),
        content: Text('La materia va a ser eliminada'),
        actions: [
          TextButton(
              onPressed: () {
                DBMateria.eliminar(m);
                Navigator.pop(context);
                mensajeCRUD('La materia ha sido eliminada');
                notify();
              },
              child: Text('Si')),
          TextButton(onPressed: () => Navigator.pop(context), child: Text('No'))
        ],
      ),
    );
  }
}