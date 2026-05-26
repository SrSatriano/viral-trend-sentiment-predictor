"""Treino do modelo preditivo de tendências."""

from sklearn.ensemble import GradientBoostingRegressor
import numpy as np


def train(X: np.ndarray, y: np.ndarray) -> GradientBoostingRegressor:
    model = GradientBoostingRegressor(n_estimators=100, max_depth=4)
    model.fit(X, y)
    return model


if __name__ == "__main__":
    # dados sintéticos para scaffold
    X = np.random.rand(100, 5)
    y = np.random.rand(100) * 10
    m = train(X, y)
    print("model trained", m.score(X, y))
