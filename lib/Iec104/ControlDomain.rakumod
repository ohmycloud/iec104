use Iec104::ControlDomain::IFrame;
use Iec104::ControlDomain::SFrame;
use Iec104::ControlDomain::UFrame;

unit module Iec104::ControlDomain;

#| 帧格式
sub frame-type(Buf $buf) is export {
    given $buf[0] +& 0x03 {
        when 1  { say SFrame.new(:$buf) }
        when 3  { say UFrame.new(:$buf) }
        default { say IFrame.new(:$buf) }
    }
}