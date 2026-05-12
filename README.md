Once launched, run `mega-login` and `mega-sync`

Use the following docker-compose.yml

```
services:
  megacmd:
    image: bheemboy/megacmd
    container_name: megacmd
    restart: always
    volumes:
      - /etc/machine-id:/etc/machine-id:ro
      - /mnt/tank/docker/config/megaCmd:/root/.megaCmd
      - /mnt/tank/scanner:/root/MEGA/Scanner
```
