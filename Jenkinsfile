pipeline {
  agent {
    docker {
      image 'node:6-alpine'
      args '-p 3000:3000'
    }

  }
  stages {
    stage('Setup') {
      parallel {
        stage('Environment') {
          steps {
            sh 'yarn global add lerna;'
          }
        }
        stage('Install') {
          steps {
            sh 'yarn'
          }
        }
      }
    }
    stage('Test') {
      parallel {
        stage('Libraries') {
          steps {
            sh '''ls -la;
lerna run test --scope=package-library-*;'''
          }
        }
        stage('Sites') {
          steps {
            sh 'lerna run test --scope=package-site-*'
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