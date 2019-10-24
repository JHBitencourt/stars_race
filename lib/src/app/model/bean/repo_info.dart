library repo_info;

import 'package:json_annotation/json_annotation.dart';

part 'repo_info.g.dart';

@JsonSerializable()
class RepoInfo {
  @JsonKey(name: 'full_name')
  final String fullName;

  @JsonKey(name: 'html_url')
  final String url;

  final String name;
  final String description;
  final String homepage;
  final String language;

  @JsonKey(name: 'stargazers_count')
  final int stargazers;

  RepoInfo({this.fullName, this.name, this.url, this.description, this.homepage,
    this.language, this.stargazers});

  factory RepoInfo.fromJson(Map<String, dynamic> json) => _$RepoInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RepoInfoToJson(this);
}
