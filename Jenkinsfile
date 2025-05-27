pipeline {
    agent any

    environment {
        PROJECT_DIR = 'springboot-backend'
        IMAGE_NAME = 'rishichirchi/devops-springboot-backend'
        IMAGE_TAG = 'latest'
        DEPLOYMENT_FILE = "${PROJECT_DIR}/k8s-deployment.yaml"
    }

    stages {
        // stage('Build JAR') {
        //     steps {
        //         echo '🔨 Building Spring Boot JAR...'
        //         dir("${env.PROJECT_DIR}") {
        //             sh './mvnw clean package -DskipTests'
        //         }
        //     }
        // }

        // stage('Build Docker Image') {
        //     steps {
        //         echo '🐳 Building Docker image...'
        //         sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ${env.PROJECT_DIR}"
        //     }
        // }

        // stage('Push to Docker Hub') {
        //     steps {
        //         withCredentials([usernamePassword(
        //             credentialsId: 'dockerhub-creds',
        //             usernameVariable: 'DOCKER_USER',
        //             passwordVariable: 'DOCKER_PASS'
        //         )]) {
        //             echo '🚀 Logging in and pushing to Docker Hub...'
        //             sh '''
        //                 echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
        //                 docker push $IMAGE_NAME:$IMAGE_TAG
        //                 docker logout
        //             '''
        //         }
        //     }
        // }

        // stage('Start Minikube') {
        //     steps {
        //         echo '⚙️ Starting Minikube...'
        //         sh 'minikube start || echo "Already running"'
        //     }
        // }

        stage('Deploy to Kubernetes') {
            steps {
                echo '🚀 Deploying to Minikube...'
                sh "kubectl apply -f $DEPLOYMENT_FILE"
            }
        }

        stage('Show App URL') {
            steps {
                echo '🌐 App available at:'
                sh 'kubectl get svc -n default'
            }
        }
    }
}
