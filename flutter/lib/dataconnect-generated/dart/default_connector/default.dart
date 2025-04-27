library default_connector;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';

part 'get_events.dart';

part 'create_event.dart';

part 'get_users.dart';

part 'get_user.dart';







class DefaultConnector {
  
  
  GetEventsVariablesBuilder getEvents () {
    return GetEventsVariablesBuilder(dataConnect, );
  }
  
  
  CreateEventVariablesBuilder createEvent ({required String subject, required Timestamp startTime, required Timestamp endTime, }) {
    return CreateEventVariablesBuilder(dataConnect, subject: subject,startTime: startTime,endTime: endTime,);
  }
  
  
  GetUsersVariablesBuilder getUsers () {
    return GetUsersVariablesBuilder(dataConnect, );
  }
  
  
  GetUserVariablesBuilder getUser ({required String userId, }) {
    return GetUserVariablesBuilder(dataConnect, userId: userId,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-west1',
    'default',
    'fir-playground-fd073-service',
  );

  DefaultConnector({required this.dataConnect});
  static DefaultConnector get instance {
    return DefaultConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}

