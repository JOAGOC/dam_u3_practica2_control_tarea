import 'package:flutter/material.dart';

class Estilo {
  static final fondoDialogo = Colors.blueGrey.shade800;
  static final paddingDialogo = EdgeInsets.all(20);
  static final tituloDialogo = TextStyle(color: Colors.white, fontSize: 18);
  static final espacioEntreCampos = SizedBox(height: 10);
  static final lineaDivision = Divider(color: Colors.white);
  static var estiloMateriasDrawer = TextStyle(color: colorTextoDrawer, fontSize: 18);

  //
  static final tituloDrawer = TextStyle(color: Colors.white, fontSize: 24,);
  static final fondoCabeceraDrawer = Colors.deepOrange;

  static var colorTextoDrawer = Colors.white;

  static var labelstyleField = TextStyle(color: Colors.white,fontSize: 12);
  static var labelstyleorange = TextStyle(color: Colors.white);


  static final estiloCancelarFormulario = estiloFormulario(Colors.red);
  static final estiloAceptarFormulario = estiloFormulario(Colors.green);

  static const Color colorIconosListTile = Colors.white54;
  static ButtonStyle estiloFormulario(Color background) {
    return ElevatedButton.styleFrom(
      backgroundColor: background,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  static const estiloTextoBoton = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static AppBar appBarGeneral(String titulo, [List<IconButton> acciones = const []]) {
    return AppBar(
      title: Text(
        titulo,
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
      actions: acciones,
    );
  }

  static List<Widget> separar(List<Widget> lista) {
    List<Widget> widgets = [];
    for (var element in lista) {
      widgets.add(element);
      widgets.add(Estilo.lineaDivision);
    }
    return widgets;
  }
}
