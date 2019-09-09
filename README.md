# Abacups
Simple computer job queue using [CUPS](http://www.cups.org/) print spooler

## Install
Clone this repository and run `install.sh` to setup cups "printer".
Merge settings from `customQueue.env` into your `abaqus_v6.env` .

## Uninstall
```bash
$ lpadmin -x runjob
```

## Security
Having the print spooler execute CAE jobs is not compatible with default security policies in [SELinux](https://en.wikipedia.org/wiki/Security-Enhanced_Linux).
