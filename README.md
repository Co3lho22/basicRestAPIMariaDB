# Database Setup Script for MariaDB
## Overview

This script automates the process of checking for MariaDB installation, creating a new database, and setting up default tables for Role-Based Access Control (RBAC) in MariaDB. It is designed to streamline the initial setup process for development and testing environments.
## Prerequisites

    MariaDB must be installed and running on your system.
    You must have administrative access to your MariaDB server.
    The script is intended for Unix-like operating systems and requires Bash.

## Usage

Download the Script: Clone or download the setup-db.sh script from this repository.

### Make the Script Executable:

    chmod +x setup-db.sh

### Run the Script:

    ./setup-db.sh

    Follow the on-screen prompts to enter your MariaDB credentials and the name of the database you wish to create.

## Script Functionality

MariaDB Check: Verifies if MariaDB is installed on your system.
User Prompts: Asks for the MariaDB username, password, and the name of the database to create.
Database Creation: Automatically creates a new database with the specified name.
Table Setup: Creates the following tables:
    USERS: Stores user information.
    USER_AUTH: Manages user authentication tokens.
    ROLE: Defines user roles.
    PERMISSION: Manages permissions for roles.
    ROLE_PERMISSION: Links roles with permissions.
    USER_ROLE: Associates users with roles.

## Important Notes

    The script should be run in a development or testing environment. Avoid using it in a production environment without proper modifications and testing.
    Handle your database credentials securely. Do not store plain text passwords in the script.
    Ensure that you have backups of your existing databases before running this script to prevent accidental data loss.
