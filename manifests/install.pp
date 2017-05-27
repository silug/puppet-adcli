# == Class: adcli::install
#
# Installs the adcli package.
#
# See README.md for more details
#
class adcli::install (
  Enum['present', 'absent'] $ensure,
) {

  package { 'adcli':
    ensure => $ensure,
  }
}
