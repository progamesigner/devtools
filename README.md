# devtools

## With Docker

- Container's Network Namespace

    `docker run -it --net container:<container_name> ghcr.io/progamesigner/devtools`

- Host's Network Namespace

    `docker run -it --net host ghcr.io/progamesigner/devtools`

## With Docker Compose

```yaml
version: '3.6'
services:
  tcpdump:
    image: ghcr.io/progamesigner/devtools
    depends_on:
    - nginx
    command: tcpdump -i eth0 -w /data/nginx.pcap
    network_mode: service:nginx
    volumes:
    - $PWD/data:/data

  nginx:
    image: nginx:alpine
    ports:
    - 80:80
```

## With Kubernetes

 - Use [ephemeral container](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/#ephemeral-container-example)

    `kubectl debug -it --image=ghcr.io/progamesigner/devtools --target=<pod>`

 - Use pod

    `kubectl run debug --rm -it --image=ghcr.io/progamesigner/devtools`

 - Use pod with host network

    `kubectl run debug --rm -it --overrides='{"spec": {"hostNetwork": true}}' --image=ghcr.io/progamesigner/devtools`

 - Use sidecar container

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: devtools
  name: devtools
spec:
  replicas: 1
  selector:
    matchLabels:
      app: devtools
  template:
    metadata:
      labels:
        app: devtools
    spec:
      containers:
      - name: nginx
        image: nginx:stable
        ports:
        - name: http
          containerPort: 80
        - name: https
          containerPort: 443
      - name: devtools
        image: ghcr.io/progamesigner/devtools:latest
        command:
        - sh
        - -c
        - while true; do ping localhost; sleep 60; done
```

 - Use pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: devtools
  name: devtools
spec:
  containers:
  - name: devtools
    image: ghcr.io/progamesigner/devtools:latest
    command:
    - sh
    - -c
    - while true; do ping localhost; sleep 60; done
```
