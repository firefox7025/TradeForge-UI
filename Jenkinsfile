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
          sh 'cp Dockerfile /workspace/opt/app/shared/Dockerfile'
        }
      }
    }
    stage('Release') {
      steps {
        container('kaniko') {
          sh 'cp /workspace/opt/app/shared/Dockerfile /workspace'
          sh 'ulimit -n 10000'
          sh '/kaniko/executor -f Dockerfile --destination=https://docker.ultimaengineering.io/repository/docker/TradeForge-UI:${BRANCH_NAME}-${BUILD_NUMBER}'
        }
      }
    }
  }
}
