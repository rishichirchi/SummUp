# SummUp

MoodPulse is an Emotion-Aware Chat Companion app designed to enhance chat experiences by analyzing the sentiment of ongoing conversations and providing real-time feedback on the chat's mood. Using a combination of WebSocket communication, Kafka message streaming, and sentiment analysis, MoodPulse generates insights that help users understand the emotional tone of their chat interactions.

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Setup and Installation](#setup-and-installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Project Overview

In SummUp, two users can chat with each other in real time using WebSocket communication managed by a Spring Boot backend. Each message is analyzed for sentiment by a Go-based microservice, which returns the current mood of the conversation. This sentiment feedback is displayed in the Flutter app, allowing users to get a visual representation of the chat's emotional state through emojis and suggestions to uplift the mood.

## Features

- Real-time chat system with WebSocket
- Sentiment analysis on live chat messages
- Kafka message streaming for efficient message processing
- Mood feedback displayed to users as emojis
- Suggestions for uplifting the chat based on sentiment analysis

## Architecture

The workflow of the MoodPulse app is as follows:

1. **Flutter App**: Users communicate via a chat interface.
2. **Spring Boot Backend**: Manages WebSocket connections and routes chat messages to Kafka.
3. **Kafka**: Acts as a message broker, streaming chat messages for processing.
4. **Go Microservice**: Consumes messages from Kafka, performs sentiment analysis, and returns mood feedback.
5. **Sentiment Analysis**: Uses a language model (e.g., Gemini) to analyze messages.
6. **Mood Indicator**: The Flutter app shows the mood of the conversation using emojis based on sentiment feedback.

## Workflow Diagram
![image](https://github.com/user-attachments/assets/018c1c1c-0550-43b9-8b2f-5c43b57d788b)


## Tech Stack

- **Frontend**: Flutter
- **Backend**: Spring Boot, WebSocket
- **Messaging Queue**: Apache Kafka
- **Sentiment Analysis**: Go microservice with language model integration (e.g., Gemini)
- **Database**: [Your choice, if needed for chat storage]

## Setup and Installation

### Prerequisites

- Java 11+
- Kafka
- Go (latest version)
- Flutter SDK
- Node.js (for testing WebSocket with JavaScript)

### Steps

1. **Clone the Repository**

   ```bash
   git clone https://github.com/your-username/MoodPulse.git
   cd MoodPulse
2. **Install and Run Kafka**
Make sure Kafka is installed and running. Update application.properties to point to your Kafka instance.

3. **Start the Spring Boot Backend**

```bash
cd springboot_backend
./mvnw spring-boot:run
Run the Go Microservice
```

4. **Start the Go Microservice**
```bash
cd go_microservice
go run main.go
```
5. **Start the Flutter App**

```bash
cd flutter_app
flutter run
```
## WebSocket Testing

You can use the JavaScript WebSocket client (websocket.js) for testing WebSocket endpoints.

## Usage
Start Chatting: Open the app, connect with another user, and start chatting.
View Mood Feedback: The app will display an emoji based on the sentiment analysis results.
Suggestions to Improve Mood: If the sentiment is negative, MoodPulse provides suggestions for uplifting the chat's mood.

## Contributing
We welcome contributions to MoodPulse! If you'd like to contribute, please follow these steps:

Fork the repository.
Create a new branch.
Make your changes.
Submit a pull request.

## License
This project is licensed under the MIT License.
