#!/bin/bash
# Docker MCP CLI wrapper
# This script provides 'docker mcp' functionality using the Docker Hub image

MCP_CONFIG_DIR="${MCP_CONFIG_DIR:-$HOME/.docker/mcp}"
mkdir -p "$MCP_CONFIG_DIR"

# Function to run MCP commands via Docker
run_mcp() {
    docker run --rm -i \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v "$MCP_CONFIG_DIR:/root/.docker/mcp" \
        -v "$HOME/.docker:/root/.docker:ro" \
        --network host \
        mcp/docker:latest "$@"
}

# Handle special cases
case "$1" in
    gateway)
        if [ "$2" = "run" ]; then
            # Interactive gateway mode
            docker run --rm -it \
                -v /var/run/docker.sock:/var/run/docker.sock \
                -v "$MCP_CONFIG_DIR:/root/.docker/mcp" \
                -v "$HOME/.docker:/root/.docker:ro" \
                --network host \
                mcp/docker:latest "$@"
        else
            run_mcp "$@"
        fi
        ;;
    *)
        run_mcp "$@"
        ;;
esac