#!/bin/bash
# MCP Docker Server Wrapper with Named Container

# Clean up any existing container with the same name
docker stop mcp-docker-gateway 2>/dev/null || true
docker rm mcp-docker-gateway 2>/dev/null || true

# Run the MCP Docker gateway with a consistent name
exec docker run --rm -i \
  --name mcp-docker-gateway \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /home/administrator/.docker/mcp:/root/.docker/mcp \
  --network host \
  mcp/docker:latest