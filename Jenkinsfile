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
        sh 'apk update && apk upgrade && apk add git && apk add openssh-client'
        sh 'mkdir ~/.ssh'
        sh 'ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts'
        // sh  '''
        //     git config user.email "${GIT_USER_EMAIL}";
        //     git config user.name "${GIT_USERNAME}";
        //     '''
      }
    }

    // stage('Setup') {
    //   steps {
    //     sh 'yarn global add lerna'
    //     sh 'apk add git'
    //     sh  '''
    //           git config user.email "${GIT_USER_EMAIL}";
    //           git config user.name "${GIT_USERNAME}";
    //         '''
    //   }
    // }

    stage('Test') {
      parallel {
        stage('Libraries') {
          steps {
            sh '''ls -la;
lerna run test --scope=@snapperfish/package-library-*;'''
          }
        }
        stage('Sites') {
          steps {
            sh 'lerna run test --scope=@snapperfish/package-site-*'
          }
        }
      }
    }

    stage('Publish libraries') {
      steps {
        sshagent(credentials: ['jenkins']) {
          sh 'lerna publish --conventional-commits --yes'
        }
      }
    }
  }
  environment {
    GIT_USERNAME = 'chrisslater'
    GIT_USER_EMAIL = 'chris@snapper.fish'
    NPM_CONFIG_EMAIL = 'chris@snapper.fish'
    NPM_CONFIG_USERNAME = 'snapperfish'
    NPM_TOKEN = credentials('npm-token')
  }
}