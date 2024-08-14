
class Class {
  final String gradeId;
final String name ;
final String id;
  final String nameAr;
  final String nameEn;
  final String schoolId;
  Class( {
    required this.id,
    required this.name,
    required this.gradeId,
    required this.nameAr,
    required this.nameEn,
    required this.schoolId,
  });

  // Factory method to create a Grade from JSON
  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      name:json['name'] ,
      gradeId: json['grade_id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      schoolId: json['school_id'],
    );
  }

  // Convert a Grade to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'school_id': schoolId,
    };
  }
}
