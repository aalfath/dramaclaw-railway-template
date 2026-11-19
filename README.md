# DramaClaw on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/dramaclaw?utm_medium=integration&utm_source=button&utm_campaign=dramaclaw)

Railway template for [DramaClaw](https://github.com/dramaclaw/dramaclaw) Community Edition, the open-source AIGC video engine that turns a script into a finished film (dramas, ads, product videos and more) in one pipeline.

This repo is the source the template's services build from. It wraps the official DramaClaw images, pinned by version and digest:

| Service | Folder | Image | Public |
|---|---|---|---|
| `dramaclaw-web` | `web/` | `claymorelab/dramaclaw-frontend:2.1.3` | yes, behind HTTP basic auth |
| `dramaclaw-api` | `api/` | `claymorelab/dramaclaw:2.1.3` | no (private network), volume at `/data` |
| `dramaclaw-gateway` | `gateway/` | `claymorelab/dramaclaw-gateway:v1.0.0-rc.24-dramaclaw.3` | no (private network) |
| `Postgres` | Railway database | Railway Postgres | no |

## Login

DramaClaw CE has no user accounts of its own, and its settings page stores model API keys. The web service therefore asks for a username and password (HTTP basic auth) on every page. The template sets:

- `DRAMACLAW_USERNAME` = `admin`
- `DRAMACLAW_PASSWORD` = a random 32-character secret

Find the password in the `dramaclaw-web` service's **Variables** tab. `/healthz` stays open for Railway's health check.

## Variables in short

| Service | Variable | Value |
|---|---|---|
| web | `DRAMACLAW_USERNAME`, `DRAMACLAW_PASSWORD` | login for the UI (password generated) |
| web | `BACKEND_HOST` | `${{dramaclaw-api.RAILWAY_PRIVATE_DOMAIN}}` |
| api | `PROMPT_EXPORT_PASSWORD` | generated secret (upstream default `change_me` must not be used) |
| api | `NEWAPI_ADMIN_BASE_URL` | `http://${{dramaclaw-gateway.RAILWAY_PRIVATE_DOMAIN}}:3000` |
| api | `NEWAPI_SQL_DSN` | `${{Postgres.DATABASE_URL}}` (so the API can set up the gateway) |
| gateway | `SQL_DSN` | `${{Postgres.DATABASE_URL}}` |
| gateway | `SESSION_SECRET` | generated secret |

Models are configured after deploy in **Settings → Models**: paste an official DramaClaw (RelayClaw) key, or choose **Custom** to initialise the bundled gateway and add your own provider keys (OpenAI-compatible and others), or point the Agent model at any OpenAI-compatible endpoint.

## Updates

Every service builds from this repo's `main` branch. When a new DramaClaw release comes out, the pins in the Dockerfiles are bumped and the change is described in [CHANGELOG.md](CHANGELOG.md). Railway then shows "update available" to everyone who deployed the template, and you choose when to apply it. Read the changelog first: breaking changes are listed at the top of each entry. Your projects, settings and generated media stay on the `/data` volume, and the gateway's data stays in Postgres.

## Licence

DramaClaw is licensed under the [Elastic License 2.0](https://github.com/dramaclaw/dramaclaw/blob/main/LICENSES/Elastic-2.0.txt) (source available). You may run it for yourself, but not offer DramaClaw to third parties as a hosted or managed service. DramaClaw names and logos belong to their owners. This template is not affiliated with or endorsed by the DramaClaw project. The wrapper files in this repo are MIT.
