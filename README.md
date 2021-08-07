# Screenshotgun website
Website for Screenshotgun

## Create SSL certificate
```
certbot --nginx -d screenshotgun.com -m zzismd@gmail.com --agree-tos -n
```

## Renew SSL certificate
```
certbot renew
```
To add a cron task:
```
echo "0 12 * * * /usr/bin/certbot renew --quiet" > /var/spool/cron/crontabs/root
```

## Run
```
docker-compose up
```
