unit module Iec104::Asdu::InfoObj::Address;

#| 信息对象地址转换
#| 3 个字节
#| $i bit0-bit7, $j bit8-bit15, $k bit16-bit23
sub info-address(Int $i, Int $j, Int $k --> Str) is export {
    my Int $add = ($k +< 16) + ($j +< 8) + $i;

    sprintf("十进制：%s, 十六进制：%02X%02X%02X",
            $add, $k, $j, $i)
}

#| 十进制的信息对象地址
sub info-obj-addr(Int $i, Int $j, Int $k --> Int) is export {
    ($k +< 16) + ($j +< 8) + $i
}
