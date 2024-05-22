use Iec104::Asdu::InfoObj::PointWithoutTime;
use Iec104::Asdu::InfoObj::PointWithTime;
use Iec104::Asdu::InfoObj::Normalization;
use Iec104::Asdu::InfoObj::Standardization;
use Iec104::Asdu::InfoObj::ShortFloat;
use Iec104::Asdu::InfoObj::SingleCommand;
use Iec104::Asdu::InfoObj::DoubleCommand;
use Iec104::Asdu::InfoObj::SingleParameter;
use Iec104::Asdu::InfoObj::MultiParameter;
use Iec104::Asdu::InfoObj::ActivateSingleParameter;
use Iec104::Asdu::InfoObj::ActivateMultiParameter;
use Iec104::Asdu::InfoObj::TimeScale;
use Iec104::Asdu::InfoObj::Address;

unit module Iec104::Asdu::InfoObj;

#| info 信息地址+信息元素+限定词+[时标]
#| $k 信息体个数, $i 类型标识, $j SQ 可变结构限定词,
sub info-object(Buf $info, Int $i, Int $j, Int $k) is export {
    given $i {
        when 1|3 { no-time-point($info, $k, $i, $j) }
        when 9   { normalization($info, $k, $i, $j) }
        when 11  { standardization($info, $k, $i, $j) }
        when 13  { short-float($info, $k, $i, $j) }
        when 30 | 31 { time-point($info, $k, $i, $j) }
        when 45 { single-command($info, $k, $i) }
        when 46 { double-command($info, $k, $i) }
        when 48 { activate-single-parameter($info, $k, $i, $j) }
        when 102 { single-parameter($info, $k, $i, $j) }
        when 132 { multi-parameter($info, $k, $i, $j) }
        when 136 { activate-multi-parameter($info, $k, $i, $j) }
        default { Hash.new }
    }
}
