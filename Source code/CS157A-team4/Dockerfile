FROM mysql:8.0

# Copy custom MySQL configuration
COPY my.cnf /etc/mysql/conf.d/my.cnf

# Set permissions for the configuration file
RUN chmod 644 /etc/mysql/conf.d/my.cnf

# Copy initialization script to create the database and tables
COPY init.sql /docker-entrypoint-initdb.d/

# Set execute permissions for the initialization script
RUN chmod 755 /docker-entrypoint-initdb.d/init.sql

CMD ["mysqld"]