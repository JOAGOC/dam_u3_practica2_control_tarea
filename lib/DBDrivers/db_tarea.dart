//TODO
import 'package:dam_u3_practica2_control_tarea/DBDrivers/connection.dart';
import 'package:dam_u3_practica2_control_tarea/Models/materia.dart';
import 'package:dam_u3_practica2_control_tarea/Models/tarea.dart';
import 'package:dam_u3_practica2_control_tarea/Models/tareas_materia.dart';
import 'package:sqflite/sqflite.dart';

class DBTarea {
  static Future<int> registrar(Tarea t) async {
    Database db = await ConnectionDB.openDB();
    return db.insert('TAREA', t.toJSON());
  }

  static Future<int> modificar(Tarea t) async {
    print(t);
    Database db = await ConnectionDB.openDB();
    return db.update('TAREA', t.toJSON(),
        where: 'IDTAREA=?', whereArgs: [t.idtarea]);
  }

  static Future<int> eliminar(Tarea t) async {
    Database db = await ConnectionDB.openDB();
    return db.delete('TAREA', where: 'IDTAREA=?', whereArgs: [t.idtarea]);
  }

  static Future<List<Tarea>> consultar() async {
    Database db = await ConnectionDB.openDB();
    var resultado = await db.query('TAREA');
    return List.generate(
        resultado.length,
        (index) => Tarea(
            idtarea: int.parse(resultado[index]['IDTAREA'].toString()),
            idmateria: resultado[index]['IDMATERIA'].toString(),
            f_entrega: resultado[index]['F_ENTREGA'].toString(),
            descripcion: resultado[index]['DESCRIPCION'].toString()));
  }

  static Future<List<TareasMateria>> consultarTareas() async {
    Database db = await ConnectionDB.openDB();
    var resultado = await db.rawQuery("""
    SELECT * FROM MATERIA,TAREA
    WHERE TAREA.F_ENTREGA = '${DateTime.now().toIso8601String().split('T')[0]}'
    AND MATERIA.IDMATERIA = TAREA.IDMATERIA;
      """);
    return List.generate(
        resultado.length,
        (index) => TareasMateria(
            idtarea: int.parse(resultado[index]["IDTAREA"].toString()),
            idmateria: resultado[index]["IDMATERIA"].toString(),
            nombre: resultado[index]["NOMBRE"].toString(),
            semestre: resultado[index]["SEMESTRE"].toString(),
            docente: resultado[index]["DOCENTE"].toString(),
            f_entrega: resultado[index]["F_ENTREGA"].toString(),
            descripcion: resultado[index]["DESCRIPCION"].toString()));
  }
  static Future<List<Tarea>> consultarTareasEspecificas(Materia m) async {
    Database db = await ConnectionDB.openDB();
    var resultado = await db.query("TAREA", where:'IDMATERIA=?',whereArgs: [m.idmateria]);
    print(resultado);
    return List.generate(
        resultado.length,
            (index) => Tarea(
            idtarea: int.parse(resultado[index]["IDTAREA"].toString()),
            idmateria: resultado[index]["IDMATERIA"].toString(),
            f_entrega: resultado[index]["F_ENTREGA"].toString(),
            descripcion: resultado[index]["DESCRIPCION"].toString()));
  }


}