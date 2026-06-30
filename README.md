# synaxi-projection

Projection-only context tooling, separated from `synaxi-predict`.

This repository contains the benchmark/runtime harness used to evaluate projection behavior with local and remote models.

## Scope

- ✅ Projection/context-control behavior
- ✅ Harness execution + conversation history logging
- ✅ FUSE/snapshot filesystem observation
- ❌ Token optimization/compression techniques from the main Synaxi product

## Install

```bash
pip install -e .
```

## Run

```bash
synaxi-projection-benchmark --help
```

Example (local Ollama):

```bash
synaxi-projection-benchmark   --provider ollama   --model gemma4:latest   --synaxi   --projection   --fs-tracker fuse   --require-fuse
```


## Wrapper CLI (projection only)

This repo includes a Headroom-style wrapper for Claude Code TUI that is **projection-only**.

- `synaxi-projection wrap claude [--proxy-url http://127.0.0.1:8082]`
- `synaxi-projection status`
- `synaxi-projection doctor`
- `synaxi-projection unwrap claude`

What wrapping does:

1. Captures the real `claude` binary path
2. Installs a shim at `~/.local/bin/claude`
3. Shim launches real Claude with `SYNAXI_PROJECTION_ENABLED=1` and optional proxy env

> Note: make sure `~/.local/bin` is earlier in `PATH` than the original Claude install.
