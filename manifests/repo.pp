# Define: gitssh::repo
# ===========================
define gitssh::repo(
  $ensure = present,
  ) {
  include '::gitssh'
  include '::gitssh::params'

  $basedir = $::gitssh::basedir
  $dirname = "${basedir}/${title}.git"

  if $ensure == present {
    exec { "mkdir ${dirname}":
      unless  => "test -d ${dirname}",
      user    => 'git',
      require => Package[$::gitssh::package_name],
      notify  => Exec["create_repo ${title}"],
      path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/:/usr/local/bin'
    }

    exec { "create_repo ${title}":
      command     => "git --bare init",
      cwd         => $dirname,
      refreshonly => true,
      user        => 'git',
      path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/:/usr/local/bin'
    }
  } elsif $ensure == absent {
    file { $dirname:
      ensure => absent,
    }
  } else {
    fail("Unknow value '${ensure}' passed to ensure!")
  }
}
