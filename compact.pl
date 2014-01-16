#!/usr/bin/perl

#
# Compact - Copyright (C) 2013 by Giovanni Bezicheri.
#
# @author Giovanni Bezicheri <jobezic@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

use strict;
use CSS::Minifier;
use JavaScript::Minifier;

my $web_root = "web";

my $in_index_html = "$web_root/index_dev.html";
my $out_css_prod = "$web_root/css/prod.css";
my $out_js_prod = "$web_root/js/prod.js";
my $out_index_html = "$web_root/index.html";

open FILE, "<$in_index_html" or die $!;
my @lines = <FILE>;
close FILE;

open(OUTCSSFILE, ">$out_css_prod") or die;
open(OUTJSFILE, ">$out_js_prod") or die;


# Compact js|css files

foreach my $line (@lines) {
    chop($line);

    if ($line =~ /(link|script).*(href|src)="(.+?)".*\@minimize.*(skip|replace)/) {
        print "skipping $3..\n";
        next;
    }

    if ($line =~ /(link|script).*(href|src)="(.+?)"/) {
        print "minimizing $3..\n";

        open(INFILE, "<$web_root/$3") or die;

        if ($1 eq 'link') {
            CSS::Minifier::minify(input => *INFILE, outfile => *OUTCSSFILE);
        }
        elsif ($1 eq 'script') {
            JavaScript::Minifier::minify(input => *INFILE, outfile => *OUTJSFILE);
        }

        close(INFILE);
    }

}

close(OUTCSSFILE);
close(OUTJSFILE);

# Rewrite index.html

print "\nRewriting index.html..\n";
open(OUTFILE, ">$out_index_html") or die;
my $link_flag = 0;
my $js_flag = 0;
foreach my $line (@lines) {
    if ($line =~ /^.*(link|script).*(href|src)=".+?".*\@minimize.*(skip|replace).*$/) {
        if ($3 eq 'replace') {
            $line =~ /^.*(link|script).*(href|src)="(.+?)".*\@minimize.*replace with (.+?) /;
            my $old = $3;
            my $new = $4;
            $line =~ s/$old/$new/g;
        }
        print OUTFILE $line. "\n";
        next;
    }

    if ($line =~ /<(link|script).*/) {
        if ($1 eq 'link') {
            if ($link_flag == 0) {
                my $css_prod = $out_css_prod;
                $css_prod =~ s/$web_root\///g;
                $line = '    <link rel="stylesheet" href="'. $css_prod. '" type="text/css" />';
                $link_flag = 1;
            } else {
                next;
            }
        }
        elsif ($1 eq 'script') {
            if ($js_flag == 0) {
                my $js_prod = $out_js_prod;
                $js_prod =~ s/$web_root\///g;
                $line = '    <script src="'. $js_prod. '"></script>';
                $js_flag = 1;
            } else {
                next;
            }
        }
    }

    print OUTFILE $line. "\n";
}

close(OUTFILE);

print "\nDone!\n";

