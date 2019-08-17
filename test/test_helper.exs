ExUnit.start()

# Assumes you have 'telnyx-mock' (https://github.com/team-telnyx/telnyx-mock)
# running already on port 12111. If not, the tests will fail.
Application.put_env(:telynx, :base_url, "localhost:12111")
