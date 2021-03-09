class Task {
  int id;
  double position;
  String text;
  int allTaskCount;
  int completedTaskCount;
  double completedTaskProcent;
  //double widthContainer;
  //double heightContainer;

  Task({this.text, this.id, this.position, this.allTaskCount, this.completedTaskCount, this.completedTaskProcent});

  /*Task.newTask(String text) {
    this.id = id;
    this.text = text;
    this.allTaskCount = 10;
    this.completedTaskCount = 5;
    this.completedTaskProcent = 0.5;
  }*/
  /*{
    allTaskCount = 10;
    completedTaskCount = 5;
    completedTaskProcent = (100 / allTaskCount) * completedTaskCount;
    //heightContainer = _calculateHeightContainer();
  }*/

  factory Task.fromMap(Map<String, dynamic> json) => Task(
    id: json["id"],
    position: json["position"],
    text: json["text"],
    allTaskCount: json["allTaskCount"],
    completedTaskCount: json["completedTaskCount"],
    completedTaskProcent: json["completedTaskProcent"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "position": position,
    "text": text,
    "allTaskCount": allTaskCount,
    "completedTaskCount": completedTaskCount,
    "completedTaskProcent": completedTaskProcent,
  };

  /*_calculateHeightContainer() {
    var lenghtLine = widthContainer - 40;
    var countLine = (text.length ~/ lenghtLine).toDouble() + 1.0;
    var height = 52 * countLine + 10;
    print('text.length == ${text.length}');
    print('countLine == $countLine');
    print(11.0~/2.0);
    return height;
  }*/
}