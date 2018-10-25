FROM picoded/ubuntu-openjdk-8-jdk:16.04

ENV NODE_VERSION 8.12.0
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash && \
  . /root/.nvm/nvm.sh && \
  nvm install 8.12.0
ENV NODE_PATH /root/.nvm/v$NODE_VERSION/lib/node_modules
ENV PATH      /root/.nvm/v$NODE_VERSION/bin:$PATH
RUN npm i -g yarn

ENV ANDROID_HOME /opt/android-sdk-linux
ENV SDK_TOOLS_VERSION 25.2.5
ENV API_LEVELS android-27
ENV BUILD_TOOLS_VERSIONS build-tools-27.0.3,build-tools-28.0.1
ENV ANDROID_EXTRAS extra-android-m2repository,extra-android-support,extra-google-google_play_services,extra-google-m2repository
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

RUN apt-get update && apt-get install -y bash unzip wget && \
    mkdir -p /opt/android-sdk-linux && cd /opt \
    && wget -q http://dl.google.com/android/repository/tools_r${SDK_TOOLS_VERSION}-linux.zip -O android-sdk-tools.zip \
     && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
    && rm -f android-sdk-tools.zip \
    && echo y | android update sdk --no-ui -a --filter \
tools,platform-tools,${ANDROID_EXTRAS},${API_LEVELS},${BUILD_TOOLS_VERSIONS} --no-https