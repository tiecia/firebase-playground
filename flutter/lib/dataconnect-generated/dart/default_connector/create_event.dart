part of 'default.dart';

class CreateEventVariablesBuilder {
  String subject;
  Optional<String> _description = Optional.optional(nativeFromJson, nativeToJson);
  Timestamp startTime;
  Timestamp endTime;
  Optional<String> _location = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _recurrenceRule = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateEventVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }
  CreateEventVariablesBuilder location(String? t) {
   _location.value = t;
   return this;
  }
  CreateEventVariablesBuilder recurrenceRule(String? t) {
   _recurrenceRule.value = t;
   return this;
  }

  CreateEventVariablesBuilder(this._dataConnect, {required  this.subject,required  this.startTime,required  this.endTime,});
  Deserializer<CreateEventData> dataDeserializer = (dynamic json)  => CreateEventData.fromJson(jsonDecode(json));
  Serializer<CreateEventVariables> varsSerializer = (CreateEventVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateEventData, CreateEventVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateEventData, CreateEventVariables> ref() {
    CreateEventVariables vars= CreateEventVariables(subject: subject,description: _description,startTime: startTime,endTime: endTime,location: _location,recurrenceRule: _recurrenceRule,);
    return _dataConnect.mutation("CreateEvent", dataDeserializer, varsSerializer, vars);
  }
}

class CreateEventEventInsert {
  String id;
  CreateEventEventInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateEventEventInsert({
    required this.id,
  });
}

class CreateEventData {
  CreateEventEventInsert event_insert;
  CreateEventData.fromJson(dynamic json):
  event_insert = CreateEventEventInsert.fromJson(json['event_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['event_insert'] = event_insert.toJson();
    return json;
  }

  CreateEventData({
    required this.event_insert,
  });
}

class CreateEventVariables {
  String subject;
  late Optional<String>description;
  Timestamp startTime;
  Timestamp endTime;
  late Optional<String>location;
  late Optional<String>recurrenceRule;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateEventVariables.fromJson(Map<String, dynamic> json):
  subject = nativeFromJson<String>(json['subject']),startTime = Timestamp.fromJson(json['startTime']),endTime = Timestamp.fromJson(json['endTime']) {
  
    description = Optional.optional(nativeFromJson, nativeToJson);
    description.value = json['description'] == null ? null : nativeFromJson<String>(json['description']);
  
    location = Optional.optional(nativeFromJson, nativeToJson);
    location.value = json['location'] == null ? null : nativeFromJson<String>(json['location']);
  
    recurrenceRule = Optional.optional(nativeFromJson, nativeToJson);
    recurrenceRule.value = json['recurrenceRule'] == null ? null : nativeFromJson<String>(json['recurrenceRule']);
  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['subject'] = nativeToJson<String>(subject);
    if(description.state == OptionalState.set) {
      json['description'] = description.toJson();
    }
    json['startTime'] = startTime.toJson();
    json['endTime'] = endTime.toJson();
    if(location.state == OptionalState.set) {
      json['location'] = location.toJson();
    }
    if(recurrenceRule.state == OptionalState.set) {
      json['recurrenceRule'] = recurrenceRule.toJson();
    }
    return json;
  }

  CreateEventVariables({
    required this.subject,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.recurrenceRule,
  });
}

