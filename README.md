# Hashicorp Package

A wrapper container for [Hashicorp Packer](https://www.packer.io/) with no extra logic. The **official release registry** is [here](https://github.com/orgs/GrooveCommunity/packages/container/package/packer).

Through [GitHub Environments](https://docs.github.com/en/actions/reference/environments) we control our release channels as described below:

- Environment **"Unstable"** used to approve releases for `latest` and `unstable` container image (and push to **official release registry**)
  - :rocket: **Deployment reviewers:**
    - [@cloyol1](https://github.com/cloyol1)
    - [@codermarcos](https://github.com/cloyol1)
    - [@vflopes](https://github.com/cloyol1)


----------

**Table of Contents:**

- [Hashicorp Package](#hashicorp-package)
	- [As a GitHub Actions step](#as-a-github-actions-step)
	- [As a local installation replacement](#as-a-local-installation-replacement)
	- [As a Kubernetes Job](#as-a-kubernetes-job)


## As a GitHub Actions step

```yaml
# jobs.*.steps:
- name: Run packer
  uses: docker://ghcr.io/groovecommunity/packer:unstable
  id: packer
  timeout-minutes: 30
  env:
    # AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
    # AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

    # PKR_VAR_source_ref: ${{ github.ref }}
  with:
    args: packer --version
```

## As a local installation replacement

Create a `/usr/local/bin/packer` file:

```bash
#!/bin/bash
docker run --rm -it -v $(pwd):/templates ghcr.io/groovecommunity/packer:latest packer $@
```

Mark file as **executable**:

```bash
chmod +x /usr/local/bin/packer
```

Now you can use `ansible, terraform and terragrunt` like commands from a local installation.

## As a Kubernetes Job

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: packer
spec:
  backoffLimit: 5
  activeDeadlineSeconds: 100
  template:
    spec:
      containers:
      - name: packer
        image: ghcr.io/groovecommunity/packer:latest
        command: ["packer",  "--version"]
      restartPolicy: Never
```