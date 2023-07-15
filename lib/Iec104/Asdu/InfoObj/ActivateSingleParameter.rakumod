use Iec104::Utilities;
use Iec104::Asdu::InfoObj::Address;

unit module Iec104::Asdu::InfoObj::ActivateSingleParameter;

sub activate-single-parameter(Buf $info-element, Int $num, Int $ti, Int $sq) is export {
    my $s = "";
    $s ~= sprintf(
            "\t信息对象地址：%s\n预置/激活参数命令对象信息值：%s\t%s\t%s\t%s\n设定命令限定词：%s\t",
            info-address($info-element[0], $info-element[1], $info-element[2]),
            to-hex-string($info-element[3]),
            to-hex-string($info-element[4]),
            to-hex-string($info-element[5]),
            to-hex-string($info-element[6]),
            to-hex-string($info-element[7])
                               );
    $s ~= "\t预置参数" if $info-element[7] == 0x80;
    $s ~= "\t激活参数" if $info-element[7] == 0x00;
    $s ~ "\n"
}
