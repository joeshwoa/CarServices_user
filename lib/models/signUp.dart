// To parse this JSON data, do
//
//     final signUp = signUpFromJson(jsonString);

import 'dart:convert';

SignUp signUpFromJson(String str) => SignUp.fromJson(json.decode(str));

String signUpToJson(SignUp data) => json.encode(data.toJson());

class SignUp {
    Data? data;
    String? message;
    String? token;

    SignUp({
        this.data,
        this.message,
        this.token,
    });

    factory SignUp.fromJson(Map<String, dynamic> json) => SignUp(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "token": token,
    };
}

class Data {
    int? id;
    String? email;
    String? fullName;
    dynamic firstName;
    dynamic lastName;
    String? gender;
    dynamic? dateOfBirth;
    String? phone;
    String? whatsappNumber;
    bool? isVerified;
    String? image;
    int? status;
    Group? group;
    List<dynamic>? notes;
    DateTime? createdAt;
    DateTime? updatedAt;

    Data({
        this.id,
        this.email,
        this.fullName,
        this.firstName,
        this.lastName,
        this.gender,
        this.dateOfBirth,
        this.phone,
        this.whatsappNumber,
        this.isVerified,
        this.image,
        this.status,
        this.group,
        this.notes,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        fullName: json["full_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"],
        phone: json["phone"],
        whatsappNumber: json["whatsapp_number"],
        isVerified: json["is_verified"],
        image: json["image"],
        status: json["status"],
        group: json["group"] == null ? null : Group.fromJson(json["group"]),
        notes: json["notes"] == null ? [] : List<dynamic>.from(json["notes"]!.map((x) => x)),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "full_name": fullName,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "phone": phone,
        "whatsapp_number": whatsappNumber,
        "is_verified": isVerified,
        "image": image,
        "status": status,
        "group": group?.toJson(),
        "notes": notes == null ? [] : List<dynamic>.from(notes!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Group {
    int? id;
    String? name;
    dynamic createdAt;
    dynamic updatedAt;

    Group({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
    });

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
