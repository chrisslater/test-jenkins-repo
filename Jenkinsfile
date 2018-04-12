pipeline {
  agent {
    docker {
      image 'node:6-alpine'
      args '-p 3000:3000'
    }

  }
  stages {
    stage('build') {
      steps {
        sh '''yarn global add lerna;
yarn;'''
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