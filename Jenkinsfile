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
        sh '''git config user.email "${GIT_USER_EMAIL}"
git config user.name "${GIT_USERNAME}"
'''
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

    stage('Build libraries') {
      steps {
        sshagent(['ce0576ce-cff6-450c-998f-a195f91bc14a']) {
          sh("lerna publish --conventional-commits --yes")
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