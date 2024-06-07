class AddressResult {
  final String title;
  final String coordinates;

  AddressResult({required this.title, required this.coordinates});

  factory AddressResult.fromJson(Map<String, dynamic> json) {
    final position = json['position'];
    final coordinates = '${position['lat']},${position['lng']}';
    return AddressResult(
      title: json['title'],
      coordinates: coordinates,
    );
  }
}
