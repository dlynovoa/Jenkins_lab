pipeline {
    agent any

    environment {
        APP_NAME  = 'Jenkins-Lab'
        HOST_PORT = '8081'
    }

    stages {
        stage('Checkout & Setup') {
            steps {
                echo "=== Preparando entorno para ${env.APP_NAME} ==="
                sh 'chmod +x test/*.sh 2>/dev/null || true'
            }
        }

        stage('Test') {
            steps {
                echo '=== Ejecutando Pruebas de Integridad ==='
                sh './test/run-tests.sh'
            }
        }

        stage('Build & Deploy') {
            steps {
                echo "=== Construyendo imagen y desplegando en puerto ${env.HOST_PORT} ==="
                sh 'docker compose up -d --build'
            }
        }

        stage('Health Check') {
            steps {
                echo '=== Verificando disponibilidad HTTP ==='
                sh 'sleep 2'
                sh "curl -f -I http://localhost:${env.HOST_PORT}"
            }
        }
    }

    post {
        always {
            sh 'docker image prune -f || true'
        }
        success {
            echo "¡Despliegue exitoso! Disponible en http://192.168.33.20:${env.HOST_PORT}"
        }
        failure {
            echo 'El pipeline fallo. Se aborto el despliegue.'
        }
    }
}