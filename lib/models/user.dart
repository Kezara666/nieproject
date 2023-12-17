class User {
  dynamic id;
  dynamic? firstName;
  dynamic? lastName;
  dynamic? email;
  dynamic? role;
  dynamic? school;
  dynamic? studentIndex;
  dynamic? isActive;
  dynamic? emailVerifiedAt;
  dynamic? password;
  dynamic? rememberToken;
  dynamic? createdAt;
  dynamic? updatedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.school,
    this.studentIndex,
    this.isActive,
    this.emailVerifiedAt,
    this.password,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      role: json['role'],
      school: json['school'],
      studentIndex: json['student_index'],
      isActive: json['is_active'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? json['email_verified_at']
          : null,
      password: json['password'],
      rememberToken: json['remember_token'],
      createdAt: json['created_at'] != null
          ? json['created_at']
          : null,
      updatedAt: json['updated_at'] != null
          ? json['updated_at']
          : null,
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'role': role,
      'school': school,
      'student_index': studentIndex,
      'is_active': isActive,
      'email_verified_at': emailVerifiedAt?.toIso8601dynamic(),
      'password': password,
      'remember_token': rememberToken,
      'created_at': createdAt?.toIso8601dynamic(),
      'updated_at': updatedAt?.toIso8601dynamic(),
    };
  }
}
