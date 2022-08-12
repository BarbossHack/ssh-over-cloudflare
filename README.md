# SSH over Cloudflare

Chisel allows you to connect to your SSH server hrough HTTP reverse proxies like Cloudflare.

This is a demo script using Chisel and Cloudflared.

## Server

> Could be on the same host than client for testing purpose

```bash
# Install Chisel, cloudflared, and podman
sudo dnf install -y chisel cloudflared podman
# Start simple SSH server (target SSH server you want to connect to)
git clone https://github.com/BarbossHack/chisel-cloudflare-demo && \
    cd chisel-cloudflare-demo && \
    make
# See https://github.com/lucas-clemente/quic-go/wiki/UDP-Receive-Buffer-Size for details.
sudo sysctl -w net.core.rmem_max=2500000
# Start a Cloudflare Quick Tunnel, to get a real world Cloudflare reverse proxy to test Chisel
# You will get this reverse proxy URL: https://RANDOM-GENERATED.trycloudflare.com
cloudflared --no-autoupdate --http2-origin tunnel
# Start Chisel server
chisel server --host 127.0.0.1 --port 8080
```

## Client

```bash
# Install Chisel
sudo dnf install -y chisel
# You need MTU of 1200 on your internet interface for SSH
# (see https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1874257)
sudo ip li set mtu 1200 dev YOUR_INTERFACE
# Connect to the SSH server through Cloudflare Quick Tunnel and Chisel server (password is 'toor')
ssh -o ProxyCommand='chisel client https://RANDOM-GENERATED.trycloudflare.com stdio:127.0.0.1:2221' root@example.com
# Or try to download a "big" file
scp -o ProxyCommand='chisel client -v https://RANDOM-GENERATED.trycloudflare.com stdio:127.0.0.1:2221' root@example.com:/root/10M.file .
```
