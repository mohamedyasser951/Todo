class Tasks {
  int? id;
  int? isComplete;
  String? title;
  String? note;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Tasks(
      {this.id,
      this.title,
      this.note,
      this.date,
      this.startTime,
      this.endTime,
      this.remind,
      this.repeat,
      this.color,
      this.isComplete});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json['title'];
    note = json['note'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
    isComplete = json['isComplete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["title"] = title;
    data["note"] = note;
    data["date"] = date;
    data["startTime"] = startTime;
    data["endTime"] = endTime;
    data["remind"] = remind;
    data["repeat"] = repeat;
    data["color"] = color;
    data["isComplete"] = isComplete;
    return data;
  }
}
