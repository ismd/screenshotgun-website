upstream screenshotgun {
    server screenshotgun:80;
}

server {
    listen 80;
    listen [::]:80;
    return 301 https://$host$request_uri;
}

server {
    server_name screenshotgun.com;
    listen 443 ssl;

    add_header Strict-Transport-Security    "max-age=31536000; includeSubDomains" always;
    add_header X-Frame-Options              SAMEORIGIN;
    add_header X-Content-Type-Options       nosniff;
    add_header X-XSS-Protection             "1; mode=block";

    ssl_certificate /etc/letsencrypt/live/screenshotgun.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/screenshotgun.com/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    location / {
        proxy_pass http://screenshotgun;
        proxy_set_header    X-Real-IP           $remote_addr;
        proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;
        proxy_set_header    X-Forwarded-Proto   $scheme;
        proxy_set_header    Host                $host;
        proxy_set_header    X-Forwarded-Host    $host;
        proxy_set_header    X-Forwarded-Port    $server_port;
    }
}
