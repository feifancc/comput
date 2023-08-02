import express from 'express';
const app = express();
import http from 'http';
const server = http.createServer(app);
import { Server } from "socket.io";
const io = new Server(server);
const port = 3640
io.on('connection', (socket) => {
  console.log('接收到客户端请求', socket.id);
  socket.on('chatMessage', (msg, callback) => {
    console.log('客户端请求信息', msg);
    callback('你请求成功了')
    io.emit('chat message', {
      status: 200,
      data: 'result'
    });
  });
  socket.on('feifan', (msg) => {
    console.log(msg);
    socket.send('feifan', msg)
  })
  socket.on("disconnect", (reason) => {
    console.log('斷開', socket.id);

  });

})

server.listen(port, () => console.log(`soket:${port}`));