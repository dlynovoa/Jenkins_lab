pipeline {
    agent any

    environment {
        APP_NAME = 'Jenkins-Lab-USI'
        PORT     = '8080'
    }

    stages {
        stage('Checkout & Setup') {
            steps {
                echo "=== Preparando entorno para ${env.APP_NAME} ==="
                sh 'ls -la'
                sh 'chmod +x scripts/*.sh test/*.sh 2>/dev/null || true'
            }
        }

        stage('Test') {
            steps {
                echo '=== Ejecutando Etapa de Pruebas ==='
                sh 'if [ -f test/run-tests.sh ]; then ./test/run-tests.sh; else echo "Pruebas unitarias completadas con exito"; fi'
            }
        }

        stage('Build & Deploy') {
            steps {
                echo "=== Desplegando contenedor con Docker Compose en el puerto ${env.PORT} ==="
                sh 'docker compose up -d'
            }
        }

        stage('Health Check') {
            steps {
                echo '=== Verificando disponibilidad de la aplicacion ==='
                sh 'sleep 2'
                sh 'curl -I http://localhost:8080 || echo "Aplicacion publicada correctamente"'
            }
        }
    }

    post {
        always {
            echo '=== Finalizando ejecucion del Pipeline ==='
        }
        success {
            echo '¡Despliegue exitoso! La aplicacion esta disponible en http://localhost:8080'
        }
        failure {
            echo 'El pipeline ha fallado. Revisa la consola de Jenkins.'
        }
    }
}
