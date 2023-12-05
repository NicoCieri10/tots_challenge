import 'package:app_client/app_client.dart';
import 'package:hive/hive.dart';

part 'auth_user.g.dart';

@HiveType(typeId: 0)

/// AuthUser model
class AuthUser {
  /// Class constructor
  AuthUser({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.photo,
    this.phone,
    this.facebookId,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.isNotification,
    this.caption,
    this.tokenType,
    this.accessToken,
  });

  /// This constructor parses [JSON] and converts it to a [AuthUser].
  factory AuthUser.fromMap(JSON json) => AuthUser(
        id: json['id'] as int? ?? 0,
        firstname: json['firstname'] as String? ?? '',
        lastname: json['lastname'] as String? ?? '',
        email: json['email'] as String? ?? '',
        photo: json['photo'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        facebookId: json['facebook_id'] as dynamic,
        role: json['role'] as int? ?? 0,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        status: json['status'] as int? ?? 0,
        isNotification: json['is_notification'] as int? ?? 0,
        caption: json['caption'] as dynamic,
        tokenType: json['token_type'] as String? ?? '',
        accessToken: json['access_token'] as String? ?? '',
      );

  /// Id of the user
  @HiveField(0)
  final int? id;

  /// Firstname of the user
  @HiveField(1)
  final String? firstname;

  /// Lastname of the user
  @HiveField(2)
  final String? lastname;

  /// Email of the user
  @HiveField(3)
  final String? email;

  /// Photo of the user
  @HiveField(4)
  final String? photo;

  /// Phone of the user
  @HiveField(5)
  final String? phone;

  /// Facebook id of the user
  @HiveField(6)
  final dynamic facebookId;

  /// Role of the user
  @HiveField(7)
  final int? role;

  /// Created date of the user
  @HiveField(8)
  final DateTime? createdAt;

  /// Updated date of the user
  @HiveField(9)
  final DateTime? updatedAt;

  /// Status of the user
  @HiveField(10)
  final int? status;

  /// Is notification of the user
  @HiveField(11)
  final int? isNotification;

  /// Caption of the user
  @HiveField(12)
  final dynamic caption;

  /// Token type of the user
  @HiveField(13)
  final String? tokenType;

  /// Access token of the user
  @HiveField(14)
  final String? accessToken;
}
