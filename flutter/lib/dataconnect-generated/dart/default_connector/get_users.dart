part of 'default.dart';

class GetUsersVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetUsersVariablesBuilder(this._dataConnect, );
  Deserializer<GetUsersData> dataDeserializer = (dynamic json)  => GetUsersData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetUsersData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetUsersData, void> ref() {
    
    return _dataConnect.query("GetUsers", dataDeserializer, emptySerializer, null);
  }
}

class GetUsersUsers {
  String displayName;
  String? email;
  String? photoUrl;
  Timestamp createdAt;
  GetUsersUsers.fromJson(dynamic json):
  displayName = nativeFromJson<String>(json['displayName']),email = json['email'] == null ? null : nativeFromJson<String>(json['email']),photoUrl = json['photoUrl'] == null ? null : nativeFromJson<String>(json['photoUrl']),createdAt = Timestamp.fromJson(json['createdAt']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['displayName'] = nativeToJson<String>(displayName);
    if (email != null) {
      json['email'] = nativeToJson<String?>(email);
    }
    if (photoUrl != null) {
      json['photoUrl'] = nativeToJson<String?>(photoUrl);
    }
    json['createdAt'] = createdAt.toJson();
    return json;
  }

  GetUsersUsers({
    required this.displayName,
    this.email,
    this.photoUrl,
    required this.createdAt,
  });
}

class GetUsersData {
  List<GetUsersUsers> users;
  GetUsersData.fromJson(dynamic json):
  users = (json['users'] as List<dynamic>)
        .map((e) => GetUsersUsers.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  GetUsersData({
    required this.users,
  });
}

