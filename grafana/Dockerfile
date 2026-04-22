FROM grafana/grafana

# Install plugins
RUN grafana cli plugins install grafana-piechart-panel

# Provision Prometheus as the default data source.
COPY provisioning /etc/grafana/provisioning
