# == Class: adcli
#
# Installs the adcli package and Joins Active Directory using adcli.
#
# === Parameters
#
# [*ad_domain*]
#   Active Directory domain to join using adcli.
#   Required: true
#   Default: undef
#
# [*ad_join_username*]
#   Username to use during AD join operation.
#   Required: true
#   Default: undef
#
# [*ad_join_password*]
#   Password to use during AD join operation.
#   Required: true
#   Default: undef
#
# [*ad_join_ou*]
#   OU to use for computer account creation during AD join operation.
#   Required: true
#   Default: undef
#
# [*ensure*]
#   Set to "absent" to disable and remove packages.
#   Required: false
#   Default: 'present'
#
# === Examples
#
# class {'::adcli':
#   ad_domain        => 'ad.example.com',
#   ad_join_username => 'username',
#   ad_join_password => 'secret',
#   ad_join_ou       => 'ou=container,dc=example,dc=com'
# }
#
# === Authors
#
# Aaron Johnson <acjohnson@pcdomain.com>
#
# === Copyright
#
# Copyright 2016 Aaron Johnson
#
class adcli (
  $ad_domain               = $adcli::params::ad_domain,
  $ad_join_username        = $adcli::params::ad_join_username,
  $ad_join_password        = $adcli::params::ad_join_password,
  $ad_join_ou              = $adcli::params::ad_join_ou,
  Enum['present', 'absent'] $ensure = $adcli::params::ensure,
) inherits adcli::params {

  case $ensure {
    'present': {
      validate_string(
        $ad_domain,
        $ad_join_username,
        $ad_join_password,
        $ad_join_ou
      )

      anchor { 'adcli::begin': } ->
      class { '::adcli::install':
        ensure => $ensure,
      } ->
      class { '::adcli::join': } ->
      anchor { 'adcli::end': }
    }
    default: {
      class { '::adcli::install':
        ensure => $ensure,
      }
    }
  }
}
