# Copy Personal data
# ssh: adjust permissions, add new key
1. sudo chmod 700 .ssh
2. sudo chmod 600 id_ed25519
3. ssh-add ~/.ssh/id_ed25519
4. [confirmation] ssh-add -l

# Personal notes - private repository
git clone git@github.com:teresanovielloatinstana/blackmamba_personalnotes.git

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
Tutorials are at https://cloud.google.com/sdk/auth_success

# GIT
URL https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar

# Instana Agent
URL: https://release-instana.instana.rocks/#
cd AGENT_INSTALL
# remember to substitute the variables
curl -o setup_agent.sh https://setup.instana.io/agent && chmod 700 ./setup_agent.sh && sudo ./setup_agent.sh -a $INSTANA_AGENT_KEY -d $DOWNLOAD_KEY -t dynamic -e ingress-magenta-saas.instana.rocks:443  -y -s

# Development repositories
## PHP
### Development Extension pack
git clone git@github.com:aovcharov-instana/php-extension-devpack.git
mv php-extension-devpack scripts ; ln -fs scripts php-extension-devpack
### PHP Extensions
git clone git@github.com:instana/php-extensions.git
git clone git@github.com:instana/instana-php-opentracing
git clone git@github.com:instana/instana-php-sdk
git clone git@github.com:instana/php-demo-app
# RabbitMQ
git clone git@github.com:php-amqplib/RabbitMqBundle.git

## QA-QMS
git clone git@github.com:instana/qa-qms.git

## ROBOT-SHOP
git clone git@github.com:instana/robot-shop.git

# C
git clone git@github.com:instana/autotrace-mutating-webhook
git clone git@github.com:instana/cpp-sensor
git clone git@github.com:instana/nginx-tracing

# demo
git clone git@github.com:instana/demo.git

# QA
# instana-agent-qa-test
git clone git@githubgit@github.ibm.com:instana/instana-agent-qa-test.git

# AGENT
git clone git@github.com:instana/agent
git clone git@github.com:instana/agent-updates
git clone git@github.com:instana/agent-update-site

# BACKEND
git clone git@github.com:instana/backend
ln -fs backend/fobackend/forge/src/main/java/com/instana/forge/connection/ backend_span_plugin

# UI-CLIENT
git clone git@github.com:instana/ui-client
ln -fs ui-client/packages/in-forge/tracing/ frontend_span_detail_view

# SENSORS
git clone git@github.com:instana/sensors

# DELIVERY-INFRA
git clone git@github.com:instana/delivery-infra

# documentation
git clone git@github.com:instana/technical-documentation

# BFG
# URL: https://rtyley.github.io/bfg-repo-cleaner/

1. git clone --mirror git://example.com/some-big-repo.git // this will create the directory some-big-repo.git
2. bfg --delete-files id_{dsa,rsa}  my-repo.git // this will destroy the files dsa, rsa from my-repo.git
