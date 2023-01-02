pipeline {
    agent any

    stages {
        stage('clone git url') {
            steps {
                git 'https://github.com/sreeramakumar/devops-certification-project2.git'
            }
        }
        stage('docker image build and push to docker hub') {
            steps {
                sh "chmod 400 de2.pem"
                sh "sleep 10"
                sh 'ansible all -i inventory.yaml -m ping --private-key=de2.pem -u ec2-user'
                sh 'ansible-playbook -i inventory.yaml --private-key=de2.pem -u ec2-user dockerimagebuild.yaml'
            }
        }
        stage('docker installing on docker server') {
            steps {
                sh "chmod 400 de2.pem"
                sh "sleep 10"
                sh 'ansible all -i inventory2.yaml -m ping --private-key=de2.pem -u ec2-user'
                sh 'ansible-playbook -i inventory2.yaml --private-key=de2.pem -u ec2-user dockerinstall.yaml'
            }
        }
        stage('deploy application on docker server') {
            steps {
                sh 'ansible all -i inventory2.yaml -m ping --private-key=de2.pem -u ec2-user'
                sh 'ansible-playbook -i inventory2.yaml --private-key=de2.pem -u ec2-user deployapplication2.yaml'
            }
        }
        stage('email') {
            steps {
                emailext attachLog: true, attachmentsPattern: '*.csv', body: '''$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:

Check console output at $BUILD_URL to view the results.''', recipientProviders: [buildUser()], subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', to: 'sriramkumar.n@gmail.com'
            }
        }
    }
}
