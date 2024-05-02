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
            height: 450,
            child: ListView(
              padding: Estilo.paddingDialogo,
              children: [
                Center(
                  child: Text('Agregar Nueva Materia',
                      style: Estilo.tituloDialogo),
                ),
                Estilo.espacioEntreCampos,
                TextField(
                  controller: txtidmateria,
                  decoration: InputDecoration(
                    labelText: "ID Materia" ,
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
                Text("Semestre", style: Estilo.labelstyleField,),
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
                        Materia m = Materia(
                            idmateria: txtidmateria.text,
                            nombre: txtnombre.text,
                            semestre: txtsemestre,
                            docente: txtdocente.text
                        );
                        DBMateria.registrar(m);
                        Navigator.pop(context);
                        txtidmateria.clear();
                        txtdocente.clear();
                        txtnombre.clear();
                      },
                      child: Text('Agregar',style:Estilo.estiloTextoBoton),
                    ),
                    ElevatedButton(
                      style: Estilo.estiloCancelarFormulario,
                      onPressed: () {
                        Navigator.pop(context);
                        txtidmateria.clear();
                        txtdocente.clear();
                        txtnombre.clear();
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