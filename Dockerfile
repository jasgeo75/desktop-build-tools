FROM buildpack-deps:stretch

# Update package list, install upgrades and install some essentials
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Add keys and repositories
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
    && curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-add-repository "deb https://apt.kubernetes.io/ kubernetes-stretch main" \
    && apt-add-repository "deb https://deb.nodesource.com/node_10.x stretch main" \
    && apt-add-repository "deb https://dl.yarnpkg.com/debian/ stable main" \
    && apt-add-repository "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -cs) main" \
    && apt-add-repository "deb http://ftp.debian.org/debian stretch-backports main"

# Install updates and packages
RUN apt-get update \
    && apt-get -y -qq install \
        git \
        kubectl \
        golang-1.10 \
        docker-ce \
        google-cloud-sdk \
        make \
        python2.7 \
        python-pip \
        nodejs \
        yarn \
    && pip install awscli \
    && curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && ln -s /usr/lib/go-1.10/bin/go /usr/bin/go \
    && rm -rf /var/lib/apt/lists/*

