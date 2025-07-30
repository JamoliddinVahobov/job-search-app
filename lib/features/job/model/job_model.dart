import 'package:job_search_app/core/utils/all_utils.dart';

class JobModel {
  final String id;
  final String title;
  final String description;
  final double latitude;
  final double longitude;
  final String redirectUrl;
  final String adref;
  final String created;
  final String salaryIsPredicted;
  final double salaryMin;
  final double salaryMax;
  final Company company;
  final Category category;
  final Location location;

  JobModel({
    required this.id,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.redirectUrl,
    required this.adref,
    required this.created,
    required this.salaryIsPredicted,
    required this.salaryMin,
    required this.salaryMax,
    required this.company,
    required this.category,
    required this.location,
  });

  factory JobModel.fromMap(MapData json) {
    return JobModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      redirectUrl: json['redirect_url'],
      adref: json['adref'],
      created: json['created'],
      salaryIsPredicted: json['salary_is_predicted'],
      salaryMin: json['salary_min'],
      salaryMax: json['salary_max'],
      company: Company.fromMap(json['company']),
      category: Category.fromMap(json['category']),
      location: Location.fromMap(json['location']),
    );
  }
}

class Company {
  final String displayName;

  Company({required this.displayName});

  factory Company.fromMap(MapData json) {
    return Company(displayName: json['display_name']);
  }
}

class Category {
  final String tag;
  final String label;

  Category({required this.tag, required this.label});

  factory Category.fromMap(MapData json) {
    return Category(tag: json['tag'], label: json['label']);
  }
}

class Location {
  final String displayName;
  final List<String> area;

  Location({required this.displayName, required this.area});

  factory Location.fromMap(MapData json) {
    return Location(
      displayName: json['display_name'],
      area: List<String>.from(json['area']),
    );
  }
}
