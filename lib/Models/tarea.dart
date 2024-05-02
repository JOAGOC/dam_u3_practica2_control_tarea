class Tarea {
  int? idtarea;
  String idmateria;
  String f_entrega;
  String descripcion;

  Tarea({
    this.idtarea,
    required this.idmateria,
    required this.f_entrega,
    required this.descripcion,
  });

  Map<String, dynamic> toJSON() {
    Map<String,dynamic> json = {
      'IDTAREA': idtarea,
      'IDMATERIA': idmateria,
      'F_ENTREGA': f_entrega,
      'DESCRIPCION': descripcion,
    };
    if (idtarea!=null) {
      json['IDTAREA'] = idtarea;
    }
    return json;
  }
}