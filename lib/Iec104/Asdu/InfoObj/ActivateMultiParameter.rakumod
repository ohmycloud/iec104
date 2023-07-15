use Iec104::Utilities;
use Iec104::Asdu::InfoObj::Address;

unit module Iec104::Asdu::InfoObj::ActivateMultiParameter;

#| 预置/激活多个参数命令
sub activate-multi-parameter(Buf $info-element, Int $num, Int $ti, Int $sq) is export {
    my $s = "";
    for ^$num -> $i {
        $s ~= sprintf("\t信息对象%s地址：%s\n预置/激活参数命令对象信息值：%s\t%s\t%s\t%s\n",
                $i + 1,
                info-address($info-element[$i * 7], $info-element[$i * 7 + 1], $info-element[$i * 7 + 2]),
                to-hex-string($info-element[$i * 7 + 3]),
                to-hex-string($info-element[$i * 7 + 4]),
                to-hex-string($info-element[$i * 7 + 5]),
                to-hex-string($info-element[$i * 7 + 6])
        );
    }
    $s ~= "\t设定命令限定词QOS：";
    my $last-element = $info-element[$info-element.elems - 1];
    $s ~= to-hex-string($last-element);
    $s ~= "\t";
    $s ~= "\t预置参数" if $last-element == 0x80;
    $s ~= "\t激活参数" if $last-element == 0x00;
    $s ~ "\n"
}
