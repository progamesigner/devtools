# devtools

Built on [progamesigner/devcontainers](https://github.com/progamesigner/devcontainers).

## With Docker

- Container's Network Namespace

    `docker run -it --net container:<container_name> progamesigner/devtools`

- Host's Network Namespace

    `docker run -it --net host progamesigner/devtools`

## With Docker Compose

```yaml
version: '3.6'
services:
  tcpdump:
    image: progamesigner/devtools
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

    `kubectl debug -it --image=progamesigner/devtools --target=<pod>`

 - Use pod

    `kubectl run debug --rm -it --image=progamesigner/devtools`

 - Use pod with host network

    `kubectl run debug --rm -it --overrides='{"spec": {"hostNetwork": true}}' --image=progamesigner/devtools`

 - Use sidecar container
