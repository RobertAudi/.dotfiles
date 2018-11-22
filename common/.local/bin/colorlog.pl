#!/usr/bin/perl

# Colorize "tail -f /var/log/messages"

$black    = "\033[30m";
$red      = "\033[31m";
$green    = "\033[32m";
$yellow   = "\033[33m";
$blue     = "\033[34m";
$magenta  = "\033[35m";
$purple   = "\033[35m";
$cyan     = "\033[36m";
$white    = "\033[37m";
$darkgray = "\033[30m";
@word_good=("starting\n", "Freeing", "Detected", "starting.", "accepted.\n", "authenticated.\n", "Ready", "active", "reloading", "saved;", "restarting", "ONLINE\n");
@word_warn=("dangling", "closed.\n", "Assuming", "root", "root\n", "exiting\n", "missing", "Ignored", "adminalert:", "deleting", "OFFLINE\n");
@word_bad=("bad");
@word_note=("LOGIN", "DHCP_OFFER", "optimized", "reset:", "unloaded", "disconnected", "connect", "Successful", "registered\n");
@line_good=("up", "DHCP_ACK", "Cleaned", "Initializing", "Starting", "success", "successfully", "alive", "found", "ONLINE\n");
@line_warn=("warning:", "WARNING:", "invalid", "obsolete", "bad", "Password", "detected", "timeout", "timeout:", "attackalert:", "wrong", "Lame", "FAILED", "failing", "unknown", "obsolete", "stopped.\n", "terminating.", "disabled\n", "disabled", "Lost");
@line_bad=("DENY", "lost", "shutting", "dead", "DHCP_NAK", "failure;", "Unable", "inactive", "terminating", "refused", "rejected", "down", "OFFLINE\n", "error\n", "ERROR\n", "ERROR:", "error", "ERROR", "error:", "failed:");
@daemons=("named");
$col_good = $green;
$col_warn = $yellow;
$col_bad = $red;
$col_note = $purple;
$col_norm =   "\033[00m";
$col_background = "\033[07m";
$col_brighten =   "\033[01m";
$col_underline =  "\033[04m";
$col_blink =    "\033[05m";
$col_default = "$col_norm$white";
print "$col_norm$cyan";
$datespace=0;
mainloop: while (<>)
{
  $thisline = $_;
  $timestamp = substr($_,0,15);
  s/................//;
  @rec = split (/ /, $_);
  $output="$col_brighten$cyan$timestamp";
  $output.=" $col_brighten$blue$rec[0]";
  if ($rec[1] eq "last")
  {
    $output.="$col_norm$green last message repeated ";
    $output.="$col_brighten$rec[4]$col_norm$green times\n";
    print "$output$col_default";
    next mainloop;
  }
  if ($rec[1] =~ /\[(\d+)\]\:/)
  {
    my($pid) = $1;
    $rec[1]=~s/\[$1\]\:// ;
    $output .= "$col_norm$green $rec[1]" .
               "$col_brighten$green\[";
    $output .= "$col_brighten$white$pid" .
               "$col_brighten$green\]: ";
  }
  else {
    $output .= "$col_norm$green $rec[1] ";
  }
  $restcolor="$col_norm$cyan";
  $restoftheline="";
  for ($therest=(2); $therest<=$#rec; $therest++)
  { $highlight=0;
    for ($i=0; $i<=$#word_good; $i++)
    { if ($word_good[$i] eq $rec[$therest])
      { $restoftheline.="$col_brighten$col_good"; $highlight=1; }
    }
    for ($i=0; $i<=$#word_warn; $i++)
    { if ($word_warn[$i] eq $rec[$therest])
      { $restoftheline.="$col_brighten$col_warn"; $highlight=1; }
    }
    for ($i=0; $i<=$#word_bad; $i++)
    { if ($word_bad[$i] eq $rec[$therest])
      { $restoftheline.="$col_brighten$col_bad"; $highlight=1; }
    }
    for ($i=0; $i<=$#word_note; $i++)
    { if ($word_note[$i] eq $rec[$therest])
      { $restoftheline.="$col_brighten$col_note"; $highlight=1; }
    }
    for ($i=0; $i<=$#line_good; $i++)
    { if ($line_good[$i] eq $rec[$therest])
      { $restcolor="$col_norm$col_good";
        $restoftheline.="$col_brighten$col_good"; $highlight=1; }
    }
    for ($i=0; $i<=$#line_warn; $i++)
    { if ($line_warn[$i] eq $rec[$therest])
      { $restcolor="$col_norm$col_warn";
        $restoftheline.="$col_brighten$col_warn"; $highlight=1; }
    }
    for ($i=0; $i<=$#line_bad; $i++)
    { if ($line_bad[$i] eq $rec[$therest])
      { $restcolor="$col_norm$col_bad";
        $restoftheline.="$col_brighten$col_bad"; $highlight=1; }
    }
    $restoftheline.="$rec[$therest] ";
    if ($highlight == 1)
    { $restoftheline.=$restcolor; }
  }
  $output.="$restcolor$restoftheline";
  print "$output$col_default\033[1G";
}
exit(0);
