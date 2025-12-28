FROM rust:1.83-slim-bookworm

# Install system dependencies
# - ssh: Required for Arcane to connect to servers
# - git: Required for cargo install
# - pkg-config, libssl-dev: Required for Arcane compilation
RUN apt-get update && apt-get install -y \
    git \
    ssh \
    pkg-config \
    libssl-dev \
    protobuf-compiler \
    && rm -rf /var/lib/apt/lists/*

# Install Arcane from source
# NOTE: In the future, this should download a pre-compiled binary release to save time.
RUN cargo install --git https://github.com/DraconDev/arcane

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
