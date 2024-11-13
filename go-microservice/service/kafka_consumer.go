package service

import (
	"fmt"
	"log"

	"gopkg.in/confluentinc/confluent-kafka-go.v1/kafka"
)



func KafkaConsumer(){
	consumer, err := kafka.NewConsumer(&kafka.ConfigMap{
		"bootstrap.servers":"localhost:9092",
		"group.id": "moodpulse-consumer",
		"auto.offset.reset": "earliest",
	})

	if err != nil{
		log.Fatalf("Error creating kakfa consumer: %v", err)
	}

	defer consumer.Close()

	err = consumer.SubscribeTopics([]string{"public-chats"}, nil)

	if err != nil{
		log.Fatalf("Failed to subsribe to topic: %v", err)
	}

	log.Println("Listening to messges on 'public-chats' topic...")

	for{
		msg, err := consumer.ReadMessage(-1)

		if err == nil{
			fmt.Printf("Recieved message: %s\n", string(msg.Value))
		}else{
			log.Printf("Consumer error: %v (%v)\n", err, msg)
		}
	}

}