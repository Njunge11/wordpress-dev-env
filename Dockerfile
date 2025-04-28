# --------------------------------------------------------------------
# WordPress + WP-CLI development image
# --------------------------------------------------------------------
FROM wordpress:latest

# --------------------------------------------------------------------
# 1) Extra utilities (single, squash-able layer)
# --------------------------------------------------------------------
RUN set -eux; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        vim nano less git zip unzip mariadb-client curl; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

# --------------------------------------------------------------------
# 2) WP-CLI (run safely as root inside the container)
# --------------------------------------------------------------------
ENV WP_CLI_VERSION="2.10.0" \
    WP_CLI_ALLOW_ROOT="1"

RUN curl -fsSL "https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar" \
      -o /usr/local/bin/wp \
 && chmod +x /usr/local/bin/wp \
 && wp --info --allow-root

# --------------------------------------------------------------------
# 3) Apache tweaks
# --------------------------------------------------------------------
RUN a2enmod rewrite headers expires

# --------------------------------------------------------------------
# 4) Runtime permission fix (executed automatically by the official entrypoint)
# --------------------------------------------------------------------
RUN mkdir -p /usr/local/etc/docker-entrypoint.d
COPY docker-entrypoint.d/10-fix-perms.sh /usr/local/etc/docker-entrypoint.d/10-fix-perms.sh
RUN chmod +x /usr/local/etc/docker-entrypoint.d/10-fix-perms.sh

# --------------------------------------------------------------------
# 5) Done – keep default (root) user so entrypoint can work normally
# --------------------------------------------------------------------
