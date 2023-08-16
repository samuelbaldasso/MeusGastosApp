class Category {
  final String name;
  final String description;
  final String entryType;
  final int id;
  final bool isInativo;
  final DateTime dataCriacao;
  final DateTime dataAlteracao;
  final String uid;
  final String uidFirebase;
  final bool isChanged;

  Category({
    required this.name,
    required this.description,
    required this.entryType,
    required this.id,
    required this.isInativo,
    required this.dataCriacao,
    required this.dataAlteracao,
    required this.uid,
    required this.uidFirebase,
    required this.isChanged,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['Name'] ?? '',
      description: json['Description'] ?? '',
      entryType: json['EntryType'] ?? '',
      id: json['Id'] ?? 0,
      isInativo: json['IsInativo'] ?? false,
      dataCriacao: DateTime.tryParse(json['DataCriacao']) ?? DateTime.now(),
      dataAlteracao: DateTime.tryParse(json['DataAlteracao']) ?? DateTime.now(),
      uid: json['Uid'] ?? '',
      uidFirebase: json['UidFirebase'] ?? '',
      isChanged: json['IsChanged'] ?? false,
    );
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['Name'] ?? '',
      description: map['Description'] ?? '',
      entryType: map['EntryType'] ?? '',
      id: map['Id'] ?? 0,
      isInativo: map['IsInativo'] ?? false,
      dataCriacao: DateTime.tryParse(map['DataCriacao']) ?? DateTime.now(),
      dataAlteracao: DateTime.tryParse(map['DataAlteracao']) ?? DateTime.now(),
      uid: map['Uid'] ?? '',
      uidFirebase: map['UidFirebase'] ?? '',
      isChanged: map['IsChanged'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Description': description,
      'EntryType': entryType,
      'Id': id,
      'IsInativo': isInativo,
      'DataCriacao': dataCriacao.toIso8601String(),
      'DataAlteracao': dataAlteracao.toIso8601String(),
      'Uid': uid,
      'UidFirebase': uidFirebase,
      'IsChanged': isChanged,
    };
  }
}
