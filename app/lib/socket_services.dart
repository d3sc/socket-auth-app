import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketServices {
  static final SocketServices _instance = SocketServices._internal();
  IO.Socket? socket;

  SocketServices._internal();

  Function(dynamic data)? onLoginEvent;
  Function(dynamic data)? onLogoutEvent;

  factory SocketServices() {
    return _instance;
  }

  void connectAndListen() {
    socket ??= IO.io("http://192.168.1.6:3000",
        IO.OptionBuilder().setTransports(["websocket"]).build());

    socket!.onConnect((data) => {print("Connected to socket")});

    socket!.on("session-expired", (data) => {onLogoutEvent?.call(data)});

    socket!.on("session-join", (data) => {onLoginEvent?.call(data)});
  }

  void joinSession(String userId) {
    socket!.emit("user-join", userId);
  }

  void dispose() {
    if (socket != null) {
      socket!.disconnect();
      socket = null;
    }
  }
}
