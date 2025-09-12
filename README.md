# Inception

## How to use

### Credentials

```bash
make secrets # -> create `secrets/` folder + credentials / passwords files 
make env # -> create `srcs/.env` file containing credentials
```

Passwords files (`secrets/*password.txt`) are mounted via `docker-compose` for security purpose: passwords are not baked into images nor exposed as plaintext environment variables in running processes.

### Connect to Virtual machine via SSH:

```bash
ssh -p 2222 user@localhost
```

## Containers

- Nginx: Proxy server + SSL certificates
- Wordpress: uses PHP-FPM as a PHP runtime and downloads the last version of wordpress. Ran as www-data user. Access: https://localhost

The reverse-proxy server

### Mariadb

The database, compatible with mysql.


### SFTP server

In terminal:
```bash
sftp -P 2223 ftpuser@localhost
# Then enter password + FTP commands, example:
# sftp > get <filename>
# sftp > quit
```

Using Filezilla:
```bash
Host: localhost
Port: 2223
Protocol: SFTP
User: FTP_USER (defined in .env)
Password: FTP_PASS (defined in .env)
```
