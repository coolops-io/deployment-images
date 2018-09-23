# coolOps.io deployment images

coolOps.io is a software as a service that integrates any workflow with Slack to give you ChatOps without the need for any coding.

When a deployment is triggered on Slack, coolOps.io will run your deployment image injecting the variables you provide as environment variables to the docker container.

## How does it work?

### 1. You notify about a new build from your CI

Whenever your CI pipeline is completed and you have a new build, you can use our [command line interface](https://github.com/coolopsio/coolops) to notify us about it. Here is the step you can add to your `config.yaml` file if you use CircleCI:

```yml
notify_coolops:
  machine:
    image: circleci/classic:latest
  working_directory: ~/core
  steps:
    - run:
      name: Notify CoolOps.io
      command: |
        curl -L https://github.com/coolopsio/coolops/releases/download/v0.1.0/install.sh | sudo sh
        coolops build:new:circleci -t ${COOLOPS_PROJECT_API_TOKEN} -p DOCKER_TAG=${DOCKER_TAG} -p COMMIT_SHA1=${CIRCLE_SHA1}
```

The two relevant commands are the following:

```bash
curl -L https://github.com/coolopsio/coolops/releases/download/v0.1.0/install.sh | sudo sh
coolops build:new:circleci -t ${COOLOPS_PROJECT_API_TOKEN} -p DOCKER_TAG=${DOCKER_TAG} -p COMMIT_SHA1=${CIRCLE_SHA1}
```

First we download the [command line interface](https://github.com/coolopsio/coolops), then we notify about the new build passing `DOCKER_TAG` and `COMMIT_SHA1` as parameters to the deployment. Whenever a deployment for this build is started on slack, your deployment images will have access to those values as environment variables.

Because we are using the `build:new:circleci` commands, we already define some parameters (like the build name and some metadata) from teh CircleCI environment variable for you. But you also have the option to use your own custom solution by using the `build:new` command.

### 2. We notify you about the build on Slack

As soon as we receive your notification, we will notify the Slack channel you configured for the project.

Here is what the message look like:

![Slack Message](https://user-images.githubusercontent.com/571864/45904945-ec5a3100-bdee-11e8-9521-7b244535ae57.png)


Where `Api` is the name of the project and `master-94657536` is the name of the build. There will be one deployment button per `Environment` that you create for the project (`Production` and `Staging` in this example). `Job url` is a metadata that was passed wit the build. Metadata is only information we will send to Slack, we don't use it for anything else.


### 3. You click on the deployment button

Once you click on the deployment button, we will run your deployment image injecting the variables of button's the `Environment` plus the `Params` that you provided when you notified about the build.

Once we start your deployment, we will update the build message adding one line for each time this build was deployed. The message will look like the following:

![Slack Message](https://user-images.githubusercontent.com/571864/45931608-872e4900-bf70-11e8-8f36-6b1965d23f67.png)

Note that you can see the deployment logs by clicking on the `See logs` url on the message's footer.
