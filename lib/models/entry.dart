// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:meus_gastos/models/category.dart';

class Entry {
  final String name;
  final String entryType;
  final double value;
  final int categoryId;
  final Category category;
  final DateTime? entryDate;
  final int? id;
  final bool? isInativo;
  final DateTime? dateCreated;
  final DateTime? dateUpdated;
  final String? uid;
  final String? uidFirebase;
  final bool? isChanged;

  Entry({
    required this.name,
    required this.entryType,
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
      'EntryType': entryType,
      'Value': value,
      'CategoryId': categoryId,
      'Category': category.toMap(),
      'EntryDate': entryDate ?? DateTime.now(),
      'Id': id ?? 0,
      'IsInativo': isInativo ?? false,
      'DataCriacao': dateCreated ?? DateTime.now(),
      'DataAlteracao': dateUpdated ?? DateTime.now(),
      'Uid': uid ?? '',
      'UidFirebase': uidFirebase ?? '',
      'IsChanged': isChanged ?? false,
    };
  }

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
      name: map['Name'] as String,
      entryType: map['EntryType'] as String,
      value: map['Value'] as double,
      categoryId: map['CategoryId'] as int,
      category: Category.fromMap(map['Category'] as Map<String,dynamic>),
      entryDate: map['EntryDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['EntryDate'] as int) : null,
      id: map['Id'] != null ? map['Id'] as int : null,
      isInativo: map['IsInativo'] != null ? map['IsInativo'] as bool : null,
      dateCreated: map['dataCriacao'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dataCriacao'] as int) : null,
      dateUpdated: map['dataAlteracao'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dataAlteracao'] as int) : null,
      uid: map['Uid'] != null ? map['Uid'] as String : null,
      uidFirebase: map['UidFirebase'] != null ? map['UidFirebase'] as String : null,
      isChanged: map['IsChanged'] != null ? map['IsChanged'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Entry.fromJson(String source) => Entry.fromMap(json.decode(source) as Map<String, dynamic>);
}
