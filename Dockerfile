FROM jenkins/jenkins:2.277.4-lts

RUN /usr/local/bin/install-plugins.sh \
	git \
	matrix-auth \
	workflow-aggregator \
	docker-workflow \
	credentials-binding \
	slack \
	credentials \
	configuration-as-code

ENV JENKINS_USER admin
ENV JENKINS_PASS admin

# Skip initial setup.
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Copy the startup scripts to the right place.
COPY *.groovy /usr/share/jenkins/ref/init.groovy.d/

# Point the plugin configuration-as-code to its configuration files.
# Do not write to /var/jenkins_home because that is a volume, so it will keep the first written of casc.yaml.
ENV CASC_JENKINS_CONFIG=/var/jenkins_casc_configs
COPY casc.yaml /var/jenkins_casc_configs/

# Create a volume so the data that Jenkins stores is stored between restarts.
VOLUME /var/jenkins_home
