FROM node:8

LABEL maintainer="Erin Schnabel <schnabel@us.ibm.com> (@ebullientworks)"

RUN wget -q https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb \
  && apt-get -qq update \
  && DEBIAN_FRONTEND=noninteractive apt-get -qq upgrade -y \
  && apt-get -qq install -y apt-utils busybox curl wget jq xfonts-75dpi xfonts-base \
  && dpkg -i wkhtmltox_0.12.5-1.stretch_amd64.deb \
  && apt-get -qq clean \
  && rm -rf /tmp/* /var/lib/apt/lists/* wkhtmltox_0.12.5-1.stretch_amd64.deb

ENV PATH="${PATH}:/usr/local/lib/node_modules/marked-it-cli/bin"
RUN npm install -g marked-it-cli \
  && npm install -g npm \
  && npm install -g bower \
  && npm install -g gulp \
  && npm install -g sass \
  && echo 'export PATH=$PATH:/usr/local/lib/node_modules/marked-it-cli/bin' >> /etc/bash.bashrc

COPY npm_wrap /usr/local/bin
