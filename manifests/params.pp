# == Class gitssh::params
#
# This class is meant to be called from gitssh
# It sets variables according to platform
#
class gitssh::params {
  case $::osfamily {
    'Debian': {
      $mkdir = '/bin/mkdir'
      $git = '/usr/bin/git'
      $gitshell = '/usr/bin/git-shell'
      $grep = '/bin/grep'
      $test = '/usr/bin/test'
    }
    'RedHat': {
      $mkdir = '/usr/bin/mkdir'
      $git = '/usr/bin/git'
      $gitshell = '/usr/bin/git-shell'
      $grep = '/bin/grep'
      $test = '/usr/bin/test'
    }
    'OpenBSD': {
      $mkdir = '/bin/mkdir'
      $git = '/usr/local/bin/git' # installed from pkg_add
      $gitshell = '/usr/local/bin/git-shell'
      $grep = '/usr/bin/grep'
      $test = '/bin/test'
    }
    default: {}
  }
}
