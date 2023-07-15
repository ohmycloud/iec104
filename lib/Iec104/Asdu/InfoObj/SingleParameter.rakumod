use Iec104::Utilities;
use Iec104::Asdu::InfoObj::Address;

unit module Iec104::Asdu::InfoObj::SingleParameter;

#| 读取单个参数命令(参数设置)
sub single-parameter(Buf $info-element, Int $num, Int $ti, Int $sq) is export {
    my $s = "";
    $s ~= sprintf(
              "\t信息对象地址：%s\n参数设置对象信息值：%s\t%s\t%s\t%s\n",
              info-address($info-element[0], $info-element[1], $info-element[2]),
              to-hex-string($info-element[3]),
              to-hex-string($info-element[4]),
              to-hex-string($info-element[5]),
              to-hex-string($info-element[6]),
          );
    $s
}
