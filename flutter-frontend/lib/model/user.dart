class User {
  final String username;
  final String password;
  final bool loggedIn;
  final List<String> groupList;

  User({
    required this.username,
    required this.password,
    required this.loggedIn,
    required this.groupList,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['user']['username'],
      password: json['user']['password'],
      loggedIn: json['user']['loggedIn'],
      groupList: List<String>.from(json['user']['groupList']),
    );
  }
}


