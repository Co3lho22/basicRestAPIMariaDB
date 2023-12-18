#!/bin/bash

# Check if MariaDB is installed
if ! command -v mysql &> /dev/null
then
    echo "MariaDB is not installed. Please install MariaDB and try again."
    exit 1
fi

# Prompt for database credentials and database name
read -p "Enter MariaDB username: " db_user
read -sp "Enter MariaDB password: " db_pass
echo
read -p "Enter database name to create: " db_name

# Login and create database
mysql -u "$db_user" -p"$db_pass" -e "CREATE DATABASE IF NOT EXISTS $db_name;"

# Check if the database was created successfully
if [ $? -ne 0 ]; then
    echo "Failed to create database. Please check your credentials."
    exit 1
fi

# Define SQL for table creation
sql=$(cat <<-END
CREATE TABLE $db_name.USERS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    hashed_password VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    country VARCHAR(255),
    phone VARCHAR(255),
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE $db_name.USER_AUTH (
    user_id INT,
    refresh_token VARCHAR(255),
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES USERS(id)
);

CREATE TABLE $db_name.ROLE (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE $db_name.PERMISSION (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE $db_name.ROLE_PERMISSION (
    role_id INT,
    permission_id INT,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES ROLE(id),
    FOREIGN KEY (permission_id) REFERENCES PERMISSION(id)
);

CREATE TABLE $db_name.USER_ROLE (
    user_id INT,
    role_id INT,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES USERS(id),
    FOREIGN KEY (role_id) REFERENCES ROLE(id)
);
END
)

# Execute SQL
mysql -u "$db_user" -p"$db_pass" -e "$sql"

# Check if tables were created successfully
if [ $? -eq 0 ]; then
    echo "Tables created successfully."
else
    echo "Failed to create tables."
fi

