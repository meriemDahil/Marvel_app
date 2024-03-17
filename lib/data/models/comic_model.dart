class Comic {
  final String title;
  final String url;


  Comic({
    required this.title,
    required this.url,
  });
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
    };
  }
  factory Comic.fromJson(Map<String, dynamic> json) {
    // Deserialize a Character object from a JSON map
    return Comic(
      title: json['title'],
      url: json['url'],
    );
  }
}
