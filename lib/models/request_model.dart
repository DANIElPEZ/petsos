import 'dog.dart';

class PetRequest {
  final String id;
  final String userId;
  final String dogId;
  final String type;
  final String? description;
  final List<String> images;
  final String? location;
  final double? latitude;
  final double? longitude;
  final double reward;
  final String status;
  final String? doctorId;
  final String? finderId;
  final DateTime createdAt;
  final Dog? dog;

  const PetRequest({
    required this.id,
    required this.userId,
    required this.dogId,
    required this.type,
    this.description,
    this.images = const [],
    this.location,
    this.latitude,
    this.longitude,
    this.reward = 0,
    required this.status,
    this.doctorId,
    this.finderId,
    required this.createdAt,
    this.dog,
  });

  factory PetRequest.fromMap(Map<String, dynamic> map) {
    Dog? dog;
    final rawDog = map['dogs'];
    if (rawDog is Map<String, dynamic>) dog = Dog.fromMap(rawDog);

    return PetRequest(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      dogId: map['dog_id'] as String,
      type: map['type'] as String,
      description: map['description'] as String?,
      images: List<String>.from(map['images'] ?? const []),
      location: map['location'] as String?,
      latitude: (map['latitude'] as num?)?.toDouble(),
      longitude: (map['longitude'] as num?)?.toDouble(),
      reward: (map['reward'] as num?)?.toDouble() ?? 0,
      status: map['status'] as String? ?? 'active',
      doctorId: map['doctor_id'] as String?,
      finderId: map['finder_id'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      dog: dog,
    );
  }

  bool get isLost => type == 'lost';
  bool get isMedical => type == 'medical';
}
