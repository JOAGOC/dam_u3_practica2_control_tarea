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

  static void agregarMateria(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Estilo.fondoDialogo,
          child: Container(
            padding: Estilo.paddingDialogo,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text('Agregar Nueva Materia',
                      style: Estilo.tituloDialogo),
                ),
                Estilo.espacioEntreCampos,
                TextField(
                  controller: txtidmateria,
                  decoration: InputDecoration(
                    labelText: "ID Materia",
                    suffixIcon: Icon(Icons.book),
                  ),
                ),
                Estilo.espacioEntreCampos,
                TextField(
                  controller: txtnombre,
                  decoration: InputDecoration(
                    labelText: "Nombre",
                    suffixIcon: Icon(Icons.school_sharp),
                  ),
                ),
                Estilo.espacioEntreCampos,
                TextField(
                  controller: txtdocente,
                  decoration: InputDecoration(
                    labelText: "Docente",
                    suffixIcon: Icon(Icons.person_pin_rounded),
                  ),
                ),
                Estilo.espacioEntreCampos,
                DropdownButtonFormField(
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
                      onPressed: () {
                        Materia m = Materia(
                            idmateria: txtidmateria.text,
                            nombre: txtnombre.text,
                            semestre: txtsemestre,
                            docente: txtdocente.text
                        );
                        DBMateria.registrar(m);
                      },
                      child: Text('Agregar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancelar'),
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