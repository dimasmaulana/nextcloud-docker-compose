FROM nextcloud:apache

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Install curl first, as well as gnuplot and other libraries
RUN apt-get update && \
    apt-get install ffmpeg --no-install-recommends -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean
