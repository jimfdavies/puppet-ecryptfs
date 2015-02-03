class ecryptfs ($enc_dir = '/opt/data',
                $passwd_file = '/root/key',
                $passphrase = 'private',
                $key_bytes = 16,
                $cipher = aes)
{
      package { 'ecryptfs-utils':
        ensure => installed,
        allow_virtual => false,
      }

      file { $enc_dir:
        ensure  => directory,
      }

      file { $passwd_file:
        ensure  => present,
        recurse => true,
        mode    => 0400,
        content => "passphrase_passwd=[$passphrase]",
        require => Package['ecryptfs-utils'],
      }

      mount {$enc_dir:
        device    => $enc_dir,
        fstype    => 'ecryptfs',
        options   => "defaults,key=passphrase:passphrase_passwd_file=$passwd_file,ecryptfs_passthrough=no,ecryptfs_enable_filename_crypto=n,ecryptfs_unlink_sigs,ecryptfs_key_bytes=$key_bytes,ecryptfs_cipher=$cipher,no_sig_cache",
        atboot    => true,
        ensure    => mounted,
        remounts  => false,
        require   => [ Package['ecryptfs-utils'], File[$passwd_file] ],
      }

      file { 'test_file':
        path    => "$enc_dir/alive",
        ensure  => present,
        content => "We are glad you can read this.\n",
        require => Mount[$enc_dir],
      }
}
