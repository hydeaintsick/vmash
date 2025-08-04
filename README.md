# WinWeb - Linux Desktop Web App

A web-based Linux desktop application using Next.js 15, Docker, and VNC for direct desktop access.

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐
│   Next.js 15    │    │  Ubuntu Desktop │
│   Frontend      │◄──►│  with VNC       │
│   (Port 3000)   │    │  (Port 5900)    │
└─────────────────┘    └─────────────────┘
```

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose
- Node.js 18+ and npm
- Git

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd winweb
   ```

2. **Install dependencies**

   ```bash
   npm install
   ```

3. **Start the application**

   ```bash
   ./start.sh
   ```

4. **Access the application**
   - Frontend: http://localhost:3000
   - Click "Lancer le Bureau Linux" to start the desktop

## 📁 Project Structure

```
winweb/
├── app/                    # Next.js 15 App Router
│   ├── api/               # API routes
│   │   └── status/        # Status checking endpoint
│   ├── globals.css        # Global styles
│   ├── layout.tsx         # Root layout
│   └── page.tsx           # Main page
├── scripts/               # Utility scripts
│   ├── commit.sh          # Interactive commit helper
│   └── quick-commit.sh    # Quick commit helper
├── docker-compose.yml     # Docker services
├── init-guacamole-db.sql  # Database initialization
├── start.sh               # Startup script
├── package.json           # Node.js dependencies
└── README.md              # This file
```

## 🐳 Docker Services

### Core Services

- **guacd**: Apache Guacamole daemon (VNC proxy)
- **guacamole**: Apache Guacamole web application
- **postgres**: PostgreSQL database for Guacamole
- **guacamole-init**: Database initialization container
- **demo-desktop**: Ubuntu Desktop with VNC

## 🔧 Configuration

### Environment Variables

Copy `config.example.env` to `.env` and customize:

```env
# Next.js Configuration
NEXT_PUBLIC_APP_NAME=WinWeb
NEXT_PUBLIC_APP_VERSION=1.0.0

# Docker Configuration
DOCKER_COMPOSE_FILE=docker-compose.yml
DOCKER_NETWORK=winweb-network

# VNC Configuration
VNC_HOST=localhost
VNC_PORT=5900
VNC_PASSWORD=password
```

## 🚀 Usage

### Development

```bash
npm run dev
```

### Production

```bash
npm run build
npm start
```

## 🔍 Troubleshooting

### Common Issues

1. **Port conflicts**

   ```bash
   # Check what's using the ports
   lsof -i :3000
   lsof -i :5900
   ```

2. **Docker issues**

   ```bash
   # Restart Docker services
   docker compose down
   docker compose up -d
   ```

3. **Database issues**
   ```bash
   # Reset database
   docker volume rm winweb_postgres_data
   docker compose up -d
   ```

### Logs

```bash
# View all logs
docker compose logs

# View specific service logs
docker compose logs guacamole
docker compose logs postgres
docker compose logs demo-desktop
```

## 📝 Commit Convention

This project uses conventional commits. Use the provided scripts:

```bash
# Interactive commit
npm run commit

# Quick commit
npm run commit:quick <type> <message>
```

See `COMMIT_CONVENTION.md` for detailed usage.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Use conventional commits
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.
