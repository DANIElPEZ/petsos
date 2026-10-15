class Profile {
  final String id;
  final String fullName;
  final String? phone;
  final String role;
  final String? photoUrl;
  final String? professionalCard;
  final String? specialty;

  const Profile({
    required this.id,
    required this.fullName,
    this.phone,
    required this.role,
    this.photoUrl,
    this.professionalCard,
    this.specialty,
  });

  bool get isDoctor => role == 'doctor';

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'] as String,
      fullName: map['full_name'] as String? ?? '',
      phone: map['phone'] as String?,
      role: map['role'] as String? ?? 'user',
      photoUrl: map['photo_url'] as String?,
      professionalCard: map['professional_card'] as String?,
      specialty: map['specialty'] as String?,
    );
  }
}
