# == Class: adcli::join
#
# Uses adcli to join to an Active Directory domain.
#
# See README.md for more details
#
class adcli::join (
  $ad_domain        = $adcli::ad_domain,
  $ad_join_username = $adcli::ad_join_username,
  $ad_join_password = $adcli::ad_join_password,
  $ad_join_ou       = $adcli::ad_join_ou
) {
  if $ad_domain == undef {
    notify {'For Active Directory join to work you must specify the ad_domain parameter.':}
  }
  elsif $ad_join_username == undef {
    notify {'For Active Directory join to work you must specify the ad_join_username parameter.':}
  }
  elsif $ad_join_password == undef {
    notify {'For Active Directory join to work you must specify the ad_join_password parameter.':}
  }
  elsif $ad_join_ou == undef {
    notify {'For Active Directory join to work you must specify the ad_join_ou parameter.':}
  }
  else {
    exec {'adcli_join':
      command   => "/bin/echo -n \'${ad_join_password}\' | /usr/sbin/adcli join --login-user=\'${ad_join_username}\' --domain=\'${ad_domain}\' --domain-ou=\'${ad_join_ou}\' --stdin-password --verbose",
      logoutput => true,
      creates   => '/etc/krb5.keytab',
    }
  }
}
