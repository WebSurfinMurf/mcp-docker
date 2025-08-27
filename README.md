# Docker MCP Gateway Setup

## Overview
Docker's official MCP (Model Context Protocol) gateway for Claude Code integration.

## Installation Status
✅ **Installed Components:**
- Docker MCP Gateway image: `mcp/docker:latest` (pulled from Docker Hub)
- Configuration directory: `~/.docker/mcp/`
- Claude Code MCP settings: `~/.config/claude/mcp-settings.json`

## Directory Structure
```
/home/administrator/projects/mcp-docker/
├── README.md                 # This file
├── docker-mcp.sh            # CLI wrapper script
├── run-mcp-gateway.sh       # Gateway runner script
├── test-mcp.sh              # Test script
└── (cloned repo files)      # Docker MCP Gateway source
```

## Configuration

### Claude Code Integration
The MCP gateway is configured in: `~/.config/claude/mcp-settings.json`

```json
{
  "mcpServers": {
    "docker-gateway": {
      "command": "docker",
      "args": ["run", "--rm", "-i", "-v", "/var/run/docker.sock:/var/run/docker.sock", ...],
      "env": {"DOCKER_HOST": "unix:///var/run/docker.sock"}
    }
  }
}
```

## Usage

### Run MCP Gateway
```bash
./docker-mcp.sh gateway run
```

### Available MCP Servers on Docker Hub
- `mcp/docker` - Docker MCP Gateway (installed)
- `mcp/github-mcp-server` - GitHub integration
- `mcp/postgres` - PostgreSQL access
- `mcp/playwright` - Browser automation
- `mcp/notion` - Notion integration
- `mcp/grafana` - Grafana monitoring

### Adding More MCP Servers
Pull additional servers from Docker Hub:
```bash
docker pull mcp/github-mcp-server
docker pull mcp/postgres
```

## Testing
Run the test script:
```bash
./test-mcp.sh
```

## Integration with Claude Code
1. Restart Claude Code after configuration changes
2. The MCP gateway will be available as "docker-gateway"
3. Claude can now interact with Docker containers through MCP

## Notes
- The `mcp/docker` image is Docker's official MCP implementation
- It provides secure, containerized access to Docker operations
- Authentication and secrets are handled through Docker Desktop integration

## Next Steps
1. Configure specific MCP servers you want to use
2. Set up authentication for services that require it
3. Test the integration with Claude Code

---
*Setup completed: 2025-08-27*