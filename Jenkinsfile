pipeline {
  agent {
    kubernetes {
      yamlFile 'KubernetesBuilder.yaml'
    }
  }
  stages {
    stage('Build') {
      steps {
        checkout scm
        container('java-builder') {
          sh './gradlew clean build'
        }
      }
    }
    stage('sast scan') {
      steps {
        checkout scm
        container('java-builder') {
          sh 'echo will be where the scan is'
        }
      }
    }
    stage('Copy Artifacts') {
      steps {
        container('builder') {
          sh 'cp build/libs/sast-demo-0.0.1-SNAPSHOT.jar /workspace/opt/app/shared/sast-demo.jar'
          sh 'cp Dockerfile /workspace/opt/app/shared/Dockerfile'
        }
      }
    }
    stage('Release') {
      steps {
        container('kaniko') {
          sh 'cp /workspace/opt/app/shared/sast-demo.jar  /workspace'
          sh 'cp /workspace/opt/app/shared/Dockerfile /workspace'
          sh 'ulimit -n 10000'
          sh '/kaniko/executor -f Dockerfile --destination=docker.ultimaengineering.io/sast-demo.jar:${BRANCH_NAME}-${BUILD_NUMBER}'
        }
      }
    }
  }
}