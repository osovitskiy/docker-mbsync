IMAPAccount {mailbox}
Host {imap_host}
Port {imap_port}
User {username}
Pass {password}
AuthMechs LOGIN
SSLType {ssl_type}
SSLVersions {ssl_versions}

IMAPStore {mailbox}-remote
Account {mailbox}
UseNamespace no

MaildirStore {mailbox}-local
Path /mail/{mailbox}/
Inbox /mail/{mailbox}/INBOX/
SubFolders Verbatim

Channel {mailbox}
Master :{mailbox}-remote:
Slave :{mailbox}-local:
Patterns *
Create Slave
Expunge Slave
CopyArrivalDate yes
Sync Pull
SyncState *