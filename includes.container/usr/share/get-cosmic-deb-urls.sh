#!/bin/bash

API_URL="https://api.github.com/repos/singularityos-lab/cosmic-epoch/releases/tags/continuous"

curl -s "$API_URL" | jq -r '.assets[]
  | select(.name | endswith(".deb"))
  | select(.name | contains("dbgsym") | not)
  | .browser_download_url'
