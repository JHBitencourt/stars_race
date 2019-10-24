// GENERATED CODE - DO NOT MODIFY BY HAND

part of repo_info;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoInfo _$RepoInfoFromJson(Map<String, dynamic> json) {
  return RepoInfo(
      json['full_name'] as String,
      json['html_url'] as String,
      json['description'] as String,
      json['homepage'] as String,
      json['language'] as String,
      json['stargazers_count'] as int);
}

Map<String, dynamic> _$RepoInfoToJson(RepoInfo instance) => <String, dynamic>{
      'full_name': instance.fullName,
      'html_url': instance.url,
      'description': instance.description,
      'homepage': instance.homepage,
      'language': instance.language,
      'stargazers_count': instance.stargazers
    };
