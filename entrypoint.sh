#!/bin/bash
set -e

# Inputs provided by GitHub Actions
TARGET="${INPUT_TARGET}"
APP="${INPUT_APP}"
IMAGE="${INPUT_IMAGE}"
ENV_NAME="${INPUT_ENV}"
MACHINE_KEY="${INPUT_MACHINE_KEY}"
WORKING_DIR="${INPUT_WORKING_DIRECTORY:-.}"

if [ -z "$TARGET" ]; then
    echo "❌ Error: 'target' input is required."
    exit 1
fi

if [ -z "$ENV_NAME" ]; then
    echo "❌ Error: 'env' input is required."
    exit 1
fi

if [ -z "$MACHINE_KEY" ]; then
    echo "❌ Error: 'machine-key' input is required."
    exit 1
fi

# Set the Machine Key for Arcane to pick up
export ARCANE_MACHINE_KEY="$MACHINE_KEY"

# Navigate to working directory
cd "$WORKING_DIR"

# Construct the command
CMD="arcane deploy --target $TARGET --env $ENV_NAME"

if [ -n "$APP" ]; then
    CMD="$CMD --app $APP"
fi

if [ -n "$IMAGE" ]; then
    CMD="$CMD --image $IMAGE"
    # If image is provided, we assume app name is also needed if it's not inferrable,
    # but Arcane defaults to generic logic if not.
    # Ideally user provides both.
fi

echo "🚀 Running: $CMD"
eval "$CMD"
