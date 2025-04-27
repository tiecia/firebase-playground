part of 'default.dart';

class GetEventsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetEventsVariablesBuilder(this._dataConnect, );
  Deserializer<GetEventsData> dataDeserializer = (dynamic json)  => GetEventsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetEventsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetEventsData, void> ref() {
    
    return _dataConnect.query("GetEvents", dataDeserializer, emptySerializer, null);
  }
}

class GetEventsEvents {
  String subject;
  String? description;
  Timestamp startTime;
  Timestamp endTime;
  String? location;
  String? recurrenceRule;
  Timestamp createdAt;
  GetEventsEvents.fromJson(dynamic json):
  subject = nativeFromJson<String>(json['subject']),description = json['description'] == null ? null : nativeFromJson<String>(json['description']),startTime = Timestamp.fromJson(json['startTime']),endTime = Timestamp.fromJson(json['endTime']),location = json['location'] == null ? null : nativeFromJson<String>(json['location']),recurrenceRule = json['recurrenceRule'] == null ? null : nativeFromJson<String>(json['recurrenceRule']),createdAt = Timestamp.fromJson(json['createdAt']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['subject'] = nativeToJson<String>(subject);
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    json['startTime'] = startTime.toJson();
    json['endTime'] = endTime.toJson();
    if (location != null) {
      json['location'] = nativeToJson<String?>(location);
    }
    if (recurrenceRule != null) {
      json['recurrenceRule'] = nativeToJson<String?>(recurrenceRule);
    }
    json['createdAt'] = createdAt.toJson();
    return json;
  }

  GetEventsEvents({
    required this.subject,
    this.description,
    required this.startTime,
    required this.endTime,
    this.location,
    this.recurrenceRule,
    required this.createdAt,
  });
}

class GetEventsData {
  List<GetEventsEvents> events;
  GetEventsData.fromJson(dynamic json):
  events = (json['events'] as List<dynamic>)
        .map((e) => GetEventsEvents.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['events'] = events.map((e) => e.toJson()).toList();
    return json;
  }

  GetEventsData({
    required this.events,
  });
}

