CREATE TABLE IF NOT EXISTS trends (
  id SERIAL PRIMARY KEY,
  platform VARCHAR(16) NOT NULL,
  tag VARCHAR(255) NOT NULL,
  first_seen TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(platform, tag)
);

CREATE TABLE IF NOT EXISTS snapshots (
  id BIGSERIAL PRIMARY KEY,
  trend_id INT NOT NULL REFERENCES trends(id),
  captured_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  view_count BIGINT DEFAULT 0,
  post_count INT DEFAULT 0,
  sentiment_score DOUBLE PRECISION
);

CREATE INDEX idx_snapshots_trend_time ON snapshots(trend_id, captured_at DESC);
