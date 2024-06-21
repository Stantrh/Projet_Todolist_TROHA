class Tag {
  String id;
  String name;

  Tag({
    required this.name,
    required this.id
  });

  @override
  String toString() {
    return 'Tag(id: $id, name: $name)';
  }

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

}
