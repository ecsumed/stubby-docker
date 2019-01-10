
1. Build
    docker build -t stubby .

2. Run
    docker run -dit stubby

3. Update `/etc/resolv.conf` to list nameserver IP

Stubby config uses the Google DNS over TLS resolver.
