ARG PACKER_HASH="sha256:93291f0b3041080b47b065b77309e5c1beee52c6bd691224d21d32e91ec9b562"

FROM hashicorp/packer@${PACKER_HASH}

COPY "entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]

LABEL org.opencontainers.image.source https://github.com/GrooveCommunity/packer