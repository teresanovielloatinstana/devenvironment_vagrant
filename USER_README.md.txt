# GCLOUD NOTES
Install GCLOUD SDK from
$HOME/google-cloud-sdk/
(downloaded from https://cloud.google.com/sdk/docs/install)
cd $HOME/google-cloud-sdk/
./google-cloud-sdk/install.sh
Open a new terminal so that the changes take effect.
gcloud init
choose instana-qa-php [28]
gcloud auth login
gcloud auth configure-docker

# GIT
URL https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar

# Instana Agent
URL: https://release-instana.instana.rocks/#
cd AGENT_INSTALL
curl -o setup_agent.sh https://setup.instana.io/agent && chmod 700 ./setup_agent.sh && sudo ./setup_agent.sh -a $INSTANA_AGENT_KEY -d $DOWNLOAD_KEY -t dynamic -e ingress-magenta-saas.instana.rocks:443  -y -s

# Development repositories
## PHP
### Development Extension pack
git clone git@github.com:aovcharov-instana/php-extension-devpack.git
mv php-extension-devpack scripts ; ln -fs scripts php-extension-devpack

### PHP Extensions
git clone git@github.com:instana/php-extensions.git

## QA-QMS
git clone git@github.com:instana/qa-qms.git

# PHP
