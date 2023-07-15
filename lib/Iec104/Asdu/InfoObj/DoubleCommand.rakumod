use Iec104::Utilities;
use Iec104::Asdu::InfoObj::Address;

unit module Iec104::Asdu::InfoObj::DoubleCommand;

#| 双命令信息解析
#| $info-element 信息元素集报文
#| $num 信息元素的个数
#| $ti 类型标识
sub double-command(Buf $info-element, Int $num, Int $ti) is export {
    my $s = "";
    $s ~= sprintf("\t信息元素地址：%s\n双命令 DCO：%s\t\n",
              info-address($info-element[0], $info-element[1], $info-element[2]),
              to-hex-string($info-element[3])
          );

    $s ~= "\t遥控选择命令\t" if $info-element[3] +& 0x80 == 128;
    $s ~= "\t遥控执行命令\t" if $info-element[3] +& 0x80 == 0;
    $s ~= "\t不允许，有错误\t" if $info-element[2] +& 0x03 == 0;
    $s ~= "\t开关分\t" if $info-element[3] +& 0x03 == 1;
    $s ~= "\t开关合\t" if $info-element[3] +& 0x03 == 2;
    $s ~= "\t不允许，有错误" if $info-element[3] +& 0x03 == 3;
    $s
}
