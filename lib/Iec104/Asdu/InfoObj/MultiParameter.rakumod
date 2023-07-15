use Iec104::Utilities;
use Iec104::Asdu::InfoObj::Address;

unit module Iec104::Asdu::InfoObj::MultiParameter;

#| 读取多个参数命令(参数设置)
sub multi-parameter(Buf $info-element, Int $num, Int $ti, Int $sq) is export {
    my $s = "";
    for ^$num -> $i {
        $s ~= sprintf("\t信息对象：%s 地址：%s\n参数设置对象信息值：%s\t%s\t%s\t%s\n",
                  $i + 1,
                  info-address($info-element[$i * 7], $info-element[$i * 7 + 1], $info-element[$i * 7 + 2]),
                  to-hex-string($info-element[$i * 7 + 3]),
                  to-hex-string($info-element[$i * 7 + 4]),
                  to-hex-string($info-element[$i * 7 + 5]),
                  to-hex-string($info-element[$i * 7 + 6]),
              );
    }
    $s
}
