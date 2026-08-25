# docker build -t bheemboy/megacmd:latest -t bheemboy/megacmd:$(Get-Date -Format "yyyy.MM.dd") .
# docker push --all-tags bheemboy/megacmd

FROM debian:13-slim

RUN apt-get update \
  # Upgrade
  && apt-get upgrade -y \
  && apt-get dist-upgrade -y \
  # Install dependencies
  && apt-get install wget -y \
  # Download & Install MegaCMD
  && wget https://mega.nz/linux/repo/Debian_13/amd64/megacmd-Debian_13_amd64.deb \
  && (dpkg -i megacmd-Debian_13_amd64.deb || true) \
  && apt-get install -f -y \
  # Cleanup
  && rm *.deb \
  && apt-get purge -y \
  && apt-get autoremove -y \
  && apt-get autoclean -y \
  # Make MEGA folder
  && mkdir -p /root/MEGA

ENTRYPOINT ["mega-cmd-server"]
