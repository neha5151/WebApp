pipeline {
    agent any
    environment {
        PROJECT_ID = 'autodeployment:NodeRanchertest'
        CLUSTER_NAME = 'amr-registry-pre.caas.intel.com/pse-pswe-software-ba'
        LOCATION = 'https://amr-pre.caas.intel.com/pse-pswe-software-ba/'
        CREDENTIALS_ID = 'nehashar'
    }
    stages {
        stage("Checkout code") {
            steps {
                checkout scm
            }
        }
        stage("Build image") {
            steps {
                script {
                    myapp = docker.build("nehashar/amr-pre.caas.intel.com/pse-pswe-software-ba/hello:${env.BUILD_ID}")
                }
            }
        }
        stage("Push image") {
            steps {
                script {
                    docker.withRegistry('https://amr-pre.caas.intel.com/pse-pswe-software-ba/', 'dockerhub') {
                            myapp.push("latest")
                            myapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }        
        stage('Deploy to GKE') {
            steps{
                sh "sed -i 's/hello:latest/hello:${env.BUILD_ID}/g' deployment.yaml"
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            }
        }
    }    
}