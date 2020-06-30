## TODO Application Nodejs App

1. Github actions is used in building the image and pushing to ECR 
2. Dockerfile and Docker-compose is created for the nodejs. Docker-compose was used in testing the app and mongodb before migrating to Github Actions 
3. Nodemon is installed as part of the dependency for running the app 
4. The nodejs app contains a bug which was preventing from starting up.. It was fixed  
5. The github action yaml file can be found by navigating to `.github/workflows/nodejs.yaml`
6. nodejs-app.yml is running on github actions. It executes commands in the Dockefile and pushes the image to Dockerhub 
7. I am using a feature in github Actions called `setup-node` to determine the node version. The setup-node action takes a Node.js version as an input and configures that version on the runner. 
8. setup-node contains template. The template includes a matrix strategy that builds and tests your code with three Node.js versions: 8.x, 10.x, and 12.x.. The nodejs was developed using 4 nodejs version 8.x, 10.x, 12.x, 13.x.
9. The dependencies were found in package.json file and npm install was runned against package.json file to install and upgrade all the dependencies.
10. nodemon and Babel package was installed as well because the app was written with es6. Babel configuration is added to package.json. 
11. The startup script was configured on the package.json file 
12. MongoDB replicaset was also configured on Github Actions.
13. The envirooment variables are configured in the Dockerfile such as app port, mongodb connection strings

