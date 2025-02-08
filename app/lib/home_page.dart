import 'package:app/socket_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var socketService = SocketServices();
  var socketMessage = "";

  @override
  void initState() {
    super.initState();

    socketService.connectAndListen();

    socketService.onLoginEvent = (data) => {
          setState(() {
            socketMessage = data;
          })
        };

    socketService.onLogoutEvent = (data) => {
          setState(() {
            socketMessage = data;
          })
        };

    // SnippetCoder diganti menjadi nama imei pada device / kode unique dari device
    socketService.joinSession("SnippetCoder");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Socket IO"),
      ),
      body: Center(
        child: Text(socketMessage),
      ),
    );
  }
}
