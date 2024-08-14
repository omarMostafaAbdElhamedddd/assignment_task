
class Grade {
  final String id;
  final String name;
  final String nameAr;
  final String nameEn;
  final String schoolId;

  Grade({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.nameEn,
    required this.schoolId,
  });

  // Factory method to create a Grade from JSON
  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'],
      name: json['name'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      schoolId: json['school_id'],
    );
  }

  // Convert a Grade to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_ar': nameAr,
      'name_en': nameEn,
      'school_id': schoolId,
    };
  }
}
