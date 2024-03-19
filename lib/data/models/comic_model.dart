class Comic {
  final String title;
  final String url;
  final List<Map<String, String>> urls;


  Comic({
    required this.title,
    required this.url,
     required this.urls,
  });
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      
    };
  }
  factory Comic.fromJson(Map<String, dynamic> json) {

    return Comic(
      title: json['title'],
      url: json['url'],
        urls: List<Map<String, String>>.from(json['urls'] ?? []),
    );
  }

}
