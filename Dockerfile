FROM jenkins/jenkins:2.263.1-lts

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
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc_configs
COPY *.yaml /var/jenkins_home/casc_configs/

VOLUME /var/jenkins_home
