// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
    List<Datum>? data;
    Links? links;
    Meta? meta;

    Categories({
        this.data,
        this.links,
        this.meta,
    });

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
    };
}

class Datum {
    int? id;
    String? name;
    String? slug;
    String? displayMode;
    String? description;
    String? metaTitle;
    String? metaDescription;
    String? metaKeywords;
    int? status;
    String? bannerUrl;
    String? logoUrl;
    List<Translation>? translations;
    List<dynamic>? additional;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.name,
        this.slug,
        this.displayMode,
        this.description,
        this.metaTitle,
        this.metaDescription,
        this.metaKeywords,
        this.status,
        this.bannerUrl,
        this.logoUrl,
        this.translations,
        this.additional,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        displayMode: json["display_mode"],
        description: json["description"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaKeywords: json["meta_keywords"],
        status: json["status"],
        bannerUrl: json["banner_url"],
        logoUrl: json["logo_url"],
        translations: json["translations"] == null ? [] : List<Translation>.from(json["translations"]!.map((x) => Translation.fromJson(x))),
        additional: json["additional"] == null ? [] : List<dynamic>.from(json["additional"]!.map((x) => x)),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "display_mode": displayMode,
        "description": description,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_keywords": metaKeywords,
        "status": status,
        "banner_url": bannerUrl,
        "logo_url": logoUrl,
        "translations": translations == null ? [] : List<dynamic>.from(translations!.map((x) => x.toJson())),
        "additional": additional == null ? [] : List<dynamic>.from(additional!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Translation {
    int? id;
    int? categoryId;
    String? name;
    String? slug;
    String? urlPath;
    String? description;
    String? metaTitle;
    String? metaDescription;
    String? metaKeywords;
    int? localeId;
    Locale? locale;

    Translation({
        this.id,
        this.categoryId,
        this.name,
        this.slug,
        this.urlPath,
        this.description,
        this.metaTitle,
        this.metaDescription,
        this.metaKeywords,
        this.localeId,
        this.locale,
    });

    factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        slug: json["slug"],
        urlPath: json["url_path"],
        description: json["description"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaKeywords: json["meta_keywords"],
        localeId: json["locale_id"],
        locale: localeValues.map[json["locale"]]!,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "slug": slug,
        "url_path": urlPath,
        "description": description,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_keywords": metaKeywords,
        "locale_id": localeId,
        "locale": localeValues.reverse[locale],
    };
}

enum Locale {
    AR,
    EN
}

final localeValues = EnumValues({
    "ar": Locale.AR,
    "en": Locale.EN
});

class Links {
    String? first;
    String? last;
    dynamic prev;
    dynamic next;

    Links({
        this.first,
        this.last,
        this.prev,
        this.next,
    });

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
    );

    Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
    };
}

class Meta {
    int? currentPage;
    int? from;
    int? lastPage;
    List<Link>? links;
    String? path;
    int? perPage;
    int? to;
    int? total;

    Meta({
        this.currentPage,
        this.from,
        this.lastPage,
        this.links,
        this.path,
        this.perPage,
        this.to,
        this.total,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
    };
}

class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
