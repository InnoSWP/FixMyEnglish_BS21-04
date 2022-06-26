class Mistake {
  final String match;
  final String sentence;
  final String label;
  final String description;

  Mistake({
    required this.match,
    required this.sentence,
    required this.label,
    required this.description,
  });

  factory Mistake.fromJson(Map<String, dynamic> json) => Mistake(
        match: json['match'],
        sentence: json['sentence'],
        label: json['label'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'match': match,
        'sentence': sentence,
        'label': label,
        'description': description,
      };

  @override
  String toString() => sentence;
}
