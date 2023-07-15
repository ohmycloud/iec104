use Iec104::Utilities;
unit module Iec104::Asdu::VarStructQualifier;

#| 可变结构限定词
sub var-struct-qualifier(Int $buf) is export {
    my $var-struct-qualifier = "可变结构限定词：";
    $var-struct-qualifier ~= to-hex-string($buf);
    $var-struct-qualifier ~= "\t";
    given $buf +& 0x80 {
        when 128 { $var-struct-qualifier ~= "SQ=1 信息元素地址顺序\t"; }
        when 0   { $var-struct-qualifier ~= "SQ=0 信息元素地址非顺序\t" }
        default {}
    }
    $var-struct-qualifier ~= "信息元素个数：";
    $var-struct-qualifier ~= $buf +& 0x7f;
    $var-struct-qualifier
}