# .devcontainer/Dockerfile
# Základ: oficiální VS Code devcontainers image (Ubuntu 22.04)
ARG VARIANT="22.04"
FROM mcr.microsoft.com/devcontainers/base:ubuntu-${VARIANT}

# Parametry pro mapování uživatele z hosta (VS Code je umí doplnit automaticky)
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

# Volby nástrojového řetězce
ARG PYTHON_PKGS="pip wheel build Cython>=3.0 setuptools>=69 pytest pytest-cov"
ARG INSTALL_NUMPY=0  # nastavte na 1, chcete-li předinstalovat NumPy pro kompilaci proti jeho API

# --- OS balíčky: kompilátor, Python dev hlavičky, nástroje ---
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    python-is-python3 \
    pkg-config \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Uživatel (UID/GID sjednocení s hostem)
RUN if id -u ${USERNAME} >/dev/null 2>&1; then \
      usermod -u ${USER_UID} ${USERNAME} && groupmod -g ${USER_GID} ${USERNAME} && \
      chown -R ${USER_UID}:${USER_GID} /home/${USERNAME}; \
    else \
      groupadd --gid ${USER_GID} ${USERNAME} && \
      useradd -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME}; \
    fi

USER ${USERNAME}
WORKDIR /workspaces

# Prostředí: pip cache povolena (rychlejší reinstalace) + paralelní build
ENV PIP_NO_CACHE_DIR=0 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    MAKEFLAGS="-j$(nproc)"

# Aktualizace pipu a instalace build nástrojů pro Cython projekt
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install ${PYTHON_PKGS}

# (Volitelné) NumPy, pokud chcete kompilovat přímo proti jeho API (include_dirs)
# Pozn.: Pro čisté typed-memoryviews NumPy nepotřebujete v době kompilace.
RUN if [ "${INSTALL_NUMPY}" = "1" ]; then \
      python3 -m pip install "numpy>=1.23"; \
    else \
      echo "Skipping NumPy install (INSTALL_NUMPY=${INSTALL_NUMPY})"; \
    fi

# (Volitelné) další užitečné nástroje pro distribuci
#   twine – nahrávání na (Test)PyPI
#   cibuildwheel – lokální prototypování wheel buildů (produkčně spíše v CI)
RUN python3 -m pip install "twine>=5" "cibuildwheel>=2.20" || true

# Tip: nastavte optimalizační flagy kompilátoru přes proměnné prostředí
# export FASTOPS_CFLAGS="-O3 -march=native" ; export FASTOPS_LDFLAGS=""
ENV FASTOPS_CFLAGS="" \
    FASTOPS_LDFLAGS=""

# Finální echo pro snadnou diagnostiku
RUN python3 - <<'PY'
import sys, subprocess
print("Python:", sys.version)
print("pip list:")
subprocess.run([sys.executable, "-m", "pip", "list"])
PY
