#!groovy
def dockerRegistry = 'amr-registry.caas.intel.com'
def containerImage = "${dockerRegistry}/owr/ex-httpd:latest"
def kubectlpodDefinitionYaml = """
kind: Pod
apiVersion: v1
spec:
  containers:
  - name: jnlp
    image: ${dockerRegistry}/owr/jnlp-slave:latest
    tty: true
    imagePullPolicy: Always
  - name: kubectl
    image:  amr-registry-pre.caas.intel.com/pse-pswe-software-ba/k8s-kubectl:latest
    tty: true
    imagePullPolicy: Always
    command:
    - /bin/sh
    args:
    - -c
    - cat
"""

pipeline {

  agent none

  stages {
    stage('Re-deploy') {
      agent {
        kubernetes {
          cloud "rancher_kubernetes"
          label "ex-kubectl-${UUID.randomUUID().toString()}"
          yaml kubectlpodDefinitionYaml
        }
      }
      steps {
        container("kubectl"){
          checkout scm
          withCredentials([file(credentialsId: 'amr.kubeconfig.testing', variable: 'kubeconfig')]) {
            sh """
              kubectl --kubeconfig=${kubeconfig} --namespace=default apply -f deployment.yml
              """  
        }
      }
    }
  }
  }
}
