FROM wordpress:latest

# Install useful development tools
RUN apt-get update && apt-get install -y \
    vim \
    nano \
    less \
    git \
    zip \
    unzip \
    mariadb-client \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Configure Apache
RUN a2enmod rewrite headers

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html && \
    find /var/www/html -type d -exec chmod 755 {} \; && \
    find /var/www/html -type f -exec chmod 644 {} \;