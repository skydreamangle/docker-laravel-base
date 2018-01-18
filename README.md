Docker base image with Alpine Linux and Nginx/PHP7
==================================================

This image contains:

- Alpine Linux
- Nginx
- PHP7 with most common extensions
- S6 (process supervisor)
- Composer

You can extends this image to package your own web application.

- The document root is `/var/www/app`.
- To add environment variables to PHP-FPM, overwrite the file `/etc/php7/php-fpm.d/env.conf` in your Dockerfile.
