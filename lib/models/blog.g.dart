// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Blog _$BlogFromJson(Map<String, dynamic> json) => Blog(
      id: json['id'] as String?,
      title: json['title'] as String?,
      desc: json['desc'] as String?,
      name: json['name'] as String?,
      imgUrl: json['imgUrl'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$BlogToJson(Blog instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'desc': instance.desc,
      'name': instance.name,
      'imgUrl': instance.imgUrl,
      'time': instance.time,
    };
