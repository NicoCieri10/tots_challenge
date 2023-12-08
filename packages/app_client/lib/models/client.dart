import 'package:app_client/app_client.dart';
import 'package:hive/hive.dart';

part 'client.g.dart';

@HiveType(typeId: 1)

/// Client model.
class Client {
  /// Creates a new client.
  Client({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.address,
    this.photo,
    this.caption,
    this.createdAt,
    this.updatedAt,
    this.deleted,
  });

  ///  This constructor parses [JSON] and converts it to a [Client].
  factory Client.fromMap(JSON json) => Client(
        id: json['id'] as int?,
        firstname: json['firstname'] as String?,
        lastname: json['lastname'] as String?,
        email: json['email'] as String?,
        address: json['address'] as String?,
        photo: json['photo'] as String?,
        caption: json['caption'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        deleted: json['deleted'] as int?,
      );

  /// Converts the client to a map.
  Map<String, dynamic> toMap() => {
        'id': id,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'address': address,
        'photo': photo,
        'caption': caption,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'deleted': deleted,
      };

  /// The client's id.
  @HiveField(0)
  final int? id;

  /// The client's first name.
  @HiveField(1)
  final String? firstname;

  /// The client's last name.
  @HiveField(2)
  final String? lastname;

  /// The client's email.
  @HiveField(3)
  final String? email;

  /// The client's address.
  @HiveField(4)
  final String? address;

  /// The client's photo.
  @HiveField(5)
  final String? photo;

  /// The client's caption.
  @HiveField(6)
  final String? caption;

  /// The client's created at.
  @HiveField(7)
  final DateTime? createdAt;

  /// The client's updated at.
  @HiveField(8)
  final DateTime? updatedAt;

  /// How many times the client has been deleted.
  @HiveField(9)
  final int? deleted;
}
