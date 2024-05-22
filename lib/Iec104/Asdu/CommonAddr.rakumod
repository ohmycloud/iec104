unit module Iec104::Asdu::CommonAddr;

#| 解析 ASDU 公共地址
sub common-address(Buf $buf --> Int) is export {
    ($buf[1] +& 0xFF) +< 8 +| ($buf[0] +& 0xFF)
}