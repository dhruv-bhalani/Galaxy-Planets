class Planets {
  String name;
  String lengthOfYear;
  String radius;
  String distance;
  String description;
  String image;
  String hero;
  String planetType;

  Planets({
    required this.name,
    required this.lengthOfYear,
    required this.radius,
    required this.distance,
    required this.description,
    required this.image,
    required this.hero,
    required this.planetType,
  });

  factory Planets.fromJson(Map<String, dynamic> json) => Planets(
    name: json["name"],
    lengthOfYear: json["lengthOfYear"],
    radius: json['radius'],
    distance: json["distanceFromSun"],
    description: json["description"],
    image: json["image"],
    hero: json["hero"],
    planetType: json['planetType'],
  );
}