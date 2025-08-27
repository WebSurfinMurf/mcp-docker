#!/bin/bash
# Test Docker MCP Gateway

echo "Testing Docker MCP Gateway..."
echo "================================"

# Test 1: Run gateway and check if it responds
echo -e "\n1. Testing gateway response..."
echo '{"jsonrpc":"2.0","method":"initialize","params":{"protocolVersion":"1.0.0","capabilities":{},"clientInfo":{"name":"test","version":"1.0.0"}},"id":1}' | \
docker run --rm -i \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$HOME/.docker/mcp:/root/.docker/mcp" \
    mcp/docker:latest 2>/dev/null

echo -e "\n================================"
echo "Test complete!"