class Time {
  String updated;
  DateTime updatedIso;
  String updateduk;

  Time({
    required this.updated,
    required this.updatedIso,
    required this.updateduk,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
    updated: json["updated"],
    updatedIso: DateTime.parse(json["updatedISO"]),
    updateduk: json["updateduk"],
  );

  Map<String, dynamic> toJson() => {
    "updated": updated,
    "updatedISO": updatedIso.toIso8601String(),
    "updateduk": updateduk,
  };
}