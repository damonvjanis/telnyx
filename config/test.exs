use Mix.Config

# Assumes you have 'telnyx-mock' (https://github.com/team-telnyx/telnyx-mock)
# running already on port 12112, which is the default port using https.
# If not, the tests will fail.
config :telnyx, :base_url, "https://localhost:12112/"

config :logger,
  level: :warn
