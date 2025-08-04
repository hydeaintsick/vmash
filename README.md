# WinWeb - Windows Remote Desktop Web App

A modern web application that provides access to a Windows Server instance through WebRDP/WebVNC using Apache Guacamole, built with Next.js 15.

## Features

- 🖥️ **Windows 11** running in Docker (x86_64 systems)
- 🐧 **Demo Linux Desktop** for macOS/ARM64 compatibility
- 🌐 **Web-based RDP/VNC** access through Apache Guacamole
- ⚡ **Next.js 15** frontend with modern UI
- 📱 **Responsive design** that works on all devices
- 🔄 **Real-time status monitoring** of connections
- 🐳 **Docker Compose** orchestration for easy deployment

## Prerequisites

- Docker and Docker Compose
- Node.js 18+ and npm
- At least 4GB RAM available for Docker containers

## Quick Start

### 1. Clone and Setup

```bash
# Install Next.js dependencies
npm install

# Start the development server
npm run dev
```

### 2. Start Docker Services

**For macOS/ARM64 (Apple Silicon) - Demo Linux Desktop:**

```bash
# Use the macOS-compatible configuration
docker compose -f docker-compose.mac.yml up -d

# Check container status
docker compose -f docker-compose.mac.yml ps
```

**For Windows 11 (x86_64 systems):**

```bash
# Use the Windows 11 configuration
docker compose -f docker-compose.win11.yml up -d

# Check container status
docker compose -f docker-compose.win11.yml ps
```

**For Linux/Windows Server (x86_64):**

```bash
# Use the standard configuration
docker compose up -d

# Check container status
docker compose ps
```

### 3. Access the Application

- **Frontend**: http://localhost:3000
- **Guacamole Admin**: http://localhost:8080/guacamole
  - Username: `guacadmin`
  - Password: `guacadmin`

## Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Next.js 15    │    │ Apache Guacamole │    │ Windows 11      │
│   Frontend      │◄──►│   Web Gateway   │◄──►│   (RDP/VNC)     │
│   (Port 3000)   │    │   (Port 8080)   │    │   (Port 3389)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                              │
                              ▼
                       ┌─────────────────┐
                       │   PostgreSQL    │
                       │   Database      │
                       │   (Port 5432)   │
                       └─────────────────┘
```

## Docker Services

- **windows-11**: Windows 11 with RDP enabled (x86_64 systems)
- **demo-desktop**: Ubuntu Desktop with VNC (macOS/ARM64)
- **guacamole**: Apache Guacamole web application
- **guacd**: Guacamole daemon for protocol handling
- **postgres**: PostgreSQL database for Guacamole
- **guacamole-init**: Database initialization service

## Configuration

### Connection Settings

**For macOS/ARM64 (Demo Linux Desktop):**

- **Connection Name**: `demo-desktop`
- **Protocol**: `VNC`
- **Password**: `password`
- **Resolution**: `1920x1080`

**For Windows 11 (x86_64 systems):**

- **Connection Name**: `winweb`
- **Protocol**: `RDP`
- **Username**: `Administrator`
- **Password**: `WinWeb2024!`
- **RDP Port**: `3389`
- **Resolution**: `1920x1080`

**For Linux/Windows Server (x86_64):**

- **Username**: `Administrator`
- **Password**: `WinWeb2024!`
- **RDP Port**: `3389`
- **Resolution**: `1920x1080`

### Guacamole Settings

- **Admin Username**: `guacadmin`
- **Admin Password**: `guacadmin`
- **Connection Name**: `winweb`
- **Protocol**: `RDP`

## Development

### Frontend Development

```bash
# Start development server
npm run dev

# Build for production
npm run build

# Start production server
npm start
```

### Docker Management

```bash
# Start all services
docker compose up -d

# Stop all services
docker compose down

# View logs
docker compose logs -f

# Rebuild containers
docker compose up -d --build
```

### Database Management

```bash
# Access PostgreSQL
docker exec -it winweb-postgres psql -U guacamole_user -d guacamole_db

# Backup database
docker exec winweb-postgres pg_dump -U guacamole_user guacamole_db > backup.sql

# Restore database
docker exec -i winweb-postgres psql -U guacamole_user -d guacamole_db < backup.sql
```

## Troubleshooting

### Common Issues

1. **Windows container not starting**

   - Ensure Docker has enough resources (4GB+ RAM)
   - Check Windows container support is enabled

2. **Guacamole connection failed**

   - Verify all containers are running: `docker compose ps`
   - Check logs: `docker compose logs guacamole`

3. **Database connection issues**
   - Wait for postgres to fully start before accessing Guacamole
   - Check database logs: `docker compose logs postgres`

### Port Conflicts

If you have port conflicts, modify the ports in `docker-compose.yml`:

```yaml
ports:
  - "8081:8080" # Change 8080 to 8081
```

### Security Notes

- Default passwords should be changed in production
- Consider using environment variables for sensitive data
- Enable HTTPS in production environments

## Production Deployment

1. **Environment Variables**

   ```bash
   export POSTGRES_PASSWORD=your_secure_password
   export GUACAMOLE_ADMIN_PASSWORD=your_admin_password
   ```

2. **Reverse Proxy**

   - Configure nginx or Apache as reverse proxy
   - Enable SSL/TLS certificates

3. **Monitoring**
   - Set up container health checks
   - Configure log aggregation
   - Monitor resource usage

## License

This project is open source and available under the MIT License.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## Support

For issues and questions:

- Check the troubleshooting section
- Review Docker and Guacamole documentation
- Open an issue on GitHub
