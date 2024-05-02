import 'package:flutter/material.dart';

class Estilo {
  static final fondoDialogo = Colors.blueGrey.shade800;
  static final paddingDialogo = EdgeInsets.all(20);
  static final tituloDialogo = TextStyle(color: Colors.white, fontSize: 18);
  static final espacioEntreCampos = SizedBox(height: 20);
  static final lineaDivision = Divider(
    color: Colors.white,
  );
  static var estiloMateriasDrawer =
      TextStyle(color: colorTextoDrawer, fontSize: 18);

  //
  static final tituloDrawer = TextStyle(
    color: Colors.white,
    fontSize: 24,
  );
  static final fondoCabeceraDrawer = Colors.deepOrange;

  static var colorTextoDrawer = Colors.white;
}
