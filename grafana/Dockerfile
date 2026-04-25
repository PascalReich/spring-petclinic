FROM grafana/grafana:11.4.0

# Install plugins
RUN grafana cli plugins install grafana-piechart-panel

# Provision Prometheus and the Jenkins dashboard from code (stops having to do it manually in the UI)
COPY provisioning /etc/grafana/provisioning
# NOTE: If you want to add/edit dashboards then create the changes manually using the UI
# and export them as code and add them to the current json or a new json. Editing the code 
# directly is not recommended as there are far to many parameters and configurations which can
# be easily missed.
COPY dashboards /etc/grafana/dashboards
