class Meta {
  final bool ok;
  final String message;

  Meta({
    required this.ok,
    required this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) =>
      Meta(ok: json['ok'], message: json['message']);
}
