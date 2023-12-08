/// A link in the navigation bar.
class Link {
  /// Creates a new link.
  const Link({
    required this.active,
    this.url,
    this.label,
  });

  /// Creates a new link from a map.
  factory Link.fromMap(Map<String, dynamic> map) {
    return Link(
      url: map['url'] as String?,
      label: map['label'] as String?,
      active: (map['active'] as bool?) ?? false,
    );
  }

  /// The URL of the link.
  final String? url;

  /// The label of the link.
  final String? label;

  /// Whether the link is active.
  final bool? active;
}
