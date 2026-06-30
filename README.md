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
