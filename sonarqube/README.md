Build sonarqube project and generate token
bash sonarqube/create-project.sh

Steps:

Open SonarQube
docker compose up -d sonarqube

Find it in: http://localhost:9000

Login using admin:admin and change password

Create a SQ project:
Projects -> create local -> name it and its key 

Create a user token and name it, save this token in a .env file in root

OR

Can also skip these steps using script:
bash sonarqube/create-project.sh

Jenkins setup is in the main Readme file,
may need to restart Jenkins after generating a token
