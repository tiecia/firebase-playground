part of 'default.dart';

class GetUserVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  GetUserVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetUserData> dataDeserializer = (dynamic json)  => GetUserData.fromJson(jsonDecode(json));
  Serializer<GetUserVariables> varsSerializer = (GetUserVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetUserData, GetUserVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetUserData, GetUserVariables> ref() {
    GetUserVariables vars= GetUserVariables(userId: userId,);
    return _dataConnect.query("GetUser", dataDeserializer, varsSerializer, vars);
  }
}

class GetUserUser {
  String userId;
  String displayName;
  String? email;
  String? photoUrl;
  Timestamp createdAt;
  GetUserUser.fromJson(dynamic json):
  userId = nativeFromJson<String>(json['userId']),displayName = nativeFromJson<String>(json['displayName']),email = json['email'] == null ? null : nativeFromJson<String>(json['email']),photoUrl = json['photoUrl'] == null ? null : nativeFromJson<String>(json['photoUrl']),createdAt = Timestamp.fromJson(json['createdAt']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
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

  GetUserUser({
    required this.userId,
    required this.displayName,
    this.email,
    this.photoUrl,
    required this.createdAt,
  });
}

class GetUserData {
  GetUserUser? user;
  GetUserData.fromJson(dynamic json):
  user = json['user'] == null ? null : GetUserUser.fromJson(json['user']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user != null) {
      json['user'] = user!.toJson();
    }
    return json;
  }

  GetUserData({
    this.user,
  });
}

class GetUserVariables {
  String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetUserVariables.fromJson(Map<String, dynamic> json):
  userId = nativeFromJson<String>(json['userId']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  GetUserVariables({
    required this.userId,
  });
}

