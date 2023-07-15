use Iec104::Asdu::InfoObj::Address;
use Iec104::Utilities;
use Iec104::Asdu::InfoObj::PointDesc;

unit module Iec104::Asdu::InfoObj::PointWithoutTime;

#| 不带时标的单双点信息（遥信）
sub no-time-point(Buf $info-element, Int $num, Int $ti, Int $sq) is export {
    my $s = "";
    if $sq == 1 {
        $s ~= "\t信息对象地址：\t";
        $s ~= info-address($info-element[0], $info-element[1], $info-element[2]);

        for ^$num -> $i {
            $s ~= sprintf("\t信息元素%s的信息元素值%s\n%s\n",
                      $i + 1,
                      to-hex-string($info-element[$i + 3]),
                      point($info-element[$i + 3], $ti)
                  );
        }
    } else {
        for 1..$num -> $i {
            $s ~= sprintf("\t信息元素%s的内容如下：\n\t\t信息对象地址：\t%s\n\t\t信息元素值：%s\n\t\t%s\n",
                      $i,
                      info-address($info-element[($i - 1) * 4], $info-element[($i - 1) * 4 + 1], $info-element[($i - 1) * 4 + 2]),
                      to-hex-string($info-element[$i * 4 -1]),
                      point($info-element[$i * 4 - 1], $ti)
                  );
        }
    }
    $s
}
