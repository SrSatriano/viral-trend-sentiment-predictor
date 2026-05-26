# Modelagem do banco

## Tabelas adicionais

### predictions

| Coluna | Tipo |
|--------|------|
| trend_id | FK |
| predicted_at | timestamptz |
| explosion_score | float |
| rank | int |

### alerts

Notificações quando `explosion_score > threshold`.

## Índices

- `snapshots(trend_id, captured_at DESC)`
- `trends(platform, tag)`

## Migrations

```bash
psql $DATABASE_URL -f migrations/001_init.sql
```
