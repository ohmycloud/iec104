use Iec104::Utilities;
use Iec104::Asdu::InfoObj::Address;

unit module Iec104::Asdu::InfoObj::ShortFloat;

#| 测量值, 短浮点数
sub short-float(Buf $info-element, Int $num, Int $ti, Int $sq) is export {
    my $s = "";
    # SQ = 1 地址连续
    if $sq == 1 {
        my $init-info-obj-addr = info-obj-addr($info-element[0], $info-element[1], $info-element[2]);
        $s ~= sprintf("\t遥测信息对象初始地址：%s\n", info-address($info-element[0], $info-element[1],
                $info-element[2]));
        for ^$num -> $i {
            $s ~= sprintf("\t遥测信息对象地址：%s ", $init-info-obj-addr++);
            $s ~= sprintf("\t遥测%s IEEE 754短浮点数：%s\t%s\t%s\t%s\t品质描述词 QDS:%s",
                      $i + 1,
                      to-hex-string($info-element[$i * 5 + 3]),
                      to-hex-string($info-element[$i * 5 + 4]),
                      to-hex-string($info-element[$i * 5 + 5]),
                      to-hex-string($info-element[$i * 5 + 6]),
                      to-hex-string($info-element[$i * 5 + 7])
                  );
            $s ~= sprintf("\t信息对象值：%s\n",
                    read-float(
                        to-hex-string($info-element[$i * 5 + 3]) ~
                        to-hex-string($info-element[$i * 5 + 4]) ~
                        to-hex-string($info-element[$i * 5 + 5]) ~
                        to-hex-string($info-element[$i * 5 + 6]))
                    );
        }
    } else {
        for ^$num -> $i {
            $s ~= sprintf(
                    "\t信息对象地址%s\n\tIEEE 754短浮点数：%s\t%s\t%s\t%s\t%s\n\t品质描述词 QDS：%s",
                    $i + 1,
                    info-address($info-element[$i * 8], $info-element[$i * 8 + 1], $info-element[$i * 8 + 2]),
                    to-hex-string($info-element[$i * 8 + 3]),
                    to-hex-string($info-element[$i * 8 + 4]),
                    to-hex-string($info-element[$i * 8 + 5]),
                    to-hex-string($info-element[$i * 8 + 6]),
                    to-hex-string($info-element[$i * 8 + 7])
                                               );
            $s ~= sprintf("\t信息对象值：%s\n",
                    read-float(
                        to-hex-string($info-element[$i * 8 + 3]) ~
                        to-hex-string($info-element[$i * 8 + 4]) ~
                        to-hex-string($info-element[$i * 8 + 5]) ~
                        to-hex-string($info-element[$i * 8 + 6]))
                  );
        }
    }
    $s
}
