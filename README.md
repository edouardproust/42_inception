# Inception

## Connect to Virtual machine via SSH:

```bash
ssh -p 2222 user@localhost
```

## SFTP server

In terminal:
```bash
sftp -P 2223 ftpuser@localhost
```

Using Filezilla:
```bash
Host: localhost
Port: 2223
Protocol: SFTP
User: FTP_USER (defined in .env)
Password: FTP_PASS (defined in .env)
```
