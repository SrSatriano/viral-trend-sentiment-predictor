# Viral Trend Sentiment Predictor

Scraper distribuído (Go) + ML (Python) que monitora hashtags e áudios no TikTok/YouTube e prevê nichos que explodirão na próxima semana.

## Stack

- Go — extração rápida
- Python — Scikit-Learn
- PostgreSQL

## Modelagem do banco de dados

```sql
-- trends: uma linha por hashtag/áudio
CREATE TABLE trends (
  id SERIAL PRIMARY KEY,
  platform VARCHAR(16),
  tag VARCHAR(255),
  first_seen TIMESTAMPTZ,
  UNIQUE(platform, tag)
);

-- snapshots: série temporal de métricas
CREATE TABLE snapshots (
  id BIGSERIAL PRIMARY KEY,
  trend_id INT REFERENCES trends(id),
  captured_at TIMESTAMPTZ,
  view_count BIGINT,
  post_count INT,
  sentiment_score FLOAT
);
```

ERD completo: [docs/DATABASE.md](docs/DATABASE.md)

## Algoritmo preditivo

1. **Features**: taxa de crescimento log(views), aceleração, sentimento médio, dispersão entre criadores.
2. **Modelo**: Gradient Boosting Regressor → score de explosão em 7 dias.
3. **Threshold**: top 5% scores → alerta.

Detalhes: [docs/ALGORITHM.md](docs/ALGORITHM.md)

## Cron jobs de coleta

```cron
# deploy/cron/crontab.example
0 */4 * * * /app/scraper --platform=tiktok
15 */6 * * * /app/scraper --platform=youtube
0 2 * * * /app/train-and-predict
```

Docker: ver `deploy/cron/`.

## Setup

```bash
docker compose up -d postgres
go build -o bin/scraper ./cmd/scraper
python -m pkg.ml.train
```

## Aviso legal

Respeite ToS das plataformas e robots.txt. Uso educacional.
