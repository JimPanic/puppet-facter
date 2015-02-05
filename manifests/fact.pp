# Class facter::fact
#
# Manage txt based external facts.
#
define facter::fact (
  $value,
  $file      = "${name}.txt",
  $facts_dir = $facter::facts_d_dir,
) {

  include 'facter'

  $match = "^${name}=\\S*$"

  file { "facts_file_${name}":
    ensure  => file,
    path    => "${facts_dir}/${file}",
    owner   => $facter::facts_file_owner,
    group   => $facter::facts_file_group,
    mode    => $facter::facts_file_mode,
  }

  file_line { "fact_line_${name}":
    path  => "${facts_dir}/${file}",
    line  => "${name}=${value}",
    match => $match,
  }
}
