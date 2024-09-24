#!/usr/bin/with-contenv sh

if [ -z "$MAILBOX" ]; then
	echo "
ERROR: 'MAILBOX' environemnt variable must be set
"
	exit 1
fi

if [ ! -d /mail ]; then
	echo "
ERROR: '/mail' directory must be mounted
"
	exit 1
fi

if [ ! -d "/mail/${MAILBOX}" ]; then
	mkdir -p "/mail/${MAILBOX}"
	chown abc:abc "/mail/${MAILBOX}"
fi

if [ ! -f /config/mbsync.rc ]; then
    if [ ! -z "$PASSWORD" ]; then
	    cp /config/mbsync.rc.login /config/mbsync.rc
    elif [ ! -z "$PASSWORD_FILE" ]; then
	    cp /config/mbsync.rc.xoauth2 /config/mbsync.rc
    else
        echo "
ERROR: Either 'PASSWORD' or 'PASSWORD_FILE' environemnt variable must be set
"
        exit 1
    fi
	sed -i "s/{mailbox}/${MAILBOX}/g" /config/mbsync.rc
	sed -i "s/{imap_host}/${IMAP_HOST}/g" /config/mbsync.rc
	sed -i "s/{imap_port}/${IMAP_PORT}/g" /config/mbsync.rc
	sed -i "s/{username}/${USERNAME}/g" /config/mbsync.rc
	sed -i "s{password}${PASSWORD}g" /config/mbsync.rc
	sed -i "s{password_file}${PASSWORD_FILE}g" /config/mbsync.rc
	sed -i "s/{ssl_type}/${SSL_TYPE}/g" /config/mbsync.rc
	sed -i "s/{ssl_versions}/${SSL_VERSIONS}/g" /config/mbsync.rc
fi
