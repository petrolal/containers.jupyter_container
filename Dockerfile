########################################
# Stage 1 — Builder (instala binários)
########################################
FROM debian:bookworm-slim AS builder

ARG TERRAFORM_VERSION=1.6.6

RUN apt-get update && apt-get install -y \
  curl \
  unzip \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

########################################
# Stage 2 — Runtime (produção)
########################################
FROM jupyter/base-notebook:latest

USER root

# Pacotes mínimos necessários
RUN apt-get update && apt-get install -y \
  graphviz \
  nodejs \
  npm \
  && rm -rf /var/lib/apt/lists/*

# Python tools essenciais
RUN pip install --no-cache-dir \
  diagrams 

RUN pip install jupyterlab-myst
RUN npm install -g @mermaid-js/mermaid-cli

# # Permissões padrão do notebook
USER ${NB_UID}

WORKDIR /home/jovyan/work
