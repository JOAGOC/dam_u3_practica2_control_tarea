import 'package:dam_u3_practica2_control_tarea/Interfaces/GUIMateria.dart';
import 'package:dam_u3_practica2_control_tarea/Interfaces/GUITarea.dart';
import 'package:flutter/material.dart';
import 'Interfaces/Estilo.dart';

void main() {
  runApp(MaterialApp(
    home: control_tarea(),
    debugShowCheckedModeBanner: false,
  ));
}

class control_tarea extends StatefulWidget {
  const control_tarea({super.key});

  @override
  State<control_tarea> createState() => _control_tareaState();
}

class _control_tareaState extends State<control_tarea> {
  int _index = 0;

  Widget listaTareas = ListView();

  @override
  void initState() {
    super.initState();
    GUIMateria.suscribir(() => obtenerMaterias());
    GUIMateria.escuchadorTarea = () => setState(() {
          _index = 1;
          consultarTarea();
        });
    obtenerMaterias();
    GUIMateria.context = context;
    GUITarea.context = context;
    GUITarea.escuchador = () => consultarTarea();
    consultarTarea();
  }

  void consultarTarea() async {
    var lista = await GUITarea.listarTareas();
    setState(() {
      listaTareas = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      drawer: Drawer(
        child: Container(
          color: Colors.deepOrange, // Color de fondo del Drawer
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
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
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ]),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text('Home',
                    style: Estilo.estiloMateriasDrawer),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    GUITarea.materiaSeleccionada=null;
                    _index=0;
                  });
                  GUITarea.notify();
                },
              ),
              Estilo.lineaDivision,
              ListTile(
                leading: Icon(Icons.add, color: Colors.white),
                title: Text('Agregar Materia',
                    style: Estilo.estiloMateriasDrawer),
                onTap: () {
                  Navigator.pop(context);
                  GUIMateria.formularioMateria();
                },
              ),
              Estilo.lineaDivision,
              ...listaMaterias
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    switch (_index) {
      case 1:
        return listaTareas;
    }
    return listaTareas;
  }

  AppBar buildAppBar() {
    switch (_index) {
      case 1:
        return GUITarea.appBar();
      default:
        return Estilo.appBarGeneral('Tareas para Hoy');
    }
  }

  static List<Widget> listaMaterias = [];

  ///Lista Dinamica del Drawer
  Future<void> obtenerMaterias() async {
    var x = await GUIMateria.listarMaterias();
    setState(() {
      listaMaterias = Estilo.separar(x);
    });
  }
}
