import 'package:dam_u3_practica2_control_tarea/Interfaces/GUIMateria.dart';
import 'package:flutter/material.dart';
List<String> semestre = ["AGO-DIC2023","ENE-JUN2023","ENE-JUN2024","AGO-DIC2024","ENE-JUN2022","AGO-DIC20242"];
void main() {
  runApp(MaterialApp(home: control_tarea(),debugShowCheckedModeBanner: false,));
}

class control_tarea extends StatefulWidget {
  const control_tarea({super.key});

  @override
  State<control_tarea> createState() => _control_tareaState();
}

class _control_tareaState extends State<control_tarea> {

  @override
  void initState() {
    super.initState();
    GUIMateria.suscribir(()=>obtenerMaterias());
    obtenerMaterias();
    GUIMateria.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TAREAS",
          style: TextStyle(
            color: Colors.white, // Color del texto
            fontSize: 24, // Tamaño de la fuente
            fontWeight: FontWeight.bold, // Peso de la fuente
            fontStyle: FontStyle.italic, // Estilo de la fuente
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
        child: Center(

        ),
      ),
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
                    children:[
                    CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.book,size: 60,),
                    ),
                    Text('Menú', style: TextStyle(color: Colors.white, fontSize: 24,),),
                  ]
                ),
              ),
              ListTile(
                leading: Icon(Icons.add, color: Colors.white),
                title: Text('Agregar Materia', style: TextStyle(color: Colors.white,fontSize: 18)),
                onTap: () {
                  Navigator.pop(context);
                  GUIMateria.formularioMateria();
                },
              ),
              Divider(color: Colors.white,),
              ...listaMaterias
            ],
          ),
        ),
      ),
    );
  }

  static List<Widget> listaMaterias = <Widget>[];

  Future<void> obtenerMaterias() async {
    var x = await GUIMateria.listarMaterias();
    List<Widget> widgets = [];
    for (var element in x) {
      widgets.add(element);
      widgets.add(Divider(color: Colors.white,));
    }
    setState(() {
      listaMaterias = widgets;
    });
  }
}
