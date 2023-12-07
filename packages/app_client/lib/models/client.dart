/// Client model.
class Client {
  /// Creates a new client.
  Client({
    this.firstname,
    this.lastname,
    this.email,
    this.address,
    this.photo,
    this.caption,
  });

  /// Creates a new client from a map.
  factory Client.fromMap(Map<String, dynamic> json) => Client(
        firstname: json['firstname'] as String?,
        lastname: json['lastname'] as String?,
        email: json['email'] as String?,
        address: json['address'] as String?,
        photo: json['photo'] as String?,
        caption: json['caption'] as String?,
      );

  /// Converts the client to a map.
  Map<String, dynamic> toMap() => {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'address': address,
        'photo': photo,
        'caption': caption,
      };

  /// The client's first name.
  final String? firstname;

  /// The client's last name.
  final String? lastname;

  /// The client's email.
  final String? email;

  /// The client's address.
  final String? address;

  /// The client's photo.
  final String? photo;

  /// The client's caption.
  final String? caption;
}
