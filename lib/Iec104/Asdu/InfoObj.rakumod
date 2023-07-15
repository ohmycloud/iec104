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
#| $i 类型标识, $j SQ 可变结构限定词, $k 信息体个数
sub info-object(Buf $info, Int $i, Int $j, Int $k) is export {
    my $s = "";
    given $i {
        when 1|3 { $s ~= no-time-point($info, $k, $i, $j) }
        when 9   { $s ~= normalization($info, $k, $i, $j) }
        when 11  { $s ~= standardization($info, $k, $i, $j) }
        when 13  { $s ~= short-float($info, $k, $i, $j) }
        when 30 | 31 { $s ~= time-point($info, $k, $i, $j) }
        when 45 { single-command($info, $k, $i) }
        when 46 { double-command($info, $k, $i) }
        when 48 { activate-single-parameter($info, $k, $i, $j) }
        when 70 {
            $s ~= sprintf("\t信息对象地址：%s\n\t初始化原因：%s", info-address($info[0], $info[1], $info[2]), $info[3]);
            $s ~= $info[3] == 0 ?? "当地电源合上" !! $info[3] == 1 ?? "当地手动复位" !! $info[3] == 2 ?? "远方复位" !! "使用保留";
        }
        when 100 {
            $s ~= "\t信息对象地址：";
            $s ~= info-address($info[0], $info[1], $info[2]);
            $s ~= "\n";
            if ($info[3] == 20) {
                $s ~= "\t召唤限定词QOI：20";
            } else {
                $s ~= "\t召唤限定词出错！当前值为 0x" ~ sprintf("%02X", $info[3]) ~ "，正确值应为 0x14";
            }
        }
        when 102 { $s ~= single-parameter($info, $k, $i, $j) }
        when 103 {
            $s ~= sprintf("\t信息对象地址：%s\n", info-address($info[0], $info[1], $info[2]) );
            my Buf $time = Buf.new([$info[3 + $_] for ^7]);
            $s ~= time-scale($time);
        }
        when 105 {
            $s ~= sprintf("\t信息对象地址：%s\n", info-address($info[0], $info[1], $info[2]));
            if $info[3] == 1 {
                $s ~= "\t复位进程限定词：1";
            } else {
                $s ~= "\t复位进程限定词出错！当前值为0x" ~
                        sprintf("%02X", $info[3]) ~ "，正确值应为0x01";
            }

        }
        when 132 {
            $s ~= multi-parameter($info, $k, $i, $j);
        }
        when 136 {
            $s ~= activate-multi-parameter($info, $k, $i, $j);
        }
        default { $s = "\t类型标识出错，无法解析信息对象！" }
    }
    $s
}
