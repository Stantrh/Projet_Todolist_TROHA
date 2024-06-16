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

}
