
all: clean build run

build:
	@podman build -t sshd -f ./sshd.Dockerfile

run:
	@podman run -it -d --rm -p 127.0.0.1:2221:22 --name sshd sshd

clean:
	@-podman container rm -f sshd

prune:
	@-podman image rm -f sshd
