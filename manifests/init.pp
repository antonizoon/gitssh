# Class: gitssh
# ===========================
class gitssh(
  $basedir        = '/var/git',
  $clients        = [],
  $package_ensure = present,
  $package_name   = 'git',
  $purge_ssh_keys = true,
  $repos          = [],
  $gitshell = '/usr/local/bin/git-shell'
  ) {
  package { $package_name:
    ensure => $package_ensure,
  }

  exec { "/bin/echo git-shell >> /etc/shells":
    unless => "grep -q '^$gitshell$' /etc/shells",
    before => User['git'],
    path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/:/usr/local/bin'
  }

  if versioncmp($::puppetversion,'3.6.0') >= 0 {
    User {
      purge_ssh_keys => $purge_ssh_keys,
    }
  } elsif $purge_ssh_keys {
    warning('gitssh::purge_ssh_keys is ignored in Puppet < 3.6.0.')
    warning('To disable this warning, set gitssh::purge_ssh_keys to false.')
  }

  user { 'git':
    ensure     => present,
    home       => $basedir,
    shell      => "$gitshell",
    managehome => true,
    require    => Package[$package_name],
  }

  if size($clients) > 0 {
    create_resources(gitssh::client, $clients)
  }

  if size($repos) > 0 {
    create_resources(gitssh::repo, $repos)
  }
}
