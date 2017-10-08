# == Class gitssh::params
#
# This class is meant to be called from gitssh
# It sets variables according to platform
#
class gitssh::params {
  case $::osfamily {
    'Debian': {
#      Exec { path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/' }
#      $mkdir = '/bin/mkdir',
#      $git = '/usr/bin/git',
      $gitshell = '/usr/bin/git-shell'
    }
    'RedHat': {
#      Exec { path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/' }
#      $mkdir = '/usr/bin/mkdir',
#      $git = '/usr/bin/git',
      $gitshell = '/usr/bin/git-shell'
#      $test = '/usr/bin/test'
    }
    'OpenBSD': {
#      Exec { path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/:/usr/local/bin' }
#      $mkdir = '/bin/mkdir',
#      $git = '/usr/local/bin/git', # installed from pkg_add
      $gitshell = '/usr/local/bin/git-shell'
#      $test = '/bin/test'
    }
    default: { }
  }
}
