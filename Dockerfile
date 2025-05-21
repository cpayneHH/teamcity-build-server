FROM ubuntu:22.04

ENV TEAMCITY_HOME=/opt/TeamCity \
    TEAMCITY_VERSION=2025.03 \
    TEAMCITY_USER=teamcity \
    NODE_MAJOR=22 \
    YARN_VERSION=1.22

RUN apt-get update

# 1. Common OS-level packages
RUN apt-get update && apt-get install -y \
    openjdk-11-jre-headless wget \
    git mercurial \
    mysql-client default-libmysqlclient-dev \
    postgresql-client libpq-dev \
    ca-certificates curl gnupg \
    unzip zip \
 && rm -rf /var/lib/apt/lists/*

# 2. Teamcity
COPY teamcity.sh /usr/local/bin/install_teamcity.sh
RUN chmod +x /usr/local/bin/install_teamcity.sh \
    && ./usr/local/bin/install_teamcity.sh

# 3. Node 18.x
COPY node.sh /usr/local/bin/install_node.sh
RUN chmod +x /usr/local/bin/install_node.sh \
    && ./usr/local/bin/install_node.sh

# 4. Yarn
COPY yarn.sh /usr/local/bin/install_yarn.sh
RUN chmod +x /usr/local/bin/install_yarn.sh \
    && ./usr/local/bin/install_yarn.sh

# 5. Runtime entrypoint
COPY teamcity-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/teamcity-entrypoint.sh \
    && ./usr/local/bin/teamcity-entrypoint.sh