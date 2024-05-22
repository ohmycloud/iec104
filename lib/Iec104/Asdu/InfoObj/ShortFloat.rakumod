use Iec104::Utilities;
use Iec104::Asdu::InfoObj::Address;

unit module Iec104::Asdu::InfoObj::ShortFloat;

#| 测量值, 短浮点数
#| $num 信息体个数, $i 类型标识, sq SQ 可变结构限定词,
sub short-float(Buf $info-element, Int $num, Int $ti, Int $sq) is export {
    given $sq {
        # SQ = 1 地址连续
        when 1 {
            my $init-info-obj-addr = info-obj-addr($info-element[0], $info-element[1], $info-element[2]);
            gather for ^$num -> $i {
                # 信息对象地址
                my $info-obj-address = $init-info-obj-addr++;
                # 信息对象地址值
                my $info-obj-value = read-float(
                        to-hex-string($info-element[$i * 5 + 3]) ~
                        to-hex-string($info-element[$i * 5 + 4]) ~
                        to-hex-string($info-element[$i * 5 + 5]) ~
                        to-hex-string($info-element[$i * 5 + 6])
                );
                take $info-obj-address => $info-obj-value
            }
        }
        # SQ = 0 地址非连续
        when 0 {
            gather for ^$num -> $i {
                # 信息对象地址
                my $info-obj-address = info-address($info-element[$i * 8], $info-element[$i * 8 + 1], $info-element[$i * 8 + 2]);
                # 信息对象地址值
                my $info-obj-value = read-float(
                        to-hex-string($info-element[$i * 8 + 3]) ~
                        to-hex-string($info-element[$i * 8 + 4]) ~
                        to-hex-string($info-element[$i * 8 + 5]) ~
                        to-hex-string($info-element[$i * 8 + 6])
                );
                take $info-obj-address => $info-obj-value
            }
        }
    }
}