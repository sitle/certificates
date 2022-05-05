# xD

all: clean regen

clean:
	@rm -fr ./certs/rootca/*
	@rm -fr ./certs/servicesca/*
	@rm -fr ./database/certstore.db

reset: clean
	@rm -fr ./bin/*

regen: rootca servicesca

rootca:
	@cfssl gencert -config ./config/config-rca.json -initca ./config/csr-rootca.json | cfssljson -bare ./certs/rootca/gouv.pf-rootca
	@ls -l ./certs/rootca/*

servicesca:
	@cfssl gencert -config ./config/config-sca.json -initca ./config/csr-servicesca.json | cfssljson -bare ./certs/servicesca/gouv.pf-servicesca
	@cfssl sign -ca ./certs/rootca/gouv.pf-rootca.pem -ca-key ./certs/rootca/gouv.pf-rootca-key.pem -config ./config/config-sca.json ./certs/servicesca/gouv.pf-servicesca.csr | cfssljson -bare ./certs/servicesca/gouv.pf-servicesca
	@ls -l ./certs/servicesca/*

db:
	@cat ./config/setup-db.sql | sqlite3 ./database/certstore.db

setup: reset db regen
	@wget -c https://github.com/cloudflare/cfssl/releases/download/v1.6.1/cfssl-bundle_1.6.1_linux_amd64 -O ./bin/cfssl-bundle
	@wget -c https://github.com/cloudflare/cfssl/releases/download/v1.6.1/cfssl-certinfo_1.6.1_linux_amd64 -O ./bin/cfssl-certinfo
	@wget -c https://github.com/cloudflare/cfssl/releases/download/v1.6.1/cfssl-newkey_1.6.1_linux_amd64 -O ./bin/cfssl-newkey
	@wget -c https://github.com/cloudflare/cfssl/releases/download/v1.6.1/cfssl-scan_1.6.1_linux_amd64 -O ./bin/cfssl-scan
	@wget -c https://github.com/cloudflare/cfssl/releases/download/v1.6.1/cfssljson_1.6.1_linux_amd64 -O ./bin/cfssljson
	@wget -c https://github.com/cloudflare/cfssl/releases/download/v1.6.1/cfssl_1.6.1_linux_amd64 -O ./bin/cfssl
	@wget -c https://github.com/cloudflare/cfssl/releases/download/v1.6.1/mkbundle_1.6.1_linux_amd64 -O ./bin/mkbundle
	@wget -c https://github.com/cloudflare/cfssl/releases/download/v1.6.1/multirootca_1.6.1_linux_amd64 -O ./bin/multirootca
	@chmod +x ./bin/*
	@sudo cp -pfr ./bin/cfssl* ./bin/mkbundle ./bin/multirootca /usr/local/bin/
