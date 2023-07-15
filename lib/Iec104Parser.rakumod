use Iec104::Asdu;
use Iec104::ControlDomain;

use experimental :pack;

sub hex-handle(Str $hex-message) is export {
    my $buf = pack("H*", $hex-message);
    my $length = $buf.elems;
    if $length >= 2 && $buf[0] == 0x68 {
        say 'APCI 应用规约控制信息: ';
        say "\t启动字符[1th byte]: 0x68";
    }

    # $buf[1] 为 APDU 长度, APDU 长度+2 = 数据长度
    # 2 字节中, 1 字节来自于启动字符, 1 字节来自于APDU长度
    if ($length != $buf[1] + 2) {
        die("length dismatch {$buf[1]+2} {$length}");
    }

    say "\t应用规约数据单元(APDU)长度[2th byte]: {$buf[1]} 字节";
    say "\t控制域[3th byte - 6th byte]:" ~ frame-type(Buf.new($buf[2], $buf[3], $buf[4], $buf[5]));

    # 解析 ASDU 数据, $buf[2] 为控制域1, 即用控制域的第一个字节和数字3做位运算, 只有 I 类报文才有 ASDU
    if $buf[2] +& 0x03 != 3 && $buf[2] +& 0x03 != 1 {
        say "ASDU 应用服务数据单元：";
        my Buf $asdu = Buf.new($buf[6..*]); # 6 个字节之后的数据为 ASDU 数据
        asdu-message($asdu);
    }
}

=begin pod

=head1 Name

Iec104Parser - IEC 104 message parser

=head1 SYNOPSIS

=begin code :lang<raku>

use Iec104Parser;

my $message = "6871180002000d94140001001540000000ecc1003333e7c1003333efc100cdcc47420033f3c5430033f3c643009a99c643000000eb430000c085450000000000000000dc420000002043000000a4c10000000000003313374400000000400000004040000000000000000000000067c6364400";
hex-handle($message);

=end code

=head1 DESCRIPTION

This module parses power IEC 104 messages and is still under construction.

=head1 AUTHOR

ohmycloudy

=head1 COPYRIGHT AND LICENSE

Copyright 2023 - ohmycloudy

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod