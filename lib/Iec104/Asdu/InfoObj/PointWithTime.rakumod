use Iec104::Utilities;
use Iec104::Asdu::InfoObj::Address;
use Iec104::Asdu::InfoObj::PointDesc;
use Iec104::Asdu::InfoObj::TimeScale;

unit module Iec104::Asdu::InfoObj::PointWithTime;

#| 带CP56Time2a时标的单双点信息（遥信）
sub time-point(Buf $info-element, Int $num, Int $ti, Int $sq) is export {
    my $s = "";
    if $sq == 0 {
        for 1..$num -> $i {
            $s ~= sprintf(
                      "\t信息元素%s的内容如下：\n\t\t信息对象地址：%s\n\t\t信息元素值：%s\n\t\t%s\n",
                      $i,
                      info-address($info-element[($i - 1) * 11], $info-element[($i - 1) * 11 + 1], $info-element[($i - 1) * 11 + 2]),
                      to-hex-string($info-element[($i - 1) * 11 + 3]),
                      point($info-element[($i - 1) * 11 + 3], $ti)
                  );

            my Buf $time = Buf.new([$info-element[($i - 1) * 11 + 4 + $_] for ^7]);
            $s ~= time-scale($time);
        }
    } else {
        $s ~= "\t按照DL/T 634.5101-2002规定，带长时标的单/双点信息遥信报文并不存在信息元素序列（SQ=1）的情况。";
    }
    $s
}
