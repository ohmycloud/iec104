unit module Iec104::Asdu::TypeIdentifier;

#| 类型标识
sub type-identifier-values(Int $code) is export {
    my $desc = do given $code {
        when 1   { "不带时标的单点信息" }
        when 3   { "不带时标的双点信息" }
        when 9   { "测量值，归一化值" }
        when 11  { "测量值，标度化值" }
        when 13  { "测量值，短浮点数" }
        when 30  { "带CP56Time2a时标的单点信息" }
        when 31  { "带CP56Time2a时标的双点信息" }
        when 45  { "单命令（遥控）" }
        when 46  { "双命令（遥控）" }
        when 48  { "预置/激活单个参数命令" }
        when 102 { "读单个参数命令" }
        when 70  { "初始化结束" }
        when 100 { "召唤命令" }
        when 103 { "时钟同步/读取命令" }
        when 104 { "测试命令" }
        when 105 { "复位进程命令" }
        when 132 { "读多个参数命令" }
        when 136 { "预置/激活多个参数命令" }
        default  { "" }
    }
    sprintf("[0x%02X]%s", $code, $desc)
}