
## Prerequisites
- Install [docker](https://docs.docker.com/engine/install/)
- Install [python3](https://www.python.org/downloads/)

## CI Build
- Navigate to the repository, `https://github.com/FaithKovi/appsilon-task` and fork the project.
- Navigate to `https://github.com/${your_github_username}/appsilon-project/settings/secrets/actions`.
    - Create a secret named `CONTAINER_PASSWORD` with value as your github token.

> Ensure your repository settings have the appropraite permissions
> Navigate to `https://github.com/${your_github_username}/appsilon-task/settings/actions`
>   - In the **Workflow permissions** section, select  *read and write access for all scopes*. (See [Documentation](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository))

## Locally build your docker image
- Clone the forked application repository
```
git clone https://github.com/${your_github_username}/appsilon-task.git
```
- Navigate to the directory containing the Dockerfile for the application
```
$ cd appsilon-task/app
```
- Locally build the docker image for linux
```
$ docker build --platform linux/amd64 -t flask-app .
```
- Run the newly built docker image
```
$ docker run --name app -p 5000:5000 appsilon
```
- Navigate to your browser and enter `localhost:5000` or `127.0.0.1:5000` to see the running container application

