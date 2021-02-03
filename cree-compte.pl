#!/usr/bin/perl

use Net::LDAP;

$ldap = Net::LDAP->new('ldap') or die "$@";
$mesg = $ldap->bind('cn=admin,dc=mondomaine,dc=fr',
               password => 'toto'
                );

$result = $ldap->add("uid=$ARGV[1].$ARGV[0],ou=People,dc=mondomaine,dc=fr",
          attr=> [
	    'objectclass' => ['top','inetOrgPerson','posixAccount',
	                       'shadowAccount' ],
	    'uid' => "$ARGV[1].$ARGV[0]",
	    'cn' => "$ARGV[0] $ARGV[1]",
	    'sn' => "$ARGV[0] $ARGV[1]",
	    'userPassword' => "$ARGV[4]",
	    'shadowLastChange' => "14550",
	    'shadowMax' => "99999",
	    'shadowWarning' => "7",
	    'loginShell' => "/bin/bash",
	    'uidNumber' => "$ARGV[2]",
	    'gidNumber' => "$ARGV[3]",
	    'homeDirectory' => "/home/$ARGV[0].$ARGV[1]",
	    'mail' => "$ARGV[1].$ARGV[0]\@mondomaine.fr",
	    'gecos' => "$ARGV[0] $ARGV[1],,,"
	    ]
	    );
$result->code && warn "failed to add entry: ", $result-> error;
$mesg = $ldap->unbind;
