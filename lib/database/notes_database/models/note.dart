class Note {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  int? color;

  Note({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.color,
  });

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['note'] = this.note;
    data['isCompleted'] = this.isCompleted;

    data['color'] = this.color;

    return data;
  }
}
