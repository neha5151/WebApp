FROM amr-registry-pre.caas.intel.com/pse-pswe-software-ba/autodeployment:test
ENV NO_PROXY altera.com,intel.com,.intel.com,localhost,127.0.0.1
ENV http_proxy http://proxy-us.intel.com:911
ENV FTP_PROXY http://proxy-us.intel.com:912
ENV ftp_proxy http://proxy-us.intel.com:911
ENV all_proxy http://proxy-us.intel.com:1080
ENV ALL_PROXY http://proxy-us.intel.com:1080
ENV socks_proxy http://proxy-us.intel.com:1080
ENV SOCKS_PROXY http://proxy-us.intel.com:1080
ENV HTTPS_PROXY http://proxy-us.intel.com:912
ENV https_proxy http://proxy-us.intel.com:912
ENV no_proxy altera.com,intel.com,.intel.com,localhost,127.0.0.1
ENV HTTP_PROXY http://proxy-us.intel.com:911
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
CMD node index.js
EXPOSE 8081