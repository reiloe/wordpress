# Project WordPress

The goal of this project is to dockerize WordPress.

## Table of content

1. [Prerequisites](#Prerequisites)
2. [Quickstart](#Quickstart)
3. [Usage](#Usage)
4. [Notes](#Notes)

### Prerequisites

- Git
- Docker
- Docker Compose v2

### Quickstart

- Open a terminal

- Navigate to a folder of choice

```bash
cd my/test/folder
```

- Clone the project

```bash
git clone https://github.com/reiloe/wordpress.git
```

- Navigate into the root folder (named wordpress)

```bash
cd wordpress
```

- run the following command:

```bash
./setup.sh
```

- Type in a username and a password (for your safety you have to repeat the password)[^1]

[Username_password](img/username_password.png)

> [!CAUTION]  
> A hidden folder named .secrets is created with two files inside.  
> One file contains the username, the other file contains the password.  
> Do not move or delete this folder or these files!

[^1] WordPress stores data in a database. This requires a database user. The username and password are the credentials for this database user.

- WordPress typically starts on port 8080. The setup script will check if this port is in use. You can use this port or switch to your own port. 

[port_free](img/port_free.png)

[port_change_choice](img/port_change_choice.png)

- If the port 8080 is in use you need to change the port.

[port_in_use](img/port_in_use.png)

- After a short time, WordPress is ready to use. 

### Usage
 
Open a browser and enter localhost:8080 [^2] to start configuration of WordPress. [^2](if you have changes the port number during setup, you must enter this port)

First you need to chose your language

[wordpress_language](img/wordpress_language.png)

After that, you have to input some information (eg. username and password) [^3] [^3] NOT the user/pass you have entered while setup

[wordpress_information](img/wordpress_information.png)

A success message shows that WordPress is completely initialized and ready to use.

[wordpress_success](img/wordpress_success.png)

When you click “Log in,” you will be redirected to your WordPress login page.

[wordpress_login](img/wordpress_login.png)

When you log in with the username and password you just created, you will be taken to your WordPress dashboard. 

[wordpress_dashboard](img/wordpress_dashboard.png)

Happy WordPressing

### Notes

A root user is created for the database during setup. The root user's password can be found in the logs immediately after starting the database.

[mysql_root_password](img/mysql_root_password.png)