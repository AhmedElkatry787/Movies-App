import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.avatarIndex,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['uid'] as String,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phone: map['phone'] as String?,
      avatarIndex: map['avatarIndex'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
    'uid': id,
    'name': name,
    'email': email,
    'phone': phone,
    'avatarIndex': avatarIndex,
  };
}