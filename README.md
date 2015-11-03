# abacups
Single computer Abaqus job queue using [CUPS](http://www.cups.org/) print spooler

Abaqus is run as the lp user so permissions must allow write access for that user to job and scratch directories.

Having the print spooler execute Abaqus jobs is not compatible with default security policies in [SELinux](https://en.wikipedia.org/wiki/Security-Enhanced_Linux).
