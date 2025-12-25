---
id: agents
aliases: []
tags: []
---

# Coding agents in the CLI

| Provider   | cli command | npm package               | github link                                 |
| ---------- | ----------- | ------------------------- | ------------------------------------------- |
| Google     | gemini      | @google/gemini-cli        | https://github.com/google-gemini/gemini-cli |
| OpenAI     | codex       | @openai/codex             | https://github.com/openai/codex             |
| Anthropics | claude      | @anthropic-ai/claude-code | https://github.com/anthropics/claude-code   |
| Alibaba    | qwen        | @qwen-code/qwen-code      | https://github.com/QwenLM/qwen-code         |
| Github     | copilot     | @github/copilot           | https://github.com/github/copilot-cli       |
| N/A        | opencode    | opencode-ai               | https://github.com/sst/opencode             |
| N/A        | cline       | cline                     | https://github.com/cline/cline              |
| N/A        | crush       | @charmland/crush          | https://github.com/charmbracelet/crush      |

## Quick Comparison

|          | Open source | Platform | Multi-Provider |
| -------- | ----------- | -------- | -------------- |
| gemini   | Y           | L/W/M    | N              |
| codex    | Y           | L/W/M    | Y              |
| claude   | N           | L/W/M    | N              |
| qwen     | Y           | L/W/M    | Y              |
| copilot  | N           | L/W/M    | Y              |
| opencode | Y           | L/W/M    | Y              |
| cline    | Y           | L/M      | Y              |
| crush    | Y           | L/W/M    | Y              |

## Configuration

> [!NOTE]
> Platform: L/W/M: Linux / Windows / Mac
> Multi-Provider: Ability to use other models from other providers, such as OpenAI native, OpenAI compatible, Ollama, ...
