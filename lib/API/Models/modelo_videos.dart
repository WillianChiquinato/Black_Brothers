class VideosClass {
  final int id;
  final String titulo;
  final String URL;
  final String thumbnail;

  VideosClass(
      {required this.id,
        required this.titulo,
        required this.URL,
        required this.thumbnail});

  factory VideosClass.fromJson(Map<String, dynamic> json) {
    return VideosClass(
      id: int.tryParse(json['ID']?.toString() ?? '') ?? -1,
      titulo: json['Titulo'] ?? '',
      URL: json['URL'] ?? '',
      thumbnail: json['ThumbNail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'Titulo': titulo,
      'URL': URL,
      'ThumbNail': thumbnail,
    };

    return data;
  }

  @override
  String toString() {
    return 'VideosClass(titulo: $titulo, url: $URL, thumbnail: $thumbnail)';
  }
}