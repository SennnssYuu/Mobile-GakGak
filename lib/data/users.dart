import 'user_setting.dart';

class AppUser {
  final String name;
  final String email;
  final String gender;
  final String phone;
  final String birthday;
  final String profile;
  final UserSettings settings;

  AppUser({
    required this.name,
    required this.email,
    required this.gender,
    required this.phone,
    required this.birthday,
    required this.profile,
    required this.settings,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      phone: map['phone'] ?? '',
      birthday: map['birthday'] ?? '',
      profile: map['profil'] ?? '',
      settings: UserSettings.fromMap(map['setting'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'gender': gender,
      'phone': phone,
      'birthday': birthday,
      'profil': profile,
      'setting': settings.toMap(),
    };
  }
}