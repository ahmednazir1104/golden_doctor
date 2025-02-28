class StaticPagesModel {
  final int id;
  final String title;
  final String content;

  StaticPagesModel({required this.id, required this.title, required this.content});

  factory StaticPagesModel.fromMap(Map<String, dynamic> map) {
    return StaticPagesModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
    );
  }
}

class PagesData {
  final List<StaticPagesModel> pages;

  PagesData({required this.pages});

  factory PagesData.fromMap(Map<String, dynamic> map) {
    return PagesData(
      pages: (map['pages'] as List<dynamic>)
          .map((e) => StaticPagesModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
