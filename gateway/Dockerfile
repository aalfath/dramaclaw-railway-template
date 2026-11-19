# DramaClaw model gateway (DramaClaw's fork of new-api, OpenAI-compatible), official
# image pinned by version and digest. Private service: only the DramaClaw API talks to it.
FROM claymorelab/dramaclaw-gateway:v1.0.0-rc.24-dramaclaw.3@sha256:c9b8a5572189281a960f1c3a2ad04e67b5af79271e83d5527198c8a159ce8c8e

# SQL_DSN (Railway Postgres) and SESSION_SECRET come from the template variables.
ENV PORT=3000

COPY --chmod=755 start.sh /start.sh

EXPOSE 3000
ENTRYPOINT ["/start.sh"]
