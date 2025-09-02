class GeneralInformation {
  final int id;
  final String title;
  final String content;

  GeneralInformation({
    required this.id,
    required this.title,
    required this.content,
  });

  factory GeneralInformation.fromJson(Map<String, dynamic> json) {
    return GeneralInformation(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }

  static List<GeneralInformation> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((e) => GeneralInformation.fromJson(e)).toList();
  }
}
