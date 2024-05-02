class Materia {
  String idmateria;
  String nombre;
  String semestre;
  String docente;

  Materia({
    required this.idmateria,
    required this.nombre,
    required this.semestre,
    required this.docente,
  });

  Map<String,dynamic> toJSON(){
    return {
      'IDMATERIA':idmateria,
      'NOMBRE':nombre,
      'SEMESTRE':semestre,
      'DOCENTE':docente,
    };
  }
}