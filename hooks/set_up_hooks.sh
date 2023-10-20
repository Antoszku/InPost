#!/usr/bin/env bash

echo "Setting up custom directory for git hooks"

brew list swiftformat || brew install swiftformat
git config core.hooksPath hooks
