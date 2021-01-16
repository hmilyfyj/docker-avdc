FROM python:3.8-slim

# 软件包版本号
ARG AVDC_VERSION

RUN \
    apt-get update && \
    apt-get install -y wget ca-certificates git && \
    mkdir build && \
    cd build && \
    git clone https://github.com/yoshiko2/AV_Data_Capture.git && \
    mv AV_Data_Capture /app && \
    cd .. && \
    rm -rf build && \
    cd /app && \
    sed -i '/pyinstaller/d' requirements.txt && \
    cat requirements.txt && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get purge -y wget

VOLUME /app/data
WORKDIR /app

COPY docker-entrypoint.sh docker-entrypoint.sh

# 镜像版本号

RUN chmod +x docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]
