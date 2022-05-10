import 'package:signalr_netcore/signalr_client.dart';

const serverUrl = "http://office.pepr.com:25253/chat";

final hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();

//final hubConnection.onClose( (error) => print('Connection closed'));
Future connectService() async {
  await hubConnection.start();
}

Future joinRoom(String room, String user) async {
  await hubConnection
      .invoke('SendMessage', args: [user, "", room, true, false]);
}

Future sendMessage(String user, String message, String room) async {
  await hubConnection
      .invoke('SendMessage', args: [user, message, room, false, false]);
}

Future leaveRoom(String room, String user) async {
  await hubConnection
      .invoke('SendMessage', args: [user, "", room, false, true]);
}
