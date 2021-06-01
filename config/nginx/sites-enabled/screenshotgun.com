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

    add_header Strict-Transport-Security    "max-age=31536000; includeSubDomains" always;
    add_header X-Frame-Options              SAMEORIGIN;
    add_header X-Content-Type-Options       nosniff;
    add_header X-XSS-Protection             "1; mode=block";

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
