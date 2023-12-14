class Chat {
  String? sId;
  String? userName;
  String? userEmail;
  String? userSchool;
  String? ticketContent;
  String? ticketStatus;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? ticketReply;

  Chat(
      {this.sId,
      this.userName,
      this.userEmail,
      this.userSchool,
      this.ticketContent,
      this.ticketStatus,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.ticketReply});

  Chat.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userSchool = json['user_school'];
    ticketContent = json['ticket_content'];
    ticketStatus = json['ticket_status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    ticketReply = json['ticket_reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_school'] = this.userSchool;
    data['ticket_content'] = this.ticketContent;
    data['ticket_status'] = this.ticketStatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['ticket_reply'] = this.ticketReply;
    return data;
  }
}