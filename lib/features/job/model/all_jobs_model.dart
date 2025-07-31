import 'package:job_search_app/core/utils/all_utils.dart';

class AllJobsModel {
  final int count;
  final num mean;
  final List<JobModel> jobs;

  AllJobsModel({required this.count, required this.mean, required this.jobs});

  factory AllJobsModel.fromJson(MapData json) {
    return AllJobsModel(
      count: json['count'],
      mean: json['mean'],
      jobs: List.of((json['results'] as List).map((e) => JobModel.fromJson(e))),
    );
  }
}

class JobModel {
  final String id;
  final String title;
  final String description;
  final double? latitude;
  final double? longitude;
  final String redirectUrl;
  final String adref;
  final String created;
  final String salaryIsPredicted;
  final num? salaryMin;
  final num? salaryMax;
  final Company company;
  final Category category;
  final Location location;

  JobModel({
    required this.id,
    required this.title,
    required this.description,
    this.latitude,
    this.longitude,
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

  factory JobModel.fromJson(MapData json) {
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
      company: Company.fromJson(json['company']),
      category: Category.fromJson(json['category']),
      location: Location.fromJson(json['location']),
    );
  }
}

class Company {
  final String companyName;

  Company({required this.companyName});

  factory Company.fromJson(MapData json) {
    return Company(companyName: json['display_name']);
  }
}

class Category {
  final String tag;
  final String label;

  Category({required this.tag, required this.label});

  factory Category.fromJson(MapData json) {
    return Category(tag: json['tag'], label: json['label']);
  }
}

class Location {
  final String displayName;
  final List<String> area;

  Location({required this.displayName, required this.area});

  factory Location.fromJson(MapData json) {
    return Location(
      displayName: json['display_name'],
      area: List<String>.from(json['area']),
    );
  }
}
