
all: clean build run

build:
	@podman build -t nginx -f ./nginx.Dockerfile
	@podman build -t sshd -f ./sshd.Dockerfile

run:
	@podman run -it -d --rm -p 127.0.0.1:8081:80 --name nginx nginx
	@podman run -it -d --rm -p 127.0.0.1:2221:22 --name sshd sshd

clean:
	@-podman container rm -f nginx
	@-podman container rm -f sshd

prune:
	@-podman image rm -f nginx
	@-podman image rm -f sshd
