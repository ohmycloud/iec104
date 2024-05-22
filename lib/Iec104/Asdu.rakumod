use Iec104::Asdu::TypeIdentifier;
use Iec104::Asdu::VarStructQualifier;
use Iec104::Asdu::TransReason;
use Iec104::Asdu::CommonAddr;
use Iec104::Asdu::InfoObj;

unit module Iec104::Asdu;

#| 解析 ASDU 数据
sub asdu-message(Buf $b) is export {
    my %sq = var-struct-qualifier($b[1]);
    my $transmission-reason = trans-reason($b[2], $b[3]);
    my $terminal_id = common-address(Buf.new($b[4..5]));
    my Buf $asdu = Buf.new($b[6..*]);
    my %info-object = info-object($asdu, $b[0], ($b[1] +& 0x80) +> 7, ($b[1] +& 0x7f));
    %info-object.append(%sq);
    %info-object{'terminal-id'} = $terminal_id;
    %info-object{'type-identifier'} = $b[0];

    %info-object
}