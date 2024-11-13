package handlers

import (
	"fmt"
	"go-microservice/models"

	// "github.com/gin-gonic/gin"
)

func Run() {
	prompt := models.Message{
		Sender: "jfkjda",
		Content: "fjkadsjfk",
	}

	fmt.Println(prompt)
}
