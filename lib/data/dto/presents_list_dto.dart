class PresentsListDto {
  final String? name;
  final int? birthYear;
  final String? createdDate;
  final bool? completed;
  final List<Map<String, dynamic>>? links;

  PresentsListDto({
    this.name,
    this.birthYear,
    this.createdDate,
    this.completed,
    this.links,
  });

  factory PresentsListDto.fromJson(Map<String, dynamic> json) {
    return PresentsListDto(
      name: json['name'] as String?,
      birthYear: json['birthYear'] as int?,
      createdDate: json['createdDate'] as String?,
      completed: json['completed'] as bool?,
      links: (json['links'] as List<dynamic>?)
          ?.map((item) => Map<String, dynamic>.from(item as Map))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthYear': birthYear,
      'createdDate': createdDate,
      'completed': completed,
      'links': links?.map((item) => item).toList(),
    };
  }
}
