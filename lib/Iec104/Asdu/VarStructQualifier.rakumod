use Iec104::Utilities;
unit module Iec104::Asdu::VarStructQualifier;

#| 可变结构限定词
sub var-struct-qualifier(Int $buf) is export {
    my %sq = gather for $buf +& 0x80 {
        when 128 { take 'sq' => 1 }
        when 0   { take 'sq' => 0 }
        default { take Hash.new }
    };
#    %sq['info_obj_num'] = $buf +& 0x7f;
    %sq
}