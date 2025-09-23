class FeedbackClass {
  final int id;
  final String mensagem;
  final int FK_TipoFeedback_ID;

  FeedbackClass(
      {required this.id,
        required this.mensagem,
        required this.FK_TipoFeedback_ID});

  factory FeedbackClass.fromJson(Map<String, dynamic> json) {
    return FeedbackClass(
      id: int.tryParse(json['ID_Feedbacks']?.toString() ?? '') ?? -1,
      mensagem: json['Mensagem'] ?? '',
      FK_TipoFeedback_ID: int.tryParse(json['FK_TipoFeedbacks_ID']?.toString() ?? '') ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'Mensagem': mensagem,
      'FK_TipoFeedbacks_ID': FK_TipoFeedback_ID,
    };

    return data;
  }
}