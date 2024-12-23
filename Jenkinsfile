pipeline {
  agent {
    kubernetes {
      yamlFile 'KubernetesBuilder.yaml'
    }
  }
  stages {
    stage('Copy Artifacts') {
      steps {
        container('builder') {
          sh 'cp -r * /workspace/opt/app/shared/'
        }
      }
    }
    stage('Release') {
      steps {
        container('kaniko') {
          sh 'cp -r /workspace/opt/app/shared/* /workspace'
          sh 'ulimit -n 10000'
          sh '/kaniko/executor -f Dockerfile --destination=docker.ultimaengineering.io/tradeforgeui:${BRANCH_NAME}-${BUILD_NUMBER}'
        }
      }
    }
  }
}
