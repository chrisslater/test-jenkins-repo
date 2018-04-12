pipeline {
  agent {
    docker {
      image 'node:6-alpine'
      args '-p 3000:3000'
    }

  }
  stages {
    stage('Install') {
      steps {
        sh 'yarn && yarn global add lerna'
        sh 'apk update && apk upgrade && apk add git'
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
    stage('Build libraries') {
      steps {
        sh '''git status
lerna updated --scope=package-library-*;
lerna publish --conventional-commits --yes;'''
      }
    }
  }
}