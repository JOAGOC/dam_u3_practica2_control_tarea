import 'package:dam_u3_practica2_control_tarea/DBDrivers/connection.dart';
import 'package:dam_u3_practica2_control_tarea/Models/materia.dart';
import 'package:sqflite/sqflite.dart';

class DBMateria {
  static Future<int> registrar(Materia m) async {
    Database db = await ConnectionDB.openDB();
    return db.insert('MATERIA', m.toJSON());
  }

  static Future<int> modificar(Materia m) async {
    Database db = await ConnectionDB.openDB();
    return db.update('MATERIA', m.toJSON(),where:'IDMATERIA=?',whereArgs: [m.idmateria]);
  }

  static Future<int> eliminar(Materia m) async {
    Database db = await ConnectionDB.openDB();
    return db.delete('MATERIA',where: 'IDMATERIA=?',whereArgs: [m.idmateria]);
  }

  static Future<List<Materia>> consultar() async {
    Database db = await ConnectionDB.openDB();
    var resultado = await db.query('MATERIA');
    return List.generate(
        resultado.length,
        (index) => Materia(
            idmateria: resultado[index]['IDMATERIA'].toString(),
            nombre: resultado[index]['NOMBRE'].toString(),
            semestre: resultado[index]['SEMESTRE'].toString(),
            docente: resultado[index]['DOCENTE'].toString()));
  }
}
