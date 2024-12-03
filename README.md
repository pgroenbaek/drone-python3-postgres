# drone-python3-postgres
This [Drone CI](https://drone.io/) plugin allows you to use `python` and `pip` in pipelines along with PostgreSQL utilities such as `psql` and `pg_dump`.


## Usage

The following example shows how to configure a pipeline step to use the plugin from Docker Hub:

```yaml
kind: pipeline
name: check version

steps:
  - name: versions
    image: pgroenbaek/drone-python3-postgres
    commands:
      - python --version
      - pip --version
      - psql --version
      - pg_dump --version

```

### Using a private container registry

If you would rather use the plugin from a private container registry, clone this repository, then build and push the created docker image to your private registry:

```bash
docker login -u <USERNAME> <REGISTRY_URL>
docker build -t <TAGNAME> .
docker tag <TAGNAME> <REGISTRY_URL>/drone-python3-postgres
docker push <REGISTRY_URL>/drone-python3-postgres
```

Replace the `<USERNAME>`, `<TAGNAME>` and `<REGISTRY_URL>` parameters accordingly.

Now you can use the docker image you built as a drone plugin:

```yaml
kind: pipeline
name: check version

steps:
  - name: versions
    image: <REGISTRY_URL>/drone-python3-postgres:<TAGNAME>
    commands:
      - python --version
      - pip --version
      - psql --version
      - pg_dump --version

image_pull_secrets:
- docker_config_json
```

Note the `image_pull_secrets` parameter at the bottom.

For Drone CI to know how to authenticate with your private container registry a secret named `docker_config_json` must be defined for the pipeline.

Add the following as a secret named `docker_config_json`:

```json
{"auths": {"<REGISTRY_URL>": {"auth": "<PASSWORD>"}}}
```
Replace the `<REGISTRY_URL>` and `<PASSWORD>` parameters with your values.

## License

This drone plugin was created by Peter Grønbæk Andersen and is licensed under [GNU GPL v3](./LICENSE).
