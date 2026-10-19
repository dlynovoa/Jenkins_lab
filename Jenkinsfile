pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Iniciando compilacion de dependencias...'
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo 'Ejecutando pruebas automatizadas...'
                sh './jenkins/scripts/test.sh'
            }
        }

        stage('Deliver') {
            steps {
                echo 'Desplegando aplicacion web...'
                sh './jenkins/scripts/deliver.sh'

                input message: '¿Finalizar revision de la aplicacion y detener proceso?'

                sh './jenkins/scripts/kill.sh'
            }
        }
    }
}
