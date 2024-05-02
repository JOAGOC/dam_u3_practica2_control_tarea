import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ConnectionDB {
  static Future<Database> openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'tareas.db'),
      version: 1,
      onCreate: (db, version) => createDB(db),
    );
  }

  static createDB(Database db) async {
    await db.execute(
        """
CREATE TABLE IF NOT EXISTS MATERIA(
IDMATERIA TEXT PRIMARY KEY,
NOMBRE TEXT,
SEMESTRE TEXT,
DOCENTE TEXT
);
""");
    await db.execute(
        """
CREATE TABLE IF NOT EXISTS TAREA(
IDTAREA INTEGER PRIMARY KEY AUTOINCREMENT,
IDMATERIA TEXT,
F_ENTREGA TEXT,
DESCRIPCION TEXT,
FOREIGN KEY (IDMATERIA) REFERENCES MATERIA(IDMATERIA)
);
""");
  }
}