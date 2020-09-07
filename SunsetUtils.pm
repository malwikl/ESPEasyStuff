##############################################
# $Id: myUtilsTemplate.pm 21509 2020-03-25 11:20:51Z rudolfkoenig $
#
# Save this file as 99_myUtils.pm, and create your own functions in the new
# file. They are then available in every Perl expression.

package main;

use strict;
use warnings;

sub
myUtils_Initialize($$)
{
  my ($hash) = @_;
}

# Enter you functions below _this_ line.
#
#

sub myUtils_sunriselight() {
      my @lamps = ('ESPEasy_ESP_H801_RGBLedStrip');
      my @sonne = ('05FF00', '05FF0A', '05FF14', '05FF1E', '05FF28', '05FF32', '05FF3C', '05FF46', '05FF50', '05FF5A', '05FF64', '05FF6E', '05FF78', '05FF82', '05FF8C', '05FF96', '05FFA0', '05FFAA', '05FFB4', '05FFBE', '05FFC8', '05FFD2', '05FFDC', '05FFE6', '05FFF0', '05FFFA', '05FFFF', '05FAFF', '05F0FF', '05E6FF', '05DCFF', '05D2FF', '05C8FF', '05BEFF', '05B4FF', '05AAFF', '05A0FF', '0596FF', '058CFF', '0582FF', '0578FF', '056EFF', '0564FF', '055AFF', '0550FF', '0546FF', '053CFF', '0532FF', '0528FF', '051EFF', '0514FF', '050AFF', '0500FF');
      my $dauer = 1 * 60; # 30 Minuten
      my $sleepPerStep = $dauer/@sonne;
      my $cmd = "";
      my $cancel = "";
      my $i = 1;
      my $lamp = "";

      foreach my $rgb (@sonne) {
        foreach $lamp (@lamps) {
          $cmd .= "set $lamp h_hsv $rgb;";
        }
        $cmd .= "sleep $sleepPerStep slsrl_$i;";
        $cancel .= "cancel slsrl_$i quiet;;";
        $i++;
      }

      foreach $lamp (@lamps) {
        $cancel .= "set $lamp off;;";
      }
      # mglw. bereits laufendes WUL beenden
      fhem "cancel_sunriselight";
      # alias cancel_wul neu anlegen
      fhem "defmod cancel_sunriselight cmdalias cancel_sunriselight AS $cancel";
      # WUL starten
      fhem $cmd if $cmd ne "";
}


sub myUtils_sunsetlight() {
      my @lamps = ('ESPEasy_ESP_H801_RGBLedStrip');
      my @sonne = ('05FF00', '05FF0A', '05FF14', '05FF1E', '05FF28', '05FF32', '05FF3C', '05FF46', '05FF50', '05FF5A', '05FF64', '05FF6E', '05FF78', '05FF82', '05FF8C', '05FF96', '05FFA0', '05FFAA', '05FFB4', '05FFBE', '05FFC8', '05FFD2', '05FFDC', '05FFE6', '05FFF0', '05FFFA', '05FFFF', '05FAFF', '05F0FF', '05E6FF', '05DCFF', '05D2FF', '05C8FF', '05BEFF', '05B4FF', '05AAFF', '05A0FF', '0596FF', '058CFF', '0582FF', '0578FF', '056EFF', '0564FF', '055AFF', '0550FF', '0546FF', '053CFF', '0532FF', '0528FF', '051EFF', '0514FF', '050AFF', '0500FF');
      my $dauer = 1 * 60; # 30 Minuten
      my $sleepPerStep = $dauer/@sonne;
      my $cmd = "";
      my $cancel = "";
      my $i = 1;
      my $lamp = "";

      foreach my $rgb (reverse @sonne) {
        foreach $lamp (@lamps) {
          $cmd .= "set $lamp h_hsv $rgb;";
        }
        $cmd .= "sleep $sleepPerStep slssl_$i;";
        $cancel .= "cancel slssl_$i quiet;;";
        $i++;
      }

      	
      #Lampe nicht ausmachen beim Sonnenuntergang
      #foreach $lamp (@lamps) {
      #$cancel .= "set $lamp off;;";
      #}

      # mglw. bereits laufendes WUL beenden
      fhem "cancel_sunsetlight";
      # alias cancel_wul neu anlegen
      fhem "defmod cancel_sunsetlight cmdalias cancel_sunsetlight AS $cancel";
      # WUL starten
      fhem $cmd if $cmd ne "";
}
1;
