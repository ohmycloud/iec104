unit class Iec104::ControlDomain::SFrame;

has Buf $.buf is rw;

#| 接收序列号
method receive-serial-number(--> Int) {
    (($.buf[3] +< 8) + $.buf[2]) +> 1
}

method gist(--> Str) {
    sprintf("接收序列号: %s", $.receive-serial-number)
}