# PirateFlix

A personal self-hosted media server stack using Docker Compose. This setup includes torrenting, media organization, and streaming – all running behind a secure VPN and HTTPS via SWAG and DuckDNS.

---

## 📦 Services Included

| Service      | Port | Description                                  |
|--------------|------|----------------------------------------------|
| Gluetun      | N/A  | VPN container for traffic routing            |
| qBittorrent  | 8080 | Torrent client                               |
| Radarr       | 7878 | Movie downloader/organizer                   |
| Sonarr       | 8989 | TV Show downloader/organizer                 |
| Bazarr       | 6767 | Subtitle manager                             |
| Prowlarr     | 9696 | Indexer manager                              |
| Jellyfin     | 8096 | Media server                                 |
| SWAG         | 443/80 | HTTPS reverse proxy and certificate manager |
| DuckDNS      | N/A  | Dynamic DNS service                          |

---

## 📁 Directory Structure

The root directory should include:

```
PirateFlix/
├── appdata/
│   ├── gluetun/
│   │   ├── strongvpn.ovpn
│   ├── swag/
│   │   └── nginx/
│   │       └── site-confs/
│   │           └── default
├── downloads/
├── movies/
├── series/
├── cache/
├── docker-compose.yml
├── .env
├── .env.example
└── README.md
```

---

## 🔐 OpenVPN Setup with Gluetun

Place your `.ovpn` config file and credentials in `./appdata/gluetun/`.

**Structure**:
```
./appdata/gluetun/
├── strongvpn.ovpn
└── credentials.txt
```

Reference them in your `.env` file:

```env
VPN_SERVICE_PROVIDER=custom
VPN_TYPE=openvpn
OPENVPN_CUSTOM_CONFIG=/gluetun/strongvpn.ovpn
OPENVPN_USER=yourusername
OPENVPN_PASSWORD=yourpassword
```

These environment variables are picked up by the `gluetun` container.

---

## 🌐 HTTPS & Reverse Proxy with SWAG

To serve Jellyfin over HTTPS via SWAG, edit the nginx config at:

```
./appdata/swag/nginx/site-confs/default
```

Replace `${DOMAIN}` with your actual DuckDNS domain (e.g. `jellyfin.duckdns.org`):

```nginx
server {
    listen 443 ssl;
    server_name ${DOMAIN};

    include /config/nginx/ssl.conf;

    location / {
        proxy_pass http://jellyfin:8096;
        include /config/nginx/proxy.conf;
    }
}
```

You must also define these variables in your `.env`:

```env
URL=jellyfin.duckdns.org
SUBDOMAINS=jellyfin
VALIDATION=duckdns
DUCKDNSTOKEN=your_token
EMAIL=you@example.com
```

> ⚠️ Don't forget to replace `${DOMAIN}` with your real domain name **before deployment**, or use `envsubst` for dynamic generation.

---

## 🚀 Running the Stack

Build and start everything:

```bash
docker compose up -d
```

---

## 🧪 Test Access

- Local access: `http://localhost:8096`
- External access: `https://${DOMAIN}`

---

## 🙈 .env.example

A `.env.example` is provided for safe sharing of config templates. Never commit `.env` directly.


