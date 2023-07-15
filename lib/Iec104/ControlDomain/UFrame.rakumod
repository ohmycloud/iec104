unit class Iec104::ControlDomain::UFrame;

has Buf $.buf is rw;

class Command {
    has Str $.command is rw;
    has Str $.type is rw;

    method gist(--> Str) {
        "$.command: $.type"
    }
}

method control-function(--> Command) {
    Command.new(command => "TESTFR", type => "确认") if $.buf[0] +& 0xC0 == 128;
    Command.new(command => "TESTFR", type => "命令") if $.buf[0] +& 0xC0 == 64;
    Command.new(command => "STOPDT", type => "确认") if $.buf[0] +& 0x30 == 32;
    Command.new(command => "STOPDT", type => "命令") if $.buf[0] +& 0x30 == 16;
    Command.new(command => "STARTDT", type => "确认") if $.buf[0] +& 0x0C == 8;
    Command.new(command => "STARTDT", type => "命令") if $.buf[0] +& 0x0C == 4;
    Command.new(command => "", type => "")
}

method gist() {
    $.control-function.gist
}