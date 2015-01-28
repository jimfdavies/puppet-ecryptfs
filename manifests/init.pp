class ecryptfs ($enc_dir = '/opt/data',
                $key_file = '/root/.ecryptfs/key',
                $passphrase = 'private')
{
      package { 'ecryptfs-utils':
        ensure => installed,
      }

      file { $enc_dir:
        ensure  => directory,
      }

      file { $key_file:
        ensure  => present,
        recurse => true,
        content => "passphrase_passwd=[$passphrase]",
      }

      mount {$enc_dir:
        device  => $enc_dir,
        fstype  => 'ecryptfs',
        options => "key=passphrase:passphrase_passwd=$passphrase,ecryptfs_passthrough=no,ecryptfs_enable_filename_crypto=n,ecryptfs_unlink_sigs,ecryptfs_key_bytes=16,ecryptfs_cipher=aes",
        atboot  => true,
        ensure  => mounted,
        require => [ Package['ecryptfs-utils'], File[$key_file] ],
      }

      file { 'test_file':
        path    => "$enc_dir/test.txt",
        ensure  => present,
        content => "testing",
        require => Mount[$enc_dir],
      }

}
