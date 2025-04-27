# default_connector SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
DefaultConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### GetUsers
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getUsers().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUsersData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getUsers();
GetUsersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getUsers().ref();
ref.execute();

ref.subscribe(...);
```


### GetUser
#### Required Arguments
```dart
String userId = ...;
DefaultConnector.instance.getUser(
  userId: userId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUserData, GetUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getUser(
  userId: userId,
);
GetUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;

final ref = DefaultConnector.instance.getUser(
  userId: userId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetEvents
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getEvents().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetEventsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getEvents();
GetEventsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getEvents().ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### CreateEvent
#### Required Arguments
```dart
String subject = ...;
DefaultConnector.instance.createEvent(
  subject: subject,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateEvent, we created `CreateEventBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateEventVariablesBuilder {
  ...
   CreateEventVariablesBuilder description(String? t) {
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

  ...
}
DefaultConnector.instance.createEvent(
  subject: subject,
)
.description(description)
.startTime(startTime)
.endTime(endTime)
.location(location)
.recurrenceRule(recurrenceRule)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateEventData, CreateEventVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createEvent(
  subject: subject,
);
CreateEventData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String subject = ...;

final ref = DefaultConnector.instance.createEvent(
  subject: subject,
).ref();
ref.execute();
```

