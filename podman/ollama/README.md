# Ollama
Ollama is an open-source tool designed to run Large Language Models (LLMs) locally on your own computer.

I use ollama to run small models locally.

## Access

- [Terminal](#how-to-use)
- [API](#api)
- [Open WebUI](../open-webui/README.md) (recommended)

## Setup

*COMPLETED 10/04/2026*

[Install Podman and Quadlet support](../../../system/podman/README.md)

Create directory
```bash
mkdir ~/ollama
```

Create quadlet
```bash
sudo nano ~/.config/containers/systemd/ollama.container
```
```ini
[Unit]
Description=Ollama Local AI
After=network-online.target

[Container]
Image=docker.io/ollama/ollama:latest
ContainerName=ollama
Network=ai-net

PublishPort=11434:11434

Volume=%h/ollama:/root/.ollama

[Service]
Restart=on-failure

[Install]
WantedBy=multi-user.target default.target
```
- ```Network=ai-net``` setup detailed in [Open WebUI](../open-webui/README.md)

Reload daemons and start service
```bash
systemctl --user daemon-reload
systemctl --user start ollama.service
```

## How to use

Open ollama container terminal
```bash
podman exec -it ollama ollama
```

Load new models 
```bash
ollama list
ollama run <model_name>
```
- Replace ```<model_name>```, with models  available here: https://ollama.com/search

Remove model
```bash
ollama rm <model_name>
```

Run model
```bash
ollama run llama3.2:3b
```

Chat history is not saved

## API

Request loaded models
```bash
curl http://localhost:11434/api/tags
```

Send prompt
```bash
curl http://localhost:11434/api/generate -d '{
  "model": "llama3.2:3b",
  "prompt": "Hello!",
  "stream": false
}'
```

## Open WebUI
This an interface to access Ollama

Setup: [Open WebUI](../open-webui/README.md)

## Models

Models I use as of early May 2026

```bash
NAME                                    ID              SIZE      MODIFIED
huihui_ai/llama3.2-abliterate:latest    2ffe056672b5    2.2 GB    3 weeks ago
qwen2.5:0.5b                            a8b0c5157701    397 MB    3 weeks ago # fastest
mistral:latest                          6577803aa9a0    4.4 GB    3 weeks ago
gemma4:e4b                              c6eb396dbd59    9.6 GB    4 weeks ago # slowest
llama3.2:3b                             a80c4f17acd5    2.0 GB    4 weeks ago # favourite
```

