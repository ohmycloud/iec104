use Iec104::Asdu::InfoObj::Address;
use Iec104::Utilities;

unit module Iec104::Asdu::InfoObj::Normalization;

#| 归一化值
sub normalization(Buf $info-element, Int $num, Int $ti, Int $sq) is export {
    my $s = "";
    if $sq == 1 {
        $s ~= sprintf("\t遥测信息对象地址：%s\n", info-address($info-element[0], $info-element[1], $info-element[2]));
        for ^$num -> $i {
            $s ~= sprintf("\t信息对象%s\n\t\t归一化值 NVA：%s\t%s\n\t\t品质描述词 QDS：%s\n",
                    $i + 1,
                    to-hex-string($info-element[$i * 3 + 3]),
                    to-hex-string($info-element[$i * 3 + 4]),
                    to-hex-string($info-element[$i * 3 + 5])
                  );
        }
    } else {
        for ^$num -> $i {
            $s ~= sprintf("\t信息对象%s的地址%s\n归一化值 NVA：%s\t%s\n\t\t品质描述词 QDS: %s\n",
                    $i + 1,
                    info-address($info-element[$i * 6], $info-element[$i + 6 + 1], $info-element[$i * 6 + 2]),
                    to-hex-string($info-element[$i * 6 + 3]),
                    to-hex-string($info-element[$i * 6 + 4]),
                    to-hex-string($info-element[$i * 6 + 5])
                  )
        }
    }
    $s
}
