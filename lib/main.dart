import 'package:dam_u3_practica2_control_tarea/Interfaces/Estilo.dart';
import 'package:dam_u3_practica2_control_tarea/Interfaces/GUIMateria.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ControlTarea(),
    debugShowCheckedModeBanner: false,
  ));
}

class ControlTarea extends StatefulWidget {
  const ControlTarea({super.key});

  @override
  State<ControlTarea> createState() => _ControlTareaState();
}

class _ControlTareaState extends State<ControlTarea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TAREAS",
          style: TextStyle(
            color: Colors.white,
            // Color del texto
            fontSize: 24,
            // Tamaño de la fuente
            fontWeight: FontWeight.bold,
            // Peso de la fuente
            fontStyle: FontStyle.italic,
            // Estilo de la fuente
            letterSpacing: 1.5, // Espaciado entre letras
            // Otros estilos que desees añadir
          ),
        ),
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: Container(
        color: Colors.black, // Establece el color de fondo del cuerpo a negro
        child: Center(),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Estilo.fondoCabeceraDrawer,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Icon(
                        Icons.book,
                        size: 60,
                      ),
                    ),
                    Text(
                      'Menú',
                      style: Estilo.tituloDrawer,
                    ),
                  ]),
            ),`
            ListTile(
              leading: Icon(Icons.add, color: Estilo.colorTextoDrawer),
              title:
                  Text('Agregar Materia', style: Estilo.estiloMateriasDrawer),
              onTap: () {
                Navigator.pop(context);
                GUIMateria.agregarMateria(context);
              },
            ),
            Estilo.lineaDivision
          ],
        ),
      ),
    );
  }
}
