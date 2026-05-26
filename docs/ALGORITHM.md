# Algoritmo preditivo

## Feature engineering

```
growth_rate = (views_t - views_t-24h) / max(views_t-24h, 1)
acceleration = growth_rate_t - growth_rate_t-24h
sentiment = mean(VADER(scores últimos 100 posts))
```

## Treino

- Target: `views_t+7d / views_t` (clip em 100).
- Validação temporal (sem shuffle).
- Métrica: Spearman rank correlation no top-k.

## Inferência diária

Job `train-and-predict` atualiza modelo semanalmente; scores diários na tabela `predictions`.
