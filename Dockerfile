# Tag with the MEGAcmd version from MEGA's repo; skip the build if that tag already exists on Docker Hub
# VERSION=$(curl -s https://mega.nz/linux/repo/Debian_13/Packages | awk '/^Package:/{p=$2} /^Version:/{v=$2} /^Architecture:/{if(p=="megacmd"&&$2=="amd64"){print v; exit}}')
# docker manifest inspect bheemboy/megacmd:$VERSION >/dev/null 2>&1 && echo "$VERSION already published"
# docker build -t bheemboy/megacmd:latest -t bheemboy/megacmd:$VERSION .
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
  && apt-get purge -y wget \
  && apt-get autoremove -y \
  && apt-get autoclean -y \
  && rm -rf /var/lib/apt/lists/* \
  # Make MEGA folder
  && mkdir -p /root/MEGA

ENTRYPOINT ["mega-cmd-server"]
