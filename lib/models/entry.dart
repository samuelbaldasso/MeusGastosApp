// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:meus_gastos/models/category.dart';

class Entry {
  final String name;
  String? entryType;
  final double value;
  int categoryId;
  final Category? category;
  DateTime? entryDate;
  final int? id;
  final bool? isInativo;
  final DateTime? dateCreated;
  final DateTime? dateUpdated;
  final String? uid;
  final String? uidFirebase;
  final bool? isChanged;

  Entry({
    required this.name,
    this.entryType,
    required this.value,
    required this.categoryId,
    required this.category,
    this.entryDate,
    this.id,
    this.isInativo,
    this.dateCreated,
    this.dateUpdated,
    this.uid,
    this.uidFirebase,
    this.isChanged,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': name,
      'EntryType': entryType ?? "",
      'Value': value,
      'CategoryId': categoryId,
      'Category': category?.toMap(),
      'EntryDate':
          entryDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'Id': id ?? 0,
      'IsInativo': isInativo ?? false,
      'DataCriacao':
          dateCreated?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'DataAlteracao':
          dateUpdated?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'Uid': uid ?? "",
      'UidFirebase': uidFirebase ?? "",
      'IsChanged': isChanged ?? false,
    };
  }

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
      categoryId: map["CategoryId"] ?? 0,
      category: map["Category"] ??
          Category(
              name: map["Name"] ?? "", description: map["Description"] ?? ""),
      name: map['Name'] ?? '',
      entryType: map['EntryType'] is String
          ? map['EntryType']
          : map['EntryType'].toString(),
      value: map['Value'] ?? 0,
      id: map['Id'] ?? 0,
      isInativo: map['IsInativo'] ?? false,
      dateCreated: map['DataCriacao'] is String
          ? DateTime.tryParse(map['DataCriacao']) ?? DateTime.now()
          : DateTime.now(),
      dateUpdated: map['DataAlteracao'] is String
          ? DateTime.tryParse(map['DataAlteracao']) ?? DateTime.now()
          : DateTime.now(),
      uid: map['Uid'] ?? '',
      uidFirebase: map['UidFirebase'] ?? '',
      isChanged: map['IsChanged'] ?? false,
      entryDate: map['EntryDate'] is String ? DateTime.tryParse(map['EntryDate']) : DateTime.now()

    );
  }

  String toJson() => json.encode(toMap());

  factory Entry.fromJson(String source) =>
      Entry.fromMap(json.decode(source) as Map<String, dynamic>);

  Entry copyWith({
    String? name,
    String? entryType,
    double? value,
    int? categoryId,
    Category? category,
    DateTime? entryDate,
    int? id,
    bool? isInativo,
    DateTime? dateCreated,
    DateTime? dateUpdated,
    String? uid,
    String? uidFirebase,
    bool? isChanged,
  }) {
    return Entry(
      name: name ?? this.name,
      entryType: entryType ?? this.entryType,
      value: value ?? this.value,
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      entryDate: entryDate ?? this.entryDate,
      id: id ?? this.id,
      isInativo: isInativo ?? this.isInativo,
      dateCreated: dateCreated ?? this.dateCreated,
      dateUpdated: dateUpdated ?? this.dateUpdated,
      uid: uid ?? this.uid,
      uidFirebase: uidFirebase ?? this.uidFirebase,
      isChanged: isChanged ?? this.isChanged,
    );
  }
}
