import 'dart:convert';

class Category {
  final String name;
  final String description;
  final String? entryType;
  final int? id;
  final bool? isInativo;
  final DateTime? dataCriacao;
  final DateTime? dataAlteracao;
  final String? uid;
  final String? uidFirebase;
  final bool? isChanged;

  Category({
    required this.name,
    required this.description,
    this.entryType,
    this.id,
    this.isInativo,
    this.dataCriacao,
    this.dataAlteracao,
    this.uid,
    this.uidFirebase,
    this.isChanged,
  });

  factory Category.fromJson(String json) => Category.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['Name'] ?? '',
      description: map['Description'] ?? '',
      entryType: map['EntryType'] is String
          ? map['EntryType']
          : map['EntryType'].toString(),
      id: map['Id'] ?? 0,
      isInativo: map['IsInativo'] ?? false,
      dataCriacao: map['DataCriacao'] is String
          ? DateTime.tryParse(map['DataCriacao']) ?? DateTime.now()
          : DateTime.now(),
      dataAlteracao: map['DataAlteracao'] is String
          ? DateTime.tryParse(map['DataAlteracao']) ?? DateTime.now()
          : DateTime.now(),
      uid: map['Uid'] ?? '',
      uidFirebase: map['UidFirebase'] ?? '',
      isChanged: map['IsChanged'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Description': description,
      'EntryType': entryType ?? "",
      'Id': id ?? 0,
      'IsInativo': isInativo ?? false,
      'DataCriacao':
          dataCriacao?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'DataAlteracao':
          dataAlteracao?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'Uid': uid ?? '',
      'UidFirebase': uidFirebase ?? '',
      'IsChanged': isChanged ?? false,
    };
  }

  String toJson() => jsonEncode(toMap());
  
}
