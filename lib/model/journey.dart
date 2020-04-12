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
  final String id;
  final String title;
  final String startTime;
  final String endTime;
  final String distance;
  final String minutes;
  final String calories;

  Journey(
      {this.id, this.title, this.startTime, this.endTime,this.distance, this.minutes, this.calories});

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
      startTime: json['starts_at'],
      endTime: json['ends_at'],
      distance: json['distance'],
      calories: json['calories'],
    );
  }
}
