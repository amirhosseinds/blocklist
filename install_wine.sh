
apt-get update -y \
&& DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    cabextract \
    git \
    gnupg \
    gosu \
    gpg-agent \
    locales \
    p7zip \
    pulseaudio \
    pulseaudio-utils \
    sudo \
    tzdata \
    unzip \
    wget \
    winbind \
    xvfb \
    zenity \
    nano \
    curl

mkdir -pm755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

dpkg --add-architecture i386
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/mantic/winehq-mantic.sources
apt update -y
apt install --install-recommends -y winehq-stable

wget -nv -O /usr/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
    && chmod +x /usr/bin/winetricks

wget https://raw.githubusercontent.com/amirhosseinds/blocklist/main/download_gecko_and_mono.sh
RUN chmod +x download_gecko_and_mono.sh \
    && download_gecko_and_mono.sh "$(wine --version | sed -E 's/^wine-//')"

echo "export WINEPREFIX=/root/prefix32" >> /root/.bashrc
echo "export WINEARCH=win32" >> /root/.bashrc
