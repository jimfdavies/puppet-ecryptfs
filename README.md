puppet-ecryptfs
===============

Simple Puppet module to demonstrate installation of EcryptFS utils on RHEL/Centos.

Encrypts given directory using given passphrase stored in a root-protected keyfile.

Also creates a test file called 'testfile' in given directory.

Please DO NOT use this Puppet module to protect your sensitive data! Use it to understand Ecryptfs working in its most basic way.
There's some great documentation out there on use cases and how to do key management in a way best for you.
