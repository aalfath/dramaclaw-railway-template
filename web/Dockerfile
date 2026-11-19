# DramaClaw web (SPA + nginx reverse proxy), official image pinned by version and digest.
FROM claymorelab/dramaclaw-frontend:2.1.3@sha256:a53ffb93f3954f57cf823c47252982b54980fc99d70366c5501104f983765d60

# PORT: Railway's public port. BACKEND_HOST/BACKEND_PORT: the private API service.
# NGINX_ENTRYPOINT_LOCAL_RESOLVERS=1 makes the nginx entrypoint export the container's
# DNS server (Railway private DNS) as NGINX_LOCAL_RESOLVERS for the resolver line.
ENV PORT=8080 \
    BACKEND_HOST=dramaclaw-api.railway.internal \
    BACKEND_PORT=8780 \
    CSP_PAYMENT_FORM_ORIGINS="" \
    NGINX_ENTRYPOINT_LOCAL_RESOLVERS=1 \
    NGINX_ENVSUBST_FILTER="^(PORT|BACKEND_HOST|BACKEND_PORT|CSP_PAYMENT_FORM_ORIGINS|NGINX_LOCAL_RESOLVERS)$"

COPY nginx.conf.template /etc/nginx/templates/default.conf.template
COPY --chmod=755 18-dramaclaw-auth.sh /docker-entrypoint.d/18-dramaclaw-auth.sh

EXPOSE 8080
