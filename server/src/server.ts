import {Server} from 'socket.io';
import cors from 'cors';
import express from 'express';
import http from 'http';

// Initialize Express server/Http server/Socket.io server
const app = express();
app.use(cors());
const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: "http://localhost:59481",
    methods: ["GET", "POST"]
  }
});

// Start server
server.listen(3000, () => {
    console.log('HTTP Server is listening on port 3000');
  })

export default io;