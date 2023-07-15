unit module Iec104::Utilities;

#| 十六进字符串制转 Float
sub read-float(Str $hex --> Num) is export {
    my $hex-string = $hex.subst('0x', '', :g);
    do given Buf.new {
        .write-int32(0, :16($hex-string), BigEndian)
        .read-num32(0)
    }
}

#| Int 值转十六进制字符串
sub to-hex-string(Int $b) is export {
    my Str $hex = ($b +& 0xFF).base(16);
    if $hex.chars == 1 {
        $hex = '0' ~ $hex;
    }
    '0x' ~ $hex.uc
}