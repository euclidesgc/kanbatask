import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final bool emailVerified;

  const UserEntity({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    required this.emailVerified,
  });

  @override
  List<Object?> get props => [
    uid,
    email,
    displayName,
    photoURL,
    emailVerified,
  ];
}
