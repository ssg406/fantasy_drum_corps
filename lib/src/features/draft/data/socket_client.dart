import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'socket_client.g.dart';

// Local
const connectionString = 'http://localhost:3000/';

// Remote
// const connectionString = 'https://fantasy-drum-corps-server.herokuapp.com

class SocketClient {
  late final io.Socket socket;

  SocketClient() {
    socket = io.io(connectionString, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    if (socket.disconnected) {
      socket.connect();
    }
  }
}

@riverpod
SocketClient socketClient(SocketClientRef ref) => SocketClient();
