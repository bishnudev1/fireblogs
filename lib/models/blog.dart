import 'package:json_annotation/json_annotation.dart';

part 'blog.g.dart';

@JsonSerializable(explicitToJson: true)
class Blog {
  String? id;
  String? title;
  String? desc;
  String? name;
  String? imgUrl;
  String? time;

  Blog({this.id, this.title, this.desc, this.name, this.imgUrl, this.time});

  factory Blog.fromJson(Map<String, dynamic> data) => _$BlogFromJson(data);

  Map<String, dynamic> toJson() => _$BlogToJson(this);
}
