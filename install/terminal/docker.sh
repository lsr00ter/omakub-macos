brew install orbstack

# Limit log size to avoid running out of disk
# echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json
