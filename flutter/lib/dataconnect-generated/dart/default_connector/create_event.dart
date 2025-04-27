part of 'default.dart';

class CreateEventVariablesBuilder {
  String subject;
  Optional<String> _description = Optional.optional(nativeFromJson, nativeToJson);
  Optional<Timestamp> _startTime = Optional.optional((json) => json['startTime'] = Timestamp.fromJson(json['startTime']), defaultSerializer);
  Optional<Timestamp> _endTime = Optional.optional((json) => json['endTime'] = Timestamp.fromJson(json['endTime']), defaultSerializer);
  Optional<String> _location = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _recurrenceRule = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateEventVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }
  CreateEventVariablesBuilder startTime(Timestamp? t) {
   _startTime.value = t;
   return this;
  }
  CreateEventVariablesBuilder endTime(Timestamp? t) {
   _endTime.value = t;
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

  CreateEventVariablesBuilder(this._dataConnect, {required  this.subject,});
  Deserializer<CreateEventData> dataDeserializer = (dynamic json)  => CreateEventData.fromJson(jsonDecode(json));
  Serializer<CreateEventVariables> varsSerializer = (CreateEventVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateEventData, CreateEventVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateEventData, CreateEventVariables> ref() {
    CreateEventVariables vars= CreateEventVariables(subject: subject,description: _description,startTime: _startTime,endTime: _endTime,location: _location,recurrenceRule: _recurrenceRule,);
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
  late Optional<Timestamp>startTime;
  late Optional<Timestamp>endTime;
  late Optional<String>location;
  late Optional<String>recurrenceRule;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateEventVariables.fromJson(Map<String, dynamic> json):
  subject = nativeFromJson<String>(json['subject']) {
  
    description = Optional.optional(nativeFromJson, nativeToJson);
    description.value = json['description'] == null ? null : nativeFromJson<String>(json['description']);
  
    startTime = Optional.optional((json) => json['startTime'] = Timestamp.fromJson(json['startTime']), defaultSerializer);
    startTime.value = json['startTime'] == null ? null : Timestamp.fromJson(json['startTime']);
  
    endTime = Optional.optional((json) => json['endTime'] = Timestamp.fromJson(json['endTime']), defaultSerializer);
    endTime.value = json['endTime'] == null ? null : Timestamp.fromJson(json['endTime']);
  
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
    if(startTime.state == OptionalState.set) {
      json['startTime'] = startTime.toJson();
    }
    if(endTime.state == OptionalState.set) {
      json['endTime'] = endTime.toJson();
    }
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

