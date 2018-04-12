pipeline {
  agent {
    docker {
      image 'node:6-alpine'
      args '-p 3000:3000'
    }

  }
  stages {
    stage('Setup Environment') {
      parallel {
        stage('Setup Environment') {
          steps {
            sh '''yarn global add lerna;
'''
          }
        }
        stage('Install') {
          steps {
            sh 'yarn'
          }
        }
      }
    }
    stage('Checkout') {
      steps {
        dir(path: 'packages/package-a') {
          sh 'yarn build'
        }

      }
    }
  }
}