class Chat {
  dynamic id;
  dynamic studentId;
  dynamic studentName;
  dynamic message;
  dynamic reply;
  dynamic messageStatus;
  dynamic createdAt;
  dynamic updatedAt;

  Chat({
    this.id,
    this.studentId,
    this.studentName,
    this.message,
    this.reply,
    this.messageStatus,
    this.createdAt,
    this.updatedAt,
  });

  Chat.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    studentName = json['student_name'];
    message = json['message'];
    reply = json['reply'];
    messageStatus = json['message_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['student_id'] = this.studentId;
    data['student_name'] = this.studentName;
    data['message'] = this.message;
    data['reply'] = this.reply;
    data['message_status'] = this.messageStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
