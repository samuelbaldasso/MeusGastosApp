import 'dart:convert';

class Category {
  final String name;
  final String description;
  final int entryType;
  final int id;
  final String uid;
  final String uidFirebase;
  final bool isChanged;

  Category(this.name, this.description, this.entryType, this.id, this.uid,
      this.uidFirebase, this.isChanged);

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(map['Name'], map['Description'], map['EntryType'], map['Id'], map["id"], map['UidFirebase'], map['IsChanged']);
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Description': description,
      'EntryType': entryType,
      'Id': id,
      'Uid': uid,
      'UidFirebase': uidFirebase,       
      'IsChanged': isChanged
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory Category.fromJson(String source) {
    final data = jsonDecode(source);
    return Category.fromMap(data);
  }
}