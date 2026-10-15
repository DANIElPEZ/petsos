class Dog {
  final String id;
  final String ownerId;
  final String name;
  final String? breed;
  final String? sex;
  final int? age;
  final String? color;
  final String? description;
  final List<String> images;

  const Dog({
    required this.id,
    required this.ownerId,
    required this.name,
    this.breed,
    this.sex,
    this.age,
    this.color,
    this.description,
    this.images = const [],
  });

  String get mainImage => images.isEmpty ? '' : images.first;

  factory Dog.fromMap(Map<String, dynamic> map) {
    return Dog(
      id: map['id'] as String,
      ownerId: map['owner_id'] as String,
      name: map['name'] as String? ?? '',
      breed: map['breed'] as String?,
      sex: map['sex'] as String?,
      age: map['age'] as int?,
      color: map['color'] as String?,
      description: map['description'] as String?,
      images: List<String>.from(map['images'] ?? const []),
    );
  }
}
