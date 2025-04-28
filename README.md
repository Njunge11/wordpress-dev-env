# WordPress Local Development Environment

This is a Docker-based WordPress development environment with WP-CLI and essential plugins pre-configured.

## Prerequisites

- Docker Desktop installed on your machine
- Basic understanding of command line
- Git (optional)

## Quick Start

1. Clone or download this repository

```bash
git clone <repository-url>
cd <project-directory>
```

2. Create a `.env` file in the project root:

```env
# Database settings
DB_NAME=wordpress
DB_USER=wordpress
DB_PASSWORD=wordpress_password
DB_ROOT_PASSWORD=somewordpress

# WordPress settings
WORDPRESS_DEBUG=1
```

3. Start the environment:

```bash
docker compose up -d
```

4. Install required plugins:

```bash
docker compose exec wordpress wp plugin install --activate --allow-root \
  wp-graphql \
  advanced-custom-fields \
  wpgraphql-acf \
  add-wpgraphql-seo \
  wordpress-seo \
  classic-editor \
  redirection
```

5. Access WordPress:

- Frontend: http://localhost:8080
- Admin: http://localhost:8080/wp-admin
- Default admin credentials will be displayed in the logs: `docker compose logs wordpress`

## Common Commands

### Starting and Stopping

```bash
# Start containers
docker compose up -d

# Stop containers (keeps data)
docker compose stop

# Stop and remove containers (keeps data)
docker compose down

# Stop and remove everything including database
docker compose down -v
```

### Accessing Containers

```bash
# Access WordPress container
docker compose exec wordpress bash

# Access Database container
docker compose exec db bash
```

### Viewing Logs

```bash
# All containers
docker compose logs -f

# Specific container
docker compose logs -f wordpress
```

### Plugin Management

```bash
# List plugins
docker compose exec wordpress wp plugin list --allow-root

# Install a plugin
docker compose exec wordpress wp plugin install plugin-name --activate --allow-root

# Remove a plugin
docker compose exec wordpress wp plugin uninstall plugin-name --allow-root
```

## Starting Fresh

If you need to start completely fresh:

1. Stop and remove everything:

```bash
docker compose down -v
```

2. Delete the local wp-content directory:

```bash
rm -rf ./wp-content
```

3. Start again:

```bash
docker compose up -d
```

## File Structure

- `docker-compose.yml` - Container configuration
- `Dockerfile` - WordPress image configuration
- `.env` - Environment variables
- `wp-content/` - WordPress themes, plugins, and uploads

## Included Tools

- WP-CLI
- Vim editor
- Git
- MariaDB client
- Other development utilities

## Troubleshooting

1. **Ports already in use**

   - Change the port in docker-compose.yml from 8080 to another number

2. **Container won't start**

   - Check logs: `docker compose logs`
   - Ensure no other WordPress containers are running
   - Try `docker compose down -v` and start again

3. **Plugins not installing**
   - Ensure WordPress is fully installed and running
   - Check container logs for errors
   - Try installing plugins one at a time

For more help, check the Docker and WordPress documentation or raise an issue in the repository.
