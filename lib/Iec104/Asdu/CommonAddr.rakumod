unit module Iec104::Asdu::CommonAddr;

#| 解析 ASDU 公共地址
sub common-address(Int $low, Int $high --> Str) is export {
    my $low-string  = sprintf("%02X", $low);
    my $high-string = sprintf("%02X", $high);

    $high-string ~ $low-string ~ "H" ~ "\n"
}