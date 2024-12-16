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
    if (json.containsKey('user')) {
      return User(
        username: json['user']['username'],
        password: json['user']['password'],
        loggedIn: json['user']['loggedIn'],
        groupList: List<String>.from(json['user']['groupList']),
      );
    } else {
      // Handle flat structure
      return User(
        username: json['username'],
        password: json['password'],
        loggedIn: json['loggedIn'],
        groupList: List<String>.from(json['groupList']),
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'loggedIn': loggedIn,
      'groupList': groupList,
    };
  }
}
