# coolOps.io's Googke Kubernetes Engine deployment image

This deployment image sets a new docker image to a Kubernetes Deployment on the Google Kubernetes Engine.

Here are the environment variables needed by the container:

| Environment Variable | Explanation | 
|----------------------|-------------|
| DOCKER_IMAGE         | The image to be set on the Deployment |
| GCLOUD_KEY_JSON        | A base64-encoded string representation of the JSON key of your Google Cloud service account |
| GCLOUD_PROJECT_ID      | The Google Cloud project ID that your Kubernetes cluster lives |
| GCLOUD_COMPUTE_ZONE    | The compute zone of your Kubernetes cluster |
| GCLOUD_CLUSTER_NAME    | The name of your Kubernetes cluster on Google Cloud |
| KUBERNETES_DEPLOYMENTS | A comma separated list of deployments to be updated |
| KUBERNETES_NAMESPACE   | The namespace of the deployments on the Kubernetes cluster |

\* Usually the `DOCKER_IMAGE` is passed together with each `Build` and all the other variables are set on the `Environment`
