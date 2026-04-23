Build sonarqube project and generate token (saves locally for now)
bash sonarqube/create-project.sh

Steps:

Open SonarQube
docker compose up -d sonarqube

Find it in: http://localhost:9000

Login using admin:admin and change password

Create a SQ project:
Projects -> create local -> name it and its key 

Create a user token and name it, save this token in a .env file in root

Build Jenkins after making the token file
docker compose up -d jenkins

Find it in: http://localhost:8085

You should see the SQ server linked automatically due to the code setup

Can now run jenkins and see the SQ stuff on the SQ side

With the script: bash sonarqube/create-project.sh
can skip the SonarQube steps and go straight to rebuilding jenkins after the token was made