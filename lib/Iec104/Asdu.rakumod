use Iec104::Asdu::TypeIdentifier;
use Iec104::Asdu::VarStructQualifier;
use Iec104::Asdu::TransReason;
use Iec104::Asdu::CommonAddr;
use Iec104::Asdu::InfoObj;

unit module Iec104::Asdu;

#| 解析 ASDU 数据
sub asdu-message(Buf $b) is export {
    my $type-identifier = type-identifier-values($b[0]);
    my $mutable-structure-qualifier = var-struct-qualifier($b[1]);
    my $transmission-reason = trans-reason($b[2], $b[3]);
    my $asdu-common-address = common-address($b[4], $b[5]);
    my Buf $info = Buf.new($b[6..*]);
    my $info-object-str = info-object($info, $b[0], ($b[1] +& 0x80) +> 7, ($b[1] +& 0x7f));

    say "\t类属性标识符[7th byte]：" ~ $type-identifier;
    say "\t可变结构限定词[8th byte]：" ~ $mutable-structure-qualifier;
    say "\t传送原因[9th byte - 10th byte]：" ~ $transmission-reason;
    say "\t应用服务数据单元公共地址[11th byte - 12th byte]：" ~ $asdu-common-address;
    say $info-object-str;
}