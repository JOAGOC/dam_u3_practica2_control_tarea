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
  static var labelstyleorange = TextStyle(color: Colors.deepOrange);


  static final estiloCancelarFormulario = estiloFormulario(Colors.red);
  static final estiloAceptarFormulario = estiloFormulario(Colors.green);
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
}
