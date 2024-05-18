class DocumentData {
  final String title;
  final String? content;
  final bool state;
  final String dataS;
  final String? dataF;

  DocumentData({
    required this.title,
    this.content,
    required this.state,
    required this.dataS,
    this.dataF,
  });

  factory DocumentData.fromMap(Map<String, dynamic> map) {
    return DocumentData(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      state: map['state'] ?? false,
      dataS: map['dataS'] ?? '',
      dataF: map['dataF'] ?? '',
    );
  }
}