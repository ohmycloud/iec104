unit class Message;

has Buf $.header;
has Buf $.apdu-length;
has Buf $.ctrl-domain;
has Buf $.type-identifier;
has Buf $.qualifier;
has Buf $.trans-reason;
has Buf $.terminal-id;
has Buf $.info-obj-addr;
has Buf $.asdu;