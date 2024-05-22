unit class Iec104::ControlDomain::IFrame;

has Buf $.buf is rw;

#| 发送序列号
method send-serial-number(--> Int) {
    (($.buf[1] +< 8) + $.buf[0]) +> 1
}

#| 接收序列号
method receive-serial-number(--> Int) {
    (($.buf[3] +< 8) + $.buf[2]) +> 1
}

method gist(--> Str) {
    sprintf("send serial number: %s, receive serial number: %s", $.send-serial-number, $.receive-serial-number)
}