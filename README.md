## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

  helm repo add mycharts https://Smart-Systems-Hub.github.io/helm-charts

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
mycharts to see the charts.

To install the <bdrs> chart:

    helm install my-bdrs mycharts/bdrs

To uninstall the chart:

    helm uninstall my-bdrs

To install the <edc> chart:

    helm install my-edc mycharts/edc

To uninstall the chart:

    helm uninstall my-edc

