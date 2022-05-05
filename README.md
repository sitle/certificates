Howto create a Public Key Infrastructure ?

## Terms & condition

* Root CA expire in 10 years.
* Services CA expire in 5 years.
* Services CA can sign certificates.

## Prerequisite

You need to install this prerequisite :

* make
* wget
* sqlite3

## Setting up

```bash
make setup
# That's it !
```

You will be asked to type your sudo password so the setup can move cfssl binaries in the /usr/local/bin folder.

## Customize it

If you need to customize, you have to edit this files :

* config/csr-rootca.json
* config/csr-servicesca.json

## Let's launch the API server :

```bash
./api-launch.sh
```

** Be aware that the API is not secured before expose it to the public world ! **
