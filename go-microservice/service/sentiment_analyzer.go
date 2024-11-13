package service

import (
	"context"
	"log"
	"os"

	"github.com/google/generative-ai-go/genai"
	"google.golang.org/api/option"
)

func InitializeGenAIClient() (*genai.Client, error){
	ctx := context.Background();

	client, err := genai.NewClient(ctx, option.WithAPIKey(os.Getenv("GEMINI_API_KEY")))

	if err != nil{
		return nil, err
	}

	return client, nil
}

func GetSentimentAnalysis(message string)(string, error){
	client, err := InitializeGenAIClient()

	if err != nil{
		log.Fatal("Failed to initialize Genai Client:", err)
	}
	defer client.Close()

	model := client.GenerativeModel("gemini-1.5-flash")
	model.SetTemperature(0.9)
	model.SetTopP(0.5)
	model.SetTopK(20)
	model.SetMaxOutputTokens(100)
	model.SystemInstruction = genai.NewUserContent(genai.Text("You are working for a emotion aware chatting application, you will be streamed messages constantly, you have to detect the mood of the conversation and return the sentiment analysis of it. The types of mood can be, positive, negative and nuetral"))
	model.ResponseMIMEType = "application/json"

	resp, err := model.GenerateContent(context.Background(), genai.Text(message))

	if err != nil{
		log.Println(err)

		return "", err
	}

	log.Println(resp.Candidates[0].Content)

	return "Successful", nil
}