#!/bin/bash

cfssl serve -db-config=./config/config-db.json -ca=./certs/servicesca/gouv.pf-servicesca.pem -ca-key=./certs/servicesca/gouv.pf-servicesca-key.pem