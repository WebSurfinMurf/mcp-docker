#!/bin/bash
# Docker MCP Gateway runner script

# Create config directory if it doesn't exist
MCP_CONFIG_DIR="$HOME/.docker/mcp"
mkdir -p "$MCP_CONFIG_DIR"

# Run the Docker MCP gateway
echo "Starting Docker MCP Gateway..."
echo "Configuration directory: $MCP_CONFIG_DIR"

docker run --rm -it \
  --name mcp-gateway \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$MCP_CONFIG_DIR:/config" \
  -e DOCKER_HOST=unix:///var/run/docker.sock \
  mcp/docker:latest "$@"