class TipoFeedbackClass {
  final int id;
  final String topico;

  TipoFeedbackClass(
      {required this.id,
        required this.topico});

  factory TipoFeedbackClass.fromJson(Map<String, dynamic> json) {
    return TipoFeedbackClass(
      id: int.tryParse(json['ID_TipoFeedbacks']?.toString() ?? '') ?? -1,
      topico: json['Topico'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'Topico': topico,
    };

    return data;
  }
}