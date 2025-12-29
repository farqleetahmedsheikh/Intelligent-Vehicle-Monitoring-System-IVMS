class Detection {
  final int id;
  final int complaintId;
  final String? deviceId;
  final String? locationText;
  final double? latitude;
  final double? longitude;
  final String? detectedImage;
  final DateTime detectedAt;

  Detection({
    required this.id,
    required this.complaintId,
    this.deviceId,
    this.locationText,
    this.latitude,
    this.longitude,
    this.detectedImage,
    required this.detectedAt,
  });

  factory Detection.fromJson(Map<String, dynamic> json) {
    return Detection(
      id: json['id'] ?? 0,
      complaintId: json['complaint'] ?? json['complaintId'] ?? 0,
      deviceId: json['deviceId'],
      locationText: json['locationText'],
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      detectedImage: json['detectedImage'],
      detectedAt: json['detectedAt'] != null
          ? DateTime.parse(json['detectedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'complaint': complaintId,
      'deviceId': deviceId,
      'locationText': locationText,
      'latitude': latitude,
      'longitude': longitude,
      'detectedImage': detectedImage,
      'detectedAt': detectedAt.toIso8601String(),
    };
  }
}
