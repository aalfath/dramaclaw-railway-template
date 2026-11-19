# DramaClaw API (Community Edition backend), official image pinned by version and digest.
FROM claymorelab/dramaclaw:2.1.3@sha256:9009914d93ab5c191e011d6b74a8b6ffc1e8342b8998b9c7f990267d673b530c

# Same runtime settings as upstream docker-compose.release.yml (CE, inline mode, all
# state under the /data volume). NEWAPI_* point the one-click "custom gateway" setup
# at the private dramaclaw-gateway service; the template sets them with references.
ENV PORT=8780 \
    ST_EDITION=ce \
    ST_CONTROL_PLANE_DSN= \
    ST_REDIS_URL= \
    ST_CELERY_BROKER_URL= \
    ST_CELERY_RESULT_BACKEND= \
    NOVELVIDEO_DATA_ROOT=/data \
    NOVELVIDEO_OUTPUT_DIR=/data/output \
    NOVELVIDEO_STATE_DIR=/data/state \
    NOVELVIDEO_RUNTIME_DIR=/data/runtime \
    DRAMACLAW_CHAT_BACKEND=codex \
    NEWAPI_BASE_URL=https://relayclaw.cdnfg.com/v1 \
    NEWAPI_ADMIN_USERNAME=root \
    NEWAPI_PROVISIONER_ENABLED=true

EXPOSE 8780

# An empty host makes uvicorn listen on every IPv4 and IPv6 address, so Railway's
# private network (IPv6) and local checks (IPv4) both reach it. "--host ::" alone
# is IPv6-only under asyncio.
CMD ["sh", "-c", "export NOVELVIDEO_API_HOST=; exec novelvideo api --port \"${PORT:-8780}\""]
