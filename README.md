# Smart Systems Hub Helm Charts

This repository contains Helm charts published by Smart Systems Hub to facilitate the deployment of the BDRS server, Tractus-X, and Factory-X connectors in our KYMA hosted environment.

## Why This Repository Exists

While upstream Helm charts exist for these components, our charts are specifically customized to work within the Smart Systems Hub infrastructure. The key difference is that **our charts configure the necessary API Rules to make these services publicly accessible in our KYMA environment** without requiring additional manual configuration.

## Charts

| Chart | Description | Latest Version |
|-------|-------------|----------------|
| `tractusx-connector` | Tractus-X connector deployment | 0.11.3 |
| `factoryx-connector` | Factory-X connector deployment | 0.1.4 |
| `bdrs-server` | BDRS server deployment | 0.5.6 |

## Quick Start

### 1. Add the Helm Repository

```bash
helm repo add smart-systems-hub https://smart-systems-hub.github.io/helm-charts
```

### 2. Update Repository Information
```bash
helm repo update
```

### 3. Deploy a Chart
Use the following pattern to deploy any chart from this repository:
```bash
helm upgrade --install {deployment_name} \
  smart-systems-hub/{chart_name} \
  --version {chart_version} \
  -f {values_file} \
  -n {namespace} \
  --create-namespace
```


## Example deployment

### Tractus-X Connector:
```bash
helm upgrade --install my-tractusx \
  smart-systems-hub/tractusx-connector \
  --version 0.11.3 \
  -f custom-values.yaml \
  -n tractusx \
  --create-namespace
```

### Factory-X Connector:
```bash
helm upgrade --install my-factoryx \
  smart-systems-hub/factoryx-connector \
  --version 0.1.4 \
  -f factoryx-values.yaml \
  -n factoryx \
  --create-namespace
```


### BDRS Connector:
```bash
helm upgrade --install my-bdrs \
  smart-systems-hub/bdrs-server \
  --version 0.5.6 \
  -f bdrs-values.yaml \
  -n bdrs \
  --create-namespace
```

## Key Differences from Upstream

Our charts are pre-configured with:

* KYMA API Rules for automatic public exposure
* Security contexts optimized for our environment
* Standardized labels and annotations for consistent monitoring
* Sensible defaults for Smart Systems Hub infrastructure

## Version Information

* Factory-X Connector: Latest version 0.1.4
* Tractus-X Connector: Latest version 0.11.3
* BDRS Server: Latest version 0.5.6


## Documentation
```bash
helm show values smart-systems-hub/{chart_name}
```

## Support
For issues with these charts, please create an issue in this repository.

