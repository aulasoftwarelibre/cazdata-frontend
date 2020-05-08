class JourniesList{
  final List<Journey> journies;

  JourniesList({this.journies});

  factory JourniesList.fromJson(List<dynamic> parsedJson) {

    List<Journey> journies = new List<Journey>();
    journies = parsedJson.map((i)=>Journey.fromJson(i)).toList();

    return new JourniesList(
      journies: journies
    );
  }
}

class Journey {
  String id;
  String title;
  String modality;
  String type;
  String startTime;
  String endTime;
  int distance;
  int minutes;
  int calories;

  Journey(
      {this.id, this.title, this.modality, this.type, this.startTime, this.endTime,this.distance, this.minutes, this.calories});

  Map toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'starts_at': this.startTime,
      'ends_at': this.endTime,
      'distance': this.distance,
      'calories': calories
    };
  }


  factory Journey.fromJson(Map<String, dynamic> json) {
    return new Journey(
      id: json['id'],
      title: json['title'],
      startTime: json['startsAt'],
      endTime: json['endsAt'],
      distance: json['distance'],
      calories: json['calories'],
    );
  }
}
