unit module Iec104::Asdu::TransReason;

#| 传送原因描述
sub trans-reason-desc(Int $code) is export {
    my $desc = do given $code {
        when 0  { "未用" }
        when 1  { "周期、循环" }
        when 2  { "背景扫描" }
        when 3  { "突发（自发）" }
        when 4  { "初始化完成" }
        when 5  { "请求或者被请求" }
        when 6  { "激活" }
        when 7  { "激活确认" }
        when 8  { "停止激活" }
        when 9  { "停止激活确认" }
        when 10 { "激活终止" }
        when 13 { "文件传输" }
        when 20 { "响应站召唤（总召唤）" }
        when 44 { "未知的类型标识" }
        when 45 { "未知的传送原因" }
        when 46 { "未知的应用服务数据单元公共地址" }
        when 47 { "未知的信息对象地址" }
        when 48 { "遥控执行软压板状态错误" }
        when 49 { "遥控执行时间戳错误" }
        when 50 { "遥控执行数字签名认证错误" }
        default { "" }
    }
    sprintf("[0x%02X]%s", $code, $desc)
}

#| 传送原因
sub trans-reason(Int $i, Int $j) is export {
        my $trans-reason-str = "";
        given $i +& 0x80 {
            when 128 { $trans-reason-str ~= '[T(test) bit7:1   实验]'  }
            when 0   { $trans-reason-str ~= '[T(test) bit7:0  未实验]' }
            default  {}
        }

        given $i +& 0x40 {
            when 64 { $trans-reason-str ~= '[P/N  bit6:1  否定确认]' }
            when 0  { $trans-reason-str ~= '[P/N  bit6:0  肯定确认]' }
            default {}
        }

        my $trans-reason-desc = sprintf("[原因  bit5~bit0:%s]", trans-reason-desc($i +& 0x3F));
        $trans-reason-str ~= $trans-reason-desc;
        $trans-reason-str
}
