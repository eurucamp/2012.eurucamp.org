#!/bin/bash
set -e

bundle exec middleman build
aws s3 sync build s3://2012.eurucamp.org --acl public-read --cache-control "public, max-age=86400"
