# Buf CLI

This feature installs the [Buf CLI](https://buf.build/docs/installation), a tool for working with Protocol Buffers.

## Example Usage

```json
"features": {
    "ghcr.io/your-username/devcontainer-features/buf:1": {
        "version": "latest"
    }
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Version of the Buf CLI to install. Use 'latest' for the most recent version. | string | latest |

## Supported Architectures

This feature supports both x86_64 and aarch64/arm64 architectures.