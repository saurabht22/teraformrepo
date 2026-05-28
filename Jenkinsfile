pipeline {

    agent any

    environment {

        ARM_CLIENT_ID       = credentials('azure-client-id')
        ARM_CLIENT_SECRET   = credentials('azure-client-secret')

        ARM_SUBSCRIPTION_ID = '8e1e8f8b-6b2b-44d1-8631-36f28c594fa3'
        ARM_TENANT_ID       = 'f335b54a-fbbe-4b6f-9069-ba6f8db5bf85'
    }

    stages {

        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/saurabht22/teraformrepo.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Format') {
            steps {
                sh 'terraform fmt'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {

                input message: 'Approve Deployment?'

                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
}
