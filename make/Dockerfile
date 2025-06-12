FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y build-essential make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /project

# Default command when container starts
CMD ["make"]