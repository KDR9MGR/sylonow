import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? profileImage;
  final bool isDecorator;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.profileImage,
    this.isDecorator = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        profileImage,
        isDecorator,
      ];

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? profileImage,
    bool? isDecorator,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      isDecorator: isDecorator ?? this.isDecorator,
    );
  }
} 