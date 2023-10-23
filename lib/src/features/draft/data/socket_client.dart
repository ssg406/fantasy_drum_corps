import 'dart:developer' as dev;
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'socket_client.g.dart';

class SocketClient {
  late final io.Socket socket;

  // Dev server
  String get connectionString {
    if (kIsWeb) {
      return 'http://localhost:3000';
    } else {
      return Platform.isAndroid
          ? 'http://10.0.2.2:3000'
          : 'http://localhost:3000';
    }
  }

  // Production server
  // String get connectionString =>
  //     'https://fdc-socket-server-0486b50ecf41.herokuapp.com/';

  SocketClient() {
    socket = io.io(
        connectionString,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    if (socket.disconnected) {
      dev.log('Socket is attempting to connect', name: 'Socket Client');
      socket.connect();
    }
  }
}

@Riverpod(keepAlive: true)
SocketClient socketClient(SocketClientRef ref) {
  final client = SocketClient();
  ref.onDispose(() {
    dev.log('Socket ref is being disposed', name: 'SocketClient');
    client.socket.dispose();
  });
  return client;
}
