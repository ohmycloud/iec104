use Iec104::Asdu;
use Iec104::ControlDomain;
use Iec104::Message;

use experimental :pack;

sub hex-handle(Str $hex-message) is export {
    my $buf = pack("H*", $hex-message);
    if $buf.elems >= 6 {
        my $message = Message.new(
                :header(Buf.new($buf[^1])),
                :apdu-length(Buf.new($buf[1..^2])),
                :ctrl-domain(Buf.new($buf[2..^6])),
                :type-identifier(Buf.new($buf[6..^7])),
                :qualifier(Buf.new($buf[7..^8])),
                :trans-reason(Buf.new($buf[8..^10])),
                :terminal-id(Buf.new($buf[10..^12])),
                :info-obj-addr(Buf.new($buf[12..^15])),
                :asdu(Buf.new($buf[6..*]))
                );
        say frame-type(Buf.new($buf[2], $buf[3], $buf[4], $buf[5]));
        say asdu-message($message.asdu);

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