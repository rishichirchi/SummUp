const SockJS = require('sockjs-client');
const Stomp = require('@stomp/stompjs');
const axios = require('axios');

const socket = new SockJS("http://localhost:8080/ws");
const stompClient = Stomp.Stomp.over(socket);

stompClient.connect({}, (frame) => {
    console.log('Connected: ' + frame);

    // Subscribe to the public chat destination
    stompClient.subscribe('/chat/public', function (messageOutput) {
        console.log("Received message:", messageOutput.body);
    });

    // Send a message to the server (to /app/chat.sendMessage)
    const chatMessage = {
        sender: "Khushi",
        content: "I am learning springboot!"
    };

    stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));
});

axios.get('http://localhost:8080/getChats').then((response) => {
    console.log(response.data);
}).catch((error) => {
    console.error(error);
});
