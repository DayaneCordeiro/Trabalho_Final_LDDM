import 'package:floor/floor.dart';

@entity
class Activity {
  @PrimaryKey(autoGenerate: true)
  int id;
  String title;
  double actualTime;
  int missingTime;
  double percentage;

  Activity({this.title, this.actualTime, this.missingTime, this.percentage});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    actualTime = json['actualTime'];
    missingTime = json['missingTime'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['actualTime'] = this.actualTime;
    data['missingTime'] = this.missingTime;
    data['percentage'] = this.percentage;
    return data;
  }
}
