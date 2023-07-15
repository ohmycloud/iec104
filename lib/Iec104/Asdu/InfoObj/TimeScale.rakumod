unit module Iec104::Asdu::InfoObj::TimeScale;

#| 时标CP56Time2a解析
sub time-scale(Buf $b) is export {
    my Int $year = $b[6] +& 0x7F;                # 去掉最高位   sprintf("0x%02X", :2('1111111'))
    my Int $month = $b[5] +& 0x0F;               # 去掉前 4 位  sprintf("0x%02X", :2('1111'))
    my Int $day = $b[4] +& 0x1F;                 # 去掉前 3 位  sprintf("0x%02X", :2('11111'))
    my Int $week = ($b[4] +& 0xE0) // 32;        # 去掉后 5 位 sprintf("0x%02X", :2('11100000'))
    my Int $hour = $b[3] +& 0x1F;                # 去掉前 3 位 sprintf("0x%02X", :2('11111'))
    my Int $minute = $b[2] +& 0x3F;              # 去掉前 2 位 sprintf("0x%02X", :2('111111'))
    my Int $millisecond = ($b[1] +< 8) + $b[0];  # 前两位存的都是毫秒, 把低8位毫秒数和高8位毫秒数相加

    sprintf("\t时标CP56Time2a：20%02d-%02d-%02d %02d:%02d:%02d.%s\n",
            $year,$month,$day,$hour,$minute, $millisecond div 1000, $millisecond mod 1000)
}