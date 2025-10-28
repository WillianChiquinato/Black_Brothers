class ExercicioClass {
  final int id;
  final String nome;
  final String descricao;
  final String videoURL;
  final String thumbnail;
  final bool expandido = false;
  late bool concluido = false;

  ExercicioClass(
      {required this.id,
      required this.nome,
      required this.descricao,
      required this.videoURL,
      required this.thumbnail});

  factory ExercicioClass.fromJson(Map<String, dynamic> json) {
    return ExercicioClass(
      id: int.tryParse(json['ID_Exercicio']?.toString() ?? '') ?? -1,
      nome: json['Nome'] ?? '',
      descricao: json['Descricao'] ?? '',
      videoURL: json['VideoURL'] ?? '',
      thumbnail: json['Thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'Nome': nome,
      'Descricao': descricao,
      'VideoURL': videoURL,
      'Thumbnail': thumbnail
    };

    return data;
  }
}
