# Claude AI Assistant Notes - Docker MCP Gateway

> **For overall environment context, see: `/home/administrator/AINotes/AINotes.md`**

## Project Overview
Docker's official Model Context Protocol (MCP) gateway implementation, providing secure containerized access to Docker operations for Claude Code and other AI assistants.

## Recent Work & Changes

### Session: 2025-08-27
- Migrated from `/home/websurfinmurf/projects/mcpdocker` to `/home/administrator/projects/mcp-docker`
- Removed old MCP artifacts:
  - Stopped and removed `mcp-filesystem-server` container
  - Removed Docker images: `local/mcp-client`, `websurfinmurf/postgres-mcp`, `crystaldba/postgres-mcp`, `mcp/filesystem`
- Installed Docker's official MCP gateway from Docker Hub (`mcp/docker:latest`)
- Created wrapper scripts for easy usage
- Configured Claude Code integration in `~/.config/claude/mcp-settings.json`
- Followed naming convention: `mcp-{service}` for project directory
- **Repository Fix**: Recreated as clean repository without upstream history to avoid GitHub push protection issues
  - Removed problematic test files containing example secrets
  - Fresh git repository with only deployment scripts and documentation

## Architecture

```
Claude Code → MCP Gateway → Docker Containers
     ↓            ↓              ↓
  AI Client   Protocol      Isolated
             Translation    Execution
```

## Configuration Files

### Claude Code MCP Settings
**Location**: `~/.config/claude/mcp-settings.json`
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

### MCP Configuration Directory
**Location**: `~/.docker/mcp/`
- Stores gateway configuration
- Server registrations
- Tool definitions

## Available Scripts

### docker-mcp.sh
CLI wrapper that provides `docker mcp` functionality using the Docker Hub image.
```bash
./docker-mcp.sh gateway run        # Run gateway
./docker-mcp.sh --help             # Show options
```

### run-mcp-gateway.sh
Simple gateway runner with proper volume mounts and Docker socket access.
```bash
./run-mcp-gateway.sh
```

### test-mcp.sh
Test script to verify MCP gateway functionality.
```bash
./test-mcp.sh
```

## Docker Hub MCP Servers

### Currently Installed
- `mcp/docker:latest` - Docker MCP Gateway (43 stars)

### Available for Installation
```bash
# GitHub integration (47 stars)
docker pull mcp/github-mcp-server

# PostgreSQL access (26 stars)
docker pull mcp/postgres

# Grafana monitoring (16 stars)
docker pull mcp/grafana

# Browser automation (21 stars)
docker pull mcp/playwright

# Notion integration (28 stars)
docker pull mcp/notion
```

## Security Features
- Container isolation for all operations
- Read-only bind mounts where appropriate
- Docker socket access controlled
- No privileged operations allowed
- Resource limits enforced

## Integration with Infrastructure

### Docker Access
- Full access to Docker daemon via socket mount
- Can manage all containers in the infrastructure
- Provides safe execution environment for AI operations

### Compatible Services
Works with all containerized services:
- GitLab
- Keycloak
- Open-WebUI
- PostgreSQL databases
- Monitoring tools (Prometheus, Grafana)

## Common Commands

```bash
# Check Docker MCP image
docker images | grep mcp

# View running MCP containers
docker ps | grep mcp

# Test gateway connection
echo '{"jsonrpc":"2.0","method":"initialize","params":{"protocolVersion":"1.0.0"},"id":1}' | \
  docker run --rm -i -v /var/run/docker.sock:/var/run/docker.sock mcp/docker:latest

# View logs if running as daemon
docker logs mcp-gateway
```

## Troubleshooting

### Gateway Not Responding
1. Check Docker daemon is running: `docker ps`
2. Verify socket permissions: `ls -la /var/run/docker.sock`
3. Ensure image is pulled: `docker images | grep mcp/docker`

### Claude Code Not Detecting MCP
1. Restart Claude Code after configuration
2. Check config file: `cat ~/.config/claude/mcp-settings.json`
3. Verify JSON syntax is correct

### Permission Denied Errors
```bash
# Ensure user is in docker group
groups | grep docker

# Add if needed (requires logout/login)
sudo usermod -aG docker $USER
```

## Best Practices
1. Use official MCP servers from Docker Hub when available
2. Follow `mcp-{service}` naming convention for projects
3. Keep MCP gateway updated: `docker pull mcp/docker:latest`
4. Regular cleanup of unused MCP containers
5. Document any custom MCP server configurations

## Future Enhancements
- [ ] Add PostgreSQL MCP for database operations
- [ ] Integrate GitHub MCP for repository management
- [ ] Set up Grafana MCP for monitoring access
- [ ] Configure secrets management for API keys
- [ ] Create custom MCP servers for specific needs

## Resources
- [Docker MCP Catalog](https://hub.docker.com/mcp)
- [MCP Specification](https://spec.modelcontextprotocol.io/)
- [Docker MCP Documentation](https://docs.docker.com/ai/mcp-catalog-and-toolkit/)
- [GitHub Repository](https://github.com/docker/mcp-gateway)

---
*Last Updated: 2025-08-27*
*Project Owner: administrator*
*Location: /home/administrator/projects/mcp-docker*