# Changelog

## 2.1.3 (2026-11-19)

- First version of the template: DramaClaw CE 2.1.3.
- `web`: `claymorelab/dramaclaw-frontend:2.1.3@sha256:a53ffb93f3954f57cf823c47252982b54980fc99d70366c5501104f983765d60`, listens on `PORT`, HTTP basic auth on every path except `/healthz`.
- `api`: `claymorelab/dramaclaw:2.1.3@sha256:9009914d93ab5c191e011d6b74a8b6ffc1e8342b8998b9c7f990267d673b530c`, data on the `/data` volume.
- `gateway`: `claymorelab/dramaclaw-gateway:v1.0.0-rc.24-dramaclaw.3@sha256:c9b8a5572189281a960f1c3a2ad04e67b5af79271e83d5527198c8a159ce8c8e`, data in Railway Postgres.
