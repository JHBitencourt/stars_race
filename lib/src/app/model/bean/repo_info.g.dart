// GENERATED CODE - DO NOT MODIFY BY HAND

part of repo_info;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoInfo _$RepoInfoFromJson(Map<String, dynamic> json) {
  return RepoInfo(
      fullName: json['full_name'] as String,
      name: json['name'] as String,
      url: json['html_url'] as String ?? '',
      description: json['description'] as String,
      homepage: json['homepage'] as String ?? '',
      language: json['language'] as String,
      stargazers: json['stargazers_count'] as int);
}

Map<String, dynamic> _$RepoInfoToJson(RepoInfo instance) => <String, dynamic>{
      'full_name': instance.fullName,
      'html_url': instance.url,
      'homepage': instance.homepage,
      'name': instance.name,
      'description': instance.description,
      'language': instance.language,
      'stargazers_count': instance.stargazers
    };
