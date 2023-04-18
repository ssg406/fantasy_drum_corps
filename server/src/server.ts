import { Server } from 'socket.io';
// import cors from 'cors';
// import express from 'express';
import http from 'http';

// Initialize Express server/Http server/Socket.io server
// const app = express();
// app.use(cors());
const server = http.createServer();
const io = new Server(server, {
  cors: {
    origin: 'http://localhost:10000',
    methods: ['GET', 'POST'],
  },
});

// Start server
io.listen(3000);

export default io;
