use Iec104::Utilities;
use Iec104::Asdu::InfoObj::Address;

unit module Iec104::Asdu::InfoObj::SingleCommand;

#| 单命令信息解析
#| $info-element 信息元素集报文
#| $num 信息元素的格式
#| $ti 类型标识
sub single-command(Buf $info-element, Int $num, Int $ti) is export {
    my $s = "";
    $s ~= sprintf("\t信息元素地址：%s\n单命令 SCO:\t%s\n",
              info-address($info-element[0], $info-element[1], $info-element[2]),
              to-hex-string($info-element[3])
          );
    $s ~= "\t遥控选择命令\t" if $info-element[3] +& 0x80 == 128;
    $s ~= "\t遥控执行命令\t" if $info-element[3] +& 0x80 == 0;
    $s ~= "\t开关合\t"      if $info-element[3] +& 0x01 == 1;
    $s ~= "\t开关分\t"      if $info-element[3] +& 0x01 == 0;
    $s
}