<?php

/**
 * NOTE: This file is overwritten with HostBill updates, if you want to define custom WHOIS servers please
 * use a separate file, see: whois-custom.php.example
 *
 * Array below contains list of tlds and related whois servers.
 * Example:
 * array element:
 * '.co' => Array
 * (
 * 'server' => 'whois.nic.co',
 * 'available' => 'Not found:'
 * )
 * Informs HostBill core that:
 * 1. if domain to lookup have .co extension than:
 *  - connect with whois.nic.co over port 43
 *  - provide domain to lookup
 *  - check response, if it will contain string "Not found:"
 * (as described in 'available' section) it means that domain is available
 * for registration
 *
 * 2. If 'server' part begin with http:// HostBill will perform lookup using
 * port 80 (http request)
 */
$servers = [
    ".ac" => [
        "server" => "whois.nic.ac",
        "available" => "NOT FOUND"
    ],
    ".ac.uk" => [
        "server" => "whois.ja.net",
        "available" => "No such domain"
    ],
    ".academy" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".accountants" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".actor" => [
        "server" => "whois.unitedtld.com",
        "available" => "Domain not found"
    ],
    ".adult" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".ae" => [
        "server" => "whois.aeda.net.ae",
        "available" => "No Data Found"
    ],
    ".ae.org" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".aero" => [
        "server" => "whois.aero",
        "available" => "NOT FOUND"
    ],
    ".aeroport.fr" => [
        "server" => "whois.smallregistry.net",
        "available" => "Not found"
    ],
    ".af" => [
        "server" => "whois.nic.af",
        "available" => "No Object Found"
    ],
    ".ag" => [
        "server" => "whois.nic.ag",
        "available" => "NOT FOUND"
    ],
    ".agency" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".al" => [
        "server" => "http://members.webhost.al/www-whois.php?dom=",
        "available" => "No match for"
    ],
    ".alsace" => [
        "server" => "whois-alsace.nic.fr",
        "available" => "does not exist"
    ],
    ".am" => [
        "server" => "whois.amnic.net",
        "available" => "No match"
    ],
    ".amsterdam" => [
        "server" => "whois.nic.amsterdam",
        "available" => "Domain Status: free"
    ],
    ".aquarelle" => [
        "server" => "whois-aquarelle.nic.fr",
        "available" => "does not exist"
    ],
    ".ar.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".arpa" => [
        "server" => "whois.iana.org",
        "available" => "returned 0 objects"
    ],
    ".art" => [
        "server" => "whois.nic.art",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".art.do" => [
        "server" => "http://www.nic.do/whoisingles.php3?dns_answer=&do=art.do&B1=Query&T1=",
        "available" => "This domain doesn't exist",
        "sldonly" => true
    ],
    ".as" => [
        "server" => "whois.nic.as",
        "available" => "NOT FOUND"
    ],
    ".asia" => [
        "server" => "whois.nic.asia",
        "available" => "NOT FOUND"
    ],
    ".associates" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".at" => [
        "server" => "whois.nic.at",
        "available" => "nothing found"
    ],
    ".au" => [
        "server" => "whois-check.ausregistry.net.au",
        "available" => "Available",
        "namemin" => 2,
        "strict" => true
    ],
    ".audio" => [
        "server" => "whois.uniregistry.net",
        "available" => "is available for registration"
    ],
    ".auto" => [
        "server" => "whois.nic.auto",
        "available" => "Domain {\$domain} is available for registration"
    ],
    ".autos" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".avocat.fr" => [
        "server" => "whois.smallregistry.net",
        "available" => "Not found"
    ],
    ".aw" => [
        "server" => "whois.nic.aw",
        "available" => "free"
    ],
    ".ax" => [
        "server" => "whois.ax",
        "available" => "Not found"
    ],
    ".axa" => [
        "server" => "whois.nic.axa",
        "available" => "Available"
    ],
    ".az" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".ba" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".bar" => [
        "server" => "whois.nic.bar",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".bargains" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".be" => [
        "server" => "whois.dns.be",
        "available" => "Status:\tAVAILABLE"
    ],
    ".berlin" => [
        "server" => "whois.nic.berlin",
        "available" => "does not exist"
    ],
    ".best" => [
        "server" => "whois.nic.best",
        "available" => "does not exist"
    ],
    ".bg" => [
        "server" => "whois.register.bg",
        "available" => "does not exist"
    ],
    ".bi" => [
        "server" => "whois.nic.bi",
        "available" => "No match for"
    ],
    ".bid" => [
        "server" => "whois.nic.bid",
        "available" => "does not exist"
    ],
    ".bike" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".biz" => [
        "server" => "whois.neulevel.biz",
        "available" => "No Data Found",
        "namemin" => 1
    ],
    ".bj" => [
        "server" => "whois.nic.bj",
        "available" => "No Object Found"
    ],
    ".bl.uk" => [
        "server" => "whois.nic.uk",
        "available" => "Available"
    ],
    ".black" => [
        "server" => "whois.afilias.net",
        "available" => "NOT FOUND"
    ],
    ".blackfriday" => [
        "server" => "whois.uniregistry.net",
        "available" => "Available"
    ],
    ".blog" => [
        "server" => "whois.nic.blog",
        "available" => "This domain name has not been registered",
        "whoisserver" => ""
    ],
    ".blue" => [
        "server" => "whois.afilias.net",
        "available" => "NOT FOUND"
    ],
    ".bnpparibas" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".boutique" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".br" => [
        "server" => "whois.registro.br",
        "available" => "No match for domain"
    ],
    ".br.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".british-library.uk" => [
        "server" => "whois.nic.uk",
        "available" => "Available"
    ],
    ".brussels" => [
        "server" => "whois.nic.brussels",
        "available" => "Not found"
    ],
    ".bt" => [
        "server" => "whois.netnames.net",
        "available" => "No match for"
    ],
    ".build" => [
        "server" => "whois.nic.build",
        "available" => "No Data Found"
    ],
    ".builders" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".business" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".buzz" => [
        "server" => "whois.nic.buzz",
        "available" => "No Data Found"
    ],
    ".bv" => [
        "server" => "whois.norid.no",
        "available" => "No match"
    ],
    ".bw" => [
        "server" => "whois.nic.net.bw",
        "available" => "No Object Found"
    ],
    ".by" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".bzh" => [
        "server" => "whois-bzh.nic.fr",
        "available" => "does not exist"
    ],
    ".ca" => [
        "server" => "whois.cira.ca",
        "available" => "Not found:"
    ],
    ".cab" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".camera" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".camp" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".cancerresearch" => [
        "server" => "whois.nic.cancerresearch",
        "available" => "Available"
    ],
    ".capetown" => [
        "server" => "whois.nic.capetown",
        "available" => "Available"
    ],
    ".capital" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".cards" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".care" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".career" => [
        "server" => "whois.nic.career",
        "available" => "Available"
    ],
    ".careers" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".cash" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".casino" => [
        "server" => "whois.nic.ceo",
        "available" => "Domain not found"
    ],
    ".cat" => [
        "server" => "whois.cat",
        "available" => "no matching objects"
    ],
    ".catering" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".cc" => [
        "server" => "whois.nic.cc",
        "available" => "No match"
    ],
    ".cd" => [
        "server" => "whois.nic.cd",
        "available" => "Domain Not Found"
    ],
    ".center" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".ceo" => [
        "server" => "whois.nic.ceo",
        "available" => "No Data Found"
    ],
    ".cern" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".cf" => [
        "server" => "whois.dot.cf",
        "available" => "domain name not known"
    ],
    ".ch" => [
        "server" => "whois.nic.ch",
        "available" => "We do not have an entry"
    ],
    ".chambagri.fr" => [
        "server" => "whois.smallregistry.net",
        "available" => "Not found"
    ],
    ".cheap" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".chirurgiens-dentistes.fr" => [
        "server" => "whois.smallregistry.net",
        "available" => "Not found"
    ],
    ".christmas" => [
        "server" => "whois.uniregistry.net",
        "available" => "is available for"
    ],
    ".church" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".ci" => [
        "server" => "whois.nic.ci",
        "available" => "No Object Found"
    ],
    ".citic" => [
        "server" => "whois.nic.citic",
        "available" => "does not exist"
    ],
    ".city" => [
        "server" => "whois.nic.city",
        "available" => "Domain not found"
    ],
    ".ck" => [
        "server" => "whois.nic.ck",
        "available" => "No entries found "
    ],
    ".cl" => [
        "server" => "whois.nic.cl",
        "available" => "no exist"
    ],
    ".claims" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".cleaning" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".click" => [
        "server" => "whois.uniregistry.net",
        "available" => "Available"
    ],
    ".clinic" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".clothing" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".club" => [
        "server" => "whois.nic.club",
        "available" => "No Data Found"
    ],
    ".cn" => [
        "server" => "whois.cnnic.cn",
        "available" => "No matching record"
    ],
    ".cn.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".co" => [
        "server" => "whois.nic.co",
        "available" => "No Data Found"
    ],
    ".co.ca" => [
        "server" => "whois.co.ca",
        "available" => "Available"
    ],
    ".co.nl" => [
        "server" => "whois.co.nl",
        "available" => "Domain does not exist"
    ],
    ".co.pl" => [
        "server" => "whois.co.pl",
        "available" => "Not found"
    ],
    ".co.za" => [
        "server" => "whois.registry.net.za",
        "available" => "Available"
    ],
    ".coach" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".codes" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".coffee" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".college" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".cologne" => [
        "server" => "whois-fe1.pdt.cologne.tango.knipp.de",
        "available" => "no matching objects found"
    ],
    ".com" => [
        "server" => "whois.crsnic.net",
        "available" => "No match for",
        "request" => "domain "
    ],
    ".com.al" => [
        "server" => "http://members.webhost.al/www-whois.php?dom=",
        "available" => "No match for"
    ],
    ".com.de" => [
        "server" => "whois.centralnic.com",
        "available" => "free"
    ],
    ".com.do" => [
        "server" => "http://www.nic.do/whoisingles.php3?dns_answer=&do=com.do&B1=Query&T1=",
        "available" => "This domain doesn't exist",
        "sldonly" => true
    ],
    ".community" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".company" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".computer" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".condos" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".construction" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".contractors" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".cool" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".coop" => [
        "server" => "whois.nic.coop",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".credit" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".creditcard" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".cruises" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".cuisinella" => [
        "server" => "whois.nic.cuisinella",
        "available" => "No Data Found"
    ],
    ".cx" => [
        "server" => "whois.nic.cx",
        "available" => "No Object Found"
    ],
    ".cy" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".cymru" => [
        "server" => "whois.nic.cymru",
        "available" => "Available"
    ],
    ".cz" => [
        "server" => "whois.nic.cz",
        "available" => "no entries found"
    ],
    ".dance" => [
        "server" => "whois.unitedtld.com",
        "available" => "Domain not found"
    ],
    ".dating" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".de" => [
        "server" => "whois.denic.de",
        "available" => "free",
        "unicode" => true,
        "namemin" => 1
    ],
    ".de.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".deals" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".delivery" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".democrat" => [
        "server" => "whois.unitedtld.com",
        "available" => "Domain not found"
    ],
    ".dental" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".design" => [
        "server" => "whois.nic.design",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".diamonds" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".diet" => [
        "server" => "whois.uniregistry.net",
        "available" => "Available"
    ],
    ".digital" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".direct" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".directory" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".discount" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".dk" => [
        "server" => "whois.dk-hostmaster.dk",
        "available" => "No entries found"
    ],
    ".dm" => [
        "server" => "whois.nic.dm",
        "available" => "Not found"
    ],
    ".dnp" => [
        "server" => "whois.nic.dnp",
        "available" => "Not found"
    ],
    ".do" => [
        "server" => "http://www.nic.do/whoisingles.php3?dns_answer=&do=do&B1=Query&T1=",
        "available" => "This domain doesn't exist",
        "sldonly" => true
    ],
    ".domains" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".donetsk.ua" => [
        "server" => "whois.net.ua",
        "available" => "No match record"
    ],
    ".durban" => [
        "server" => "whois.nic.durban",
        "available" => "Available"
    ],
    ".dz" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".e164.arpa" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".ec" => [
        "server" => "whois.lac.net",
        "available" => "No match found"
    ],
    ".edu" => [
        "server" => "whois.internic.net",
        "available" => "No match for"
    ],
    ".edu.al" => [
        "server" => "http://members.webhost.al/www-whois.php?dom=",
        "available" => "No match for"
    ],
    ".edu.do" => [
        "server" => "http://www.nic.do/whoisingles.php3?dns_answer=&do=edu.do&B1=Query&T1=",
        "available" => "This domain doesn't exist",
        "sldonly" => true
    ],
    ".edu.ru" => [
        "server" => "whois.informika.ru",
        "available" => "free"
    ],
    ".education" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".ee" => [
        "server" => "whois.eenet.ee",
        "available" => "Domain not found"
    ],
    ".eg" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".email" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".emerck" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".energy" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".engineering" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".enterprises" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".equipment" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".es" => [
        "server" => "http://whois.virtualname.es/whois.php?domain=",
        "available" => "LIBRE - DOMINIO DISPONIBLE"
    ],
    ".estate" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".eu" => [
        "server" => "whois.eu",
        "available" => "Status: AVAILABLE",
        "namemin" => 2
    ],
    ".eu.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".eu.org" => [
        "server" => "whois.eu.org",
        "available" => "Not found"
    ],
    ".eurovision" => [
        "server" => "whois.nic.eurovision",
        "available" => "no matching objects"
    ],
    ".events" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".exchange" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".expert" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".experts-comptables.fr" => [
        "server" => "whois.smallregistry.net",
        "available" => "Not found"
    ],
    ".exposed" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".fail" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".farm" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".fashion" => [
        "server" => "whois.nic.fashion",
        "available" => "This domain name has not been registered."
    ],
    ".feedback" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".fi" => [
        "server" => "whois.ficora.fi",
        "available" => "Domain not found"
    ],
    ".finance" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".financial" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".firmdale" => [
        "server" => "whois.nic.firmdale",
        "available" => "Not found"
    ],
    ".fish" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".fitness" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".fj" => [
        "server" => "domains.fj",
        "available" => "Not found"
    ],
    ".flights" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".florist" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".flowers" => [
        "server" => "whois.uniregistry.net",
        "available" => "Available"
    ],
    ".fm" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".fo" => [
        "server" => "whois.ripe.net",
        "available" => "No entries found"
    ],
    ".foundation" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".fr" => [
        "server" => "whois.nic.fr",
        "available" => "No entries found in the AFNIC Database"
    ],
    ".frl" => [
        "server" => "whois.nic.frl",
        "available" => "Not found"
    ],
    ".fund" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".furniture" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".futbol" => [
        "server" => "whois.unitedtld.com",
        "available" => "Domain not found"
    ],
    ".ga" => [
        "server" => "whois.dot.ga",
        "available" => "domain name not known"
    ],
    ".gallery" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".gb" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".gb.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".gb.net" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".gd" => [
        "server" => "whois.adamsnames.com",
        "available" => "not registered"
    ],
    ".ge" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".gent" => [
        "server" => "whois.nic.gent",
        "available" => "Not found"
    ],
    ".geometre-expert.fr" => [
        "server" => "whois.smallregistry.net",
        "available" => "Object not found"
    ],
    ".gg" => [
        "server" => "whois.channelisles.net",
        "available" => "NOT FOUND"
    ],
    ".ggee" => [
        "server" => "whois.nic.gmo",
        "available" => "Not found"
    ],
    ".gi" => [
        "server" => "whois2.afilias-grs.net",
        "available" => "NOT FOUND"
    ],
    ".gift" => [
        "server" => "whois.uniregistry.net",
        "available" => "is available for"
    ],
    ".gifts" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".gl" => [
        "server" => "whois.ripe.net",
        "available" => " no entries found"
    ],
    ".glass" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".global" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".globo" => [
        "server" => "whois.gtlds.nic.br",
        "available" => "does not exist"
    ],
    ".gm" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".gmo" => [
        "server" => "whois.gmoregistry.net",
        "available" => "Not found"
    ],
    ".gmx" => [
        "server" => "whois-fe1.gmx.tango.knipp.de",
        "available" => "no matching objects"
    ],
    ".gob.do" => [
        "server" => "http://www.nic.do/whoisingles.php3?dns_answer=&do=gob.do&B1=Query&T1=",
        "available" => "This domain doesn't exist",
        "sldonly" => true
    ],
    ".gov" => [
        "server" => "whois.nic.gov",
        "available" => "No match for"
    ],
    ".gov.do" => [
        "server" => "http://www.nic.do/whoisingles.php3?dns_answer=&do=gov.do&B1=Query&T1=",
        "available" => "This domain doesn't exist",
        "sldonly" => true
    ],
    ".gov.uk" => [
        "server" => "whois.ja.net",
        "available" => "No such domain"
    ],
    ".gov.za" => [
        "server" => "whois.gov.za",
        "available" => "No match found for"
    ],
    ".gr" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".gr.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".graphics" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".gratis" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".green" => [
        "server" => "whois.afilias.net",
        "available" => "NOT FOUND"
    ],
    ".gripe" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".group" => [
        "server" => "whois.nic.group",
        "available" => "Domain not found"
    ],
    ".gs" => [
        "server" => "whois.nic.gs",
        "available" => "No Object Found"
    ],
    ".guide" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".guitars" => [
        "server" => "whois.uniregistry.net",
        "available" => "is available for registration"
    ],
    ".guru" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".gy" => [
        "server" => "whois.registry.gy",
        "available" => "No Object Found"
    ],
    ".hamburg" => [
        "server" => "whois.nic.hamburg",
        "available" => "does not exist"
    ],
    ".healthcare" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".help" => [
        "server" => "whois.uniregistry.net",
        "available" => "Available"
    ],
    ".hiphop" => [
        "server" => "whois.uniregistry.net",
        "available" => "is available for registration"
    ],
    ".hiv" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".hk" => [
        "server" => "whois.hkirc.hk",
        "available" => "The domain has not been registered"
    ],
    ".hm" => [
        "server" => "whois.registry.hm",
        "available" => "Domain not found."
    ],
    ".hn" => [
        "server" => "whois.nic.hn",
        "available" => "No Object Found"
    ],
    ".holdings" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".holiday" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".homes" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".host" => [
        "server" => "whois.nic.host",
        "available" => "Not found"
    ],
    ".hosting" => [
        "server" => "whois.uniregistry.net",
        "available" => "object does not exist"
    ],
    ".house" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".hr" => [
        "server" => "http://whois.com.hr/domena/",
        "available" => "nije registrirana"
    ],
    ".ht" => [
        "server" => "whois.nic.ht",
        "available" => "Not Registered"
    ],
    ".hu" => [
        "server" => "whois.nic.hu",
        "available" => "No match"
    ],
    ".hu.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".ibm" => [
        "server" => "whois.nic.ibm",
        "available" => "No match"
    ],
    ".icnet.uk" => [
        "server" => "whois.nic.uk",
        "available" => "Available"
    ],
    ".id" => [
        "server" => "whois.idnic.net.id",
        "available" => "Not found"
    ],
    ".ie" => [
        "server" => "whois.domainregistry.ie",
        "available" => "Not Registered"
    ],
    ".il" => [
        "server" => "whois.isoc.org.il",
        "available" => "No data was found"
    ],
    ".im" => [
        "server" => "whois.nic.im",
        "available" => "was not found"
    ],
    ".immo" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".immobilien" => [
        "server" => "whois.unitedtld.com",
        "available" => "Domain not found"
    ],
    ".in" => [
        "server" => "whois.registry.in",
        "available" => "No Data Found"
    ],
    ".in.ua" => [
        "server" => "whois.in.ua",
        "available" => "does not exist"
    ],
    ".industries" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".info" => [
        "server" => "whois.afilias.net",
        "available" => "NOT FOUND"
    ],
    ".info.ht" => [
        "server" => "whois.nic.ht",
        "available" => "Not Registered"
    ],
    ".ink" => [
        "server" => "whois.nic.ink",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".institute" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".insure" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".int" => [
        "server" => "whois.iana.org",
        "available" => "any data for"
    ],
    ".international" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".investments" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".io" => [
        "server" => "whois.nic.io",
        "available" => "NOT FOUND"
    ],
    ".ir" => [
        "server" => "whois.nic.ir",
        "available" => "no entries found"
    ],
    ".is" => [
        "server" => "whois.isnic.is",
        "available" => "No entries found"
    ],
    ".ist" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".istanbul" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".it" => [
        "server" => "whois.nic.it",
        "available" => "AVAILABLE"
    ],
    ".je" => [
        "server" => "whois.je",
        "available" => "Not Registered"
    ],
    ".jet.uk" => [
        "server" => "whois.nic.uk",
        "available" => "Available"
    ],
    ".jetzt" => [
        "server" => "whois.nic.jetzt",
        "available" => "Not found"
    ],
    ".jobs" => [
        "server" => "jobswhois.verisign-grs.com",
        "available" => "No match for"
    ],
    ".joburg" => [
        "server" => "whois.nic.joburg",
        "available" => "Available"
    ],
    ".jp" => [
        "server" => "whois.jprs.jp",
        "available" => "No match!!"
    ],
    ".jp.net" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".jpn.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".juegos" => [
        "server" => "whois.uniregistry.net",
        "available" => "Available"
    ],
    ".kaufen" => [
        "server" => "whois.unitedtld.com",
        "available" => "Domain not found"
    ],
    ".ke" => [
        "server" => "whois.kenic.or.ke",
        "available" => "No match found"
    ],
    ".kg" => [
        "server" => "whois.domain.kg",
        "available" => "Data not found."
    ],
    ".kh.ua" => [
        "server" => "whois.net.ua",
        "available" => "No match record"
    ],
    ".kharkiv.ua" => [
        "server" => "whois.net.ua",
        "available" => "No match record"
    ],
    ".kharkov.ua" => [
        "server" => "whois.kh.ua",
        "available" => "No match record"
    ],
    ".ki" => [
        "server" => "whois.nic.ki",
        "available" => "Status: Available"
    ],
    ".kim" => [
        "server" => "whois.afilias.net",
        "available" => "Domain not found"
    ],
    ".kitchen" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".kiwi" => [
        "server" => "whois.dot-kiwi.com",
        "available" => "Not Registered"
    ],
    ".koeln" => [
        "server" => "whois-fe1.pdt.koeln.tango.knipp.de",
        "available" => "no matching objects found"
    ],
    ".kr" => [
        "server" => "whois.nic.or.kr",
        "available" => "not registered"
    ],
    ".kr.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".kred" => [
        "server" => "whois.nic.kred",
        "available" => "Not found"
    ],
    ".kz" => [
        "server" => "whois.nic.kz",
        "available" => "Nothing found"
    ],
    ".la" => [
        "server" => "whois.nic.la",
        "available" => "NOT FOUND"
    ],
    ".lacaixa" => [
        "server" => "whois.nic.lacaixa",
        "available" => "no matching objects"
    ],
    ".land" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".latrobe" => [
        "server" => "whois.nic.latrobe",
        "available" => "No match"
    ],
    ".lc" => [
        "server" => "http://whois.domaintools.com/",
        "available" => "Whois Record Not Available"
    ],
    ".lds" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".lease" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".legal" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".lgbt" => [
        "server" => "whois.afilias.net",
        "available" => "NOT FOUND"
    ],
    ".li" => [
        "server" => "whois.nic.li",
        "available" => "We do not have an entry"
    ],
    ".life" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".lighting" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".limited" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found."
    ],
    ".limo" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".link" => [
        "server" => "whois.uniregistry.net",
        "available" => "is available for"
    ],
    ".loans" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".london" => [
        "server" => "whois.nic.london",
        "available" => "has not been registered"
    ],
    ".lotto" => [
        "server" => "whois.afilias.net",
        "available" => "NOT FOUND"
    ],
    ".love" => [
        "server" => "whois.nic.love",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".lt" => [
        "server" => "whois.domreg.lt",
        "available" => "Status:\t\t\tavailable"
    ],
    ".ltd" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".ltda" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".lu" => [
        "server" => "whois.dns.lu",
        "available" => "No such domain"
    ],
    ".luxury" => [
        "server" => "whois.nic.luxury",
        "available" => "No Data Found"
    ],
    ".lv" => [
        "server" => "whois.nic.lv",
        "available" => "Status: free"
    ],
    ".ly" => [
        "server" => "whois.nic.ly",
        "available" => "Not found"
    ],
    ".ma" => [
        "server" => "whois.iam.net.ma",
        "available" => "No Objects Found"
    ],
    ".madrid" => [
        "server" => "whois.madrid.rs.corenic.net",
        "available" => "no matching objects"
    ],
    ".maison" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".management" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".mango" => [
        "server" => "whois.mango.coreregistry.net",
        "available" => "no matching objects found"
    ],
    ".marketing" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".mc" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".md" => [
        "server" => "whois.nic.md",
        "available" => "No match for"
    ],
    ".me" => [
        "server" => "whois.nic.me",
        "available" => "NOT FOUND"
    ],
    ".medecin.fr" => [
        "server" => "whois.smallregistry.net",
        "available" => "Not found"
    ],
    ".media" => [
        "server" => "whois.nic.media",
        "available" => "Domain not found"
    ],
    ".meet" => [
        "server" => "whois.afilias.net",
        "available" => "NOT FOUND"
    ],
    ".memorial" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".men" => [
        "server" => "whois.nic.men",
        "available" => "No Data Found"
    ],
    ".menu" => [
        "server" => "whois.nic.menu",
        "available" => "No Data Found"
    ],
    ".mg" => [
        "server" => "whois.nic.mg",
        "available" => "No Object Found"
    ],
    ".mil.do" => [
        "server" => "http://www.nic.do/whoisingles.php3?dns_answer=&do=mil.do&B1=Query&T1=",
        "available" => "This domain doesn't exist",
        "sldonly" => true
    ],
    ".mk" => [
        "server" => "whois.ripe.net",
        "available" => "No entries found"
    ],
    ".ml" => [
        "server" => "whois.dot.ml",
        "available" => "domain name not known"
    ],
    ".mn" => [
        "server" => "http://whois.domaintools.com/",
        "available" => "Whois Record Not Available"
    ],
    ".mo" => [
        "server" => "whois.monic.mo",
        "available" => "No match for"
    ],
    ".mobi" => [
        "server" => "whois.dotmobiregistry.net",
        "available" => "NOT FOUND"
    ],
    ".mod.uk" => [
        "server" => "whois.nic.uk",
        "available" => "Available"
    ],
    ".moda" => [
        "server" => "whois.unitedtld.com",
        "available" => "Domain not found"
    ],
    ".moe" => [
        "server" => "whois.nic.moe",
        "available" => "Available"
    ],
    ".monash" => [
        "server" => "whois.nic.monash",
        "available" => "No Data Found"
    ],
    ".money" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".mormon" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".moscow" => [
        "server" => "whois.nic.moscow",
        "available" => "Not found"
    ],
    ".motorcycles" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".ms" => [
        "server" => "whois.nic.ms",
        "available" => "No Object Found"
    ],
    ".mt" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".mu" => [
        "server" => "whois.nic.mu",
        "available" => "Not Registered"
    ],
    ".museum" => [
        "server" => "whois.museum",
        "available" => "NOT FOUND"
    ],
    ".mx" => [
        "server" => "whois.mx",
        "available" => "Object_Not_Found"
    ],
    ".my" => [
        "server" => "http://whois.mynic.my/index.jsp?type=domain&searchtxt=",
        "available" => "does not exist in database"
    ],
    ".na" => [
        "server" => "whois.na-nic.com.na",
        "available" => "Status: Not Registered"
    ],
    ".nagoya" => [
        "server" => "whois.gmoregistry.net",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".name" => [
        "server" => "whois.nic.name",
        "available" => "No match"
    ],
    ".nc" => [
        "server" => "whois.nc",
        "available" => "No entries found in the"
    ],
    ".net" => [
        "server" => "whois.verisign-grs.com",
        "available" => "No match for"
    ],
    ".net.al" => [
        "server" => "http://members.webhost.al/www-whois.php?dom=",
        "available" => "No match for"
    ],
    ".net.do" => [
        "server" => "http://www.nic.do/whoisingles.php3?dns_answer=&do=net.do&B1=Query&T1=",
        "available" => "This domain doesn't exist",
        "sldonly" => true
    ],
    ".net.ht" => [
        "server" => "whois.nic.ht",
        "available" => "Not Registered"
    ],
    ".net.ua" => [
        "server" => "whois.net.ua",
        "available" => "No match record"
    ],
    ".net.za" => [
        "server" => "net-whois.registry.net.za",
        "available" => "Available"
    ],
    ".network" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".neustar" => [
        "server" => "whois.nic.neustar",
        "available" => "No Data Found"
    ],
    ".nf" => [
        "server" => "whois.nic.cx",
        "available" => "Not Registered"
    ],
    ".ng" => [
        "server" => "whois.nic.net.ng",
        "available" => "Not Registered"
    ],
    ".ngo" => [
        "server" => "whois.publicinterestregistry.net",
        "available" => "NOT FOUND"
    ],
    ".nhs.uk" => [
        "server" => "whois.nic.uk",
        "available" => "Available"
    ],
    ".ninja" => [
        "server" => "whois.unitedtld.com",
        "available" => "Domain not found"
    ],
    ".nl" => [
        "server" => "whois.domain-registry.nl",
        "available" => "is free"
    ],
    ".nls.uk" => [
        "server" => "whois.nic.uk",
        "available" => "Available"
    ],
    ".no" => [
        "server" => "whois.norid.no",
        "available" => "% No match"
    ],
    ".no.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".notaires.fr" => [
        "server" => "whois.smallregistry.net",
        "available" => "Not found"
    ],
    ".nra" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".nrw" => [
        "server" => "whois.nic.nrw",
        "available" => "no matching objects"
    ],
    ".nu" => [
        "server" => "whois.nic.nu",
        "available" => "domain \"{\$domain}\" not found"
    ],
    ".nyc" => [
        "server" => "whois.nic.nyc",
        "available" => "Not found"
    ],
    ".nz" => [
        "server" => "whois.srs.net.nz",
        "available" => "220 Available",
        "namemin" => 2
    ],
    ".okinawa" => [
        "server" => "whois.gmoregistry.ne",
        "available" => "Domain not found"
    ],
    ".om" => [
        "server" => "whois.registry.om",
        "available" => "No Data Found"
    ],
    ".ong" => [
        "server" => "whois.publicinterestregistry.net",
        "available" => "NOT FOUND"
    ],
    ".onl" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".online" => [
        "server" => "whois.nic.online",
        "available" => "NOT FOUND"
    ],
    ".ooo" => [
        "server" => "whois.nic.ooo",
        "available" => "Not found"
    ],
    ".org" => [
        "server" => "whois.publicinterestregistry.net",
        "available" => "NOT FOUND"
    ],
    ".org.al" => [
        "server" => "http://members.webhost.al/www-whois.php?dom=",
        "available" => "No match for"
    ],
    ".org.do" => [
        "server" => "http://www.nic.do/whoisingles.php3?dns_answer=&do=org.do&B1=Query&T1=",
        "available" => "This domain doesn't exist",
        "sldonly" => true
    ],
    ".org.ht" => [
        "server" => "whois.nic.ht",
        "available" => "Not Registered"
    ],
    ".org.za" => [
        "server" => "org-whois.registry.net.za",
        "available" => "Available"
    ],
    ".organic" => [
        "server" => "whois.afilias.net",
        "available" => "NOT FOUND"
    ],
    ".ovh" => [
        "server" => "whois-ovh.nic.fr",
        "available" => "does not exist"
    ],
    ".paris" => [
        "server" => "whois-paris.nic.fr",
        "available" => "does not exist"
    ],
    ".parliament.uk" => [
        "server" => "whois.nic.uk",
        "available" => "Available"
    ],
    ".partners" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".parts" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".pe" => [
        "server" => "kero.yachay.pe",
        "available" => "Not Registered"
    ],
    ".pf" => [
        "server" => "whois.registry.pf",
        "available" => "Domain unknown"
    ],
    ".ph" => [
        "server" => "http://bayanhosting.dot.ph/WhoIs.asp?Domain=",
        "available" => "is still available"
    ],
    ".pharmacien.fr" => [
        "server" => "whois.smallregistry.net",
        "available" => "Not found"
    ],
    ".photo" => [
        "server" => "whois.uniregistry.net",
        "available" => "is available for"
    ],
    ".photography" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".photos" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".physio" => [
        "server" => "whois.nic.physio",
        "available" => "No match"
    ],
    ".pics" => [
        "server" => "whois.uniregistry.net",
        "available" => "is available for"
    ],
    ".pictures" => [
        "server" => "whois.nic.pictures",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".pink" => [
        "server" => "whois.afilias.net",
        "available" => "NOT FOUND"
    ],
    ".pizza" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".pl" => [
        "server" => "whois.dns.pl",
        "available" => "No information available about domain"
    ],
    ".place" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".plumbing" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".pm" => [
        "server" => "whois.nic.pm",
        "available" => "No entries found"
    ],
    ".poker" => [
        "server" => "whois.afilias.net",
        "available" => "NOT FOUND"
    ],
    ".police.uk" => [
        "server" => "whois.nic.uk",
        "available" => "Available"
    ],
    ".porn" => [
        "server" => "whois.nic.porn",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".port.fr" => [
        "server" => "whois.smallregistry.net",
        "available" => "Not found"
    ],
    ".post" => [
        "server" => "whois.dotpostregistry.net",
        "available" => "NOT FOUND"
    ],
    ".pr" => [
        "server" => "whois.nic.pr",
        "available" => "available"
    ],
    ".press" => [
        "server" => "whois.nic.press",
        "available" => "Not found"
    ],
    ".priv.at" => [
        "server" => "whois.nic.priv.at",
        "available" => "no entries found"
    ],
    ".pro" => [
        "server" => "whois.registry.pro",
        "available" => "NOT FOUND",
        "namemin" => 4
    ],
    ".productions" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".properties" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".property" => [
        "server" => "whois.uniregistry.net",
        "available" => "is available"
    ],
    ".ps" => [
        "server" => "https://www.instra.com/whois/whoisengine/request/whoisinfo.php?domain_name=",
        "available" => "No Object Found"
    ],
    ".pt" => [
        "server" => "whois.dns.pt",
        "available" => "no match"
    ],
    ".pub" => [
        "server" => "whois.unitedtld.com",
        "available" => "Domain not found"
    ],
    ".pw" => [
        "server" => "whois.nic.pw",
        "available" => "Not found"
    ],
    ".qa" => [
        "server" => "whois.registry.qa",
        "available" => "No Data Found "
    ],
    ".qc.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".qpon" => [
        "server" => "whois.nic.qpon",
        "available" => "Not found"
    ],
    ".quebec" => [
        "server" => "whois.nic.quebec",
        "available" => "no matching objects found"
    ],
    ".re" => [
        "server" => "whois.nic.re",
        "available" => "No entries found"
    ],
    ".recipes" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".red" => [
        "server" => "whois.nic.red",
        "available" => "NOT FOUND"
    ],
    ".reise" => [
        "server" => "whois.nic.reise",
        "available" => "Not found"
    ],
    ".reisen" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".reit" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".ren" => [
        "server" => "whois.nic.ren",
        "available" => "The queried object does not exist: {\$domain}"
    ],
    ".rentals" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".repair" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".report" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".rest" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".restaurant" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".reviews" => [
        "server" => "whois.unitedtld.com",
        "available" => "Domain not found"
    ],
    ".rich" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".rio" => [
        "server" => "whois.gtlds.nic.br",
        "available" => "does not exist"
    ],
    ".ro" => [
        "server" => "whois.rotld.ro",
        "available" => "No entries found"
    ],
    ".rocks" => [
        "server" => "whois.nic.rocks",
        "available" => "Domain not found"
    ],
    ".rs" => [
        "server" => "whois.rnids.rs",
        "available" => "Domain is not registered"
    ],
    ".ru" => [
        "server" => "whois.ripn.net",
        "available" => "No entries found",
        "namemin" => 2
    ],
    ".ru.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".ruhr" => [
        "server" => "whois.nic.ruhr",
        "available" => "no matching objects found"
    ],
    ".rw" => [
        "server" => "whois.ricta.org.rw",
        "available" => "No Object Found"
    ],
    ".ryukyu" => [
        "server" => "whois.nic.ryukyu",
        "available" => "Not found"
    ],
    ".sa" => [
        "server" => "whois.nic.net.sa",
        "available" => "No match"
    ],
    ".sa.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".sale" => [
        "server" => "whois.nic.sale",
        "available" => "Domain not found"
    ],
    ".samsung" => [
        "server" => "whois.nic.samsung",
        "available" => "Not found"
    ],
    ".sarl" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".sb" => [
        "server" => "whois.nic.net.sb",
        "available" => "Not Registered"
    ],
    ".sc" => [
        "server" => "whois2.afilias-grs.net",
        "available" => "NOT FOUND"
    ],
    ".sca" => [
        "server" => "whois.nic.sca",
        "available" => "Available"
    ],
    ".scb" => [
        "server" => "whois.nic.scb",
        "available" => "NOT FOUND"
    ],
    ".schmidt" => [
        "server" => "whois.nic.schmidt",
        "available" => "No Data Found"
    ],
    ".schule" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".scot" => [
        "server" => "whois.nic.scot",
        "available" => "The queried object does not exist"
    ],
    ".se" => [
        "server" => "whois.iis.se",
        "available" => "not found."
    ],
    ".se.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".se.net" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".services" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".sew" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".sexy" => [
        "server" => "whois.uniregistry.net",
        "available" => "is available for"
    ],
    ".sg" => [
        "server" => "whois.nic.net.sg",
        "available" => "Domain Not Found"
    ],
    ".sh" => [
        "server" => "whois.nic.sh",
        "available" => "NOT FOUND"
    ],
    ".shiksha" => [
        "server" => "whois.nic.shiksha",
        "available" => "NOT FOUND"
    ],
    ".shoes" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".shop" => [
        "server" => "whois.nic.shop",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".show" => [
        "server" => "whois.nic.show",
        "available" => "Domain not found"
    ],
    ".si" => [
        "server" => "whois.arnes.si",
        "available" => "No entries found"
    ],
    ".singles" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".site" => [
        "server" => "whois.nic.site",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".sj" => [
        "server" => "whois.norid.no",
        "available" => "No match"
    ],
    ".sk" => [
        "server" => "whois.sk-nic.sk",
        "available" => "Not found."
    ],
    ".sky" => [
        "server" => "whois.nic.sky",
        "available" => "Available"
    ],
    ".sld.do" => [
        "server" => "http://www.nic.do/whoisingles.php3?dns_answer=&do=sld.do&B1=Query&T1=",
        "available" => "This domain doesn't exist",
        "sldonly" => true
    ],
    ".sm" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".sm.ua" => [
        "server" => "whois.net.ua",
        "available" => "No match record"
    ],
    ".sn" => [
        "server" => "whois.nic.sn",
        "available" => "No Object Found"
    ],
    ".so" => [
        "server" => "whois.nic.so",
        "available" => "Not found:"
    ],
    ".social" => [
        "server" => "whois.unitedtld.com",
        "available" => "Domain not found"
    ],
    ".software" => [
        "server" => "whois.rightside.co",
        "available" => "Domain not found"
    ],
    ".sohu" => [
        "server" => "whois.gtld.knet.cn",
        "available" => "No match"
    ],
    ".solar" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".solutions" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".st" => [
        "server" => "whois.nic.st",
        "available" => "No entries found"
    ],
    ".store" => [
        "server" => "whois.nic.store",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".su" => [
        "server" => "whois.ripn.net",
        "available" => "No entries found for the selected source(s)"
    ],
    ".sumy.ua" => [
        "server" => "whois.net.ua",
        "available" => "No match record"
    ],
    ".supplies" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".supply" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".support" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".surgery" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".swiss" => [
        "server" => "whois.nic.swiss",
        "available" => "no matching objects found"
    ],
    ".sx" => [
        "server" => "whois.sx",
        "available" => "Available"
    ],
    ".sydney" => [
        "server" => "whois.nic.sydney",
        "available" => "No match"
    ],
    ".systems" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".taipei" => [
        "server" => "whois.nic.taipei",
        "available" => "Available"
    ],
    ".tatar" => [
        "server" => "whois.nic.tatar",
        "available" => "does not exist"
    ],
    ".tattoo" => [
        "server" => "whois.uniregistry.net",
        "available" => "is available for"
    ],
    ".tax" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".tc" => [
        "server" => "whois.nic.tc",
        "available" => "No Object Found",
        "whoisserver" => "whois.adamsnames.tc"
    ],
    ".tech" => [
        "server" => "whois.centralnic.com",
        "available" => "The queried object does not exist"
    ],
    ".technology" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".tel" => [
        "server" => "whois.nic.tel",
        "available" => "No Data Found",
        "namemin" => 2
    ],
    ".tf" => [
        "server" => "whois.nic.tf",
        "available" => "No entries found"
    ],
    ".th" => [
        "server" => "whois.thnic.co.th",
        "available" => "No match for"
    ],
    ".tienda" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".tips" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".tires" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".tirol" => [
        "server" => "whois.nic.tirol",
        "available" => "free"
    ],
    ".tk" => [
        "server" => "whois.dot.tk",
        "available" => "domain name not known"
    ],
    ".tl" => [
        "server" => "whois.nic.tl",
        "available" => "Status: Not Registered"
    ],
    ".tm" => [
        "server" => "whois.nic.tm",
        "available" => "- Available"
    ],
    ".tn" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".to" => [
        "server" => "whois.tonic.to",
        "available" => "No match for"
    ],
    ".today" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".tokyo" => [
        "server" => "whois.nic.tokyo",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".tools" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".top" => [
        "server" => "whois.nic.top",
        "available" => "The queried object does not exist"
    ],
    ".town" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".toys" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".tr" => [
        "server" => "whois.nic.tr",
        "available" => "No match found"
    ],
    ".trade" => [
        "server" => "whois.nic.trade",
        "available" => "Not found"
    ],
    ".training" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".travel" => [
        "server" => "whois.nic.travel",
        "available" => "Not found:"
    ],
    ".trust" => [
        "server" => "whois.nic.trust",
        "available" => "Available"
    ],
    ".tv" => [
        "server" => "tvwhois.verisign-grs.com",
        "available" => "No match for"
    ],
    ".tw" => [
        "server" => "whois.twnic.net.tw",
        "available" => "No Found"
    ],
    ".tz" => [
        "server" => "whois.tznic.or.tz",
        "available" => "Available"
    ],
    ".ua" => [
        "server" => "whois.ua",
        "available" => "No entries found"
    ],
    ".ug" => [
        "server" => "whois.co.ug",
        "available" => "No entries found"
    ],
    ".uk" => [
        "server" => "whois.nic.uk",
        "available" => "No match for"
    ],
    ".uk.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".uk.net" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".university" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".uno" => [
        "server" => "whois.nic.uno",
        "available" => "Not found"
    ],
    ".uol" => [
        "server" => "whois.gtlds.nic.br",
        "available" => "does not exist"
    ],
    ".us" => [
        "server" => "whois.nic.us",
        "available" => "No Data Found"
    ],
    ".us.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".us.org" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".uy" => [
        "server" => "nic.uy",
        "available" => "No match for"
    ],
    ".uy.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".uz" => [
        "server" => "whois.cctld.uz",
        "available" => "not found in database"
    ],
    ".va" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".vacations" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".vc" => [
        "server" => "whois2.afilias-grs.net",
        "available" => "NOT FOUND"
    ],
    ".ve" => [
        "server" => "whois.nic.ve",
        "available" => "No match for"
    ],
    ".vegas" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".ventures" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".versicherung" => [
        "server" => "whois.nic.versicherung",
        "available" => "does not exist"
    ],
    ".veterinaire.fr" => [
        "server" => "whois.smallregistry.net",
        "available" => "Not found"
    ],
    ".vg" => [
        "server" => "whois.nic.vg",
        "available" => "not found..."
    ],
    ".viajes" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".video" => [
        "server" => "whois.rightside.co",
        "available" => "Domain not found"
    ],
    ".villas" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".vip" => [
        "server" => "whois.nic.vip",
        "available" => "This domain name has not been registered"
    ],
    ".vision" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".vlaanderen" => [
        "server" => "whois.nic.vlaanderen",
        "available" => "Not found"
    ],
    ".vote" => [
        "server" => "whois.afilias.net",
        "available" => "Domain not found"
    ],
    ".voting" => [
        "server" => "whois.nic.voting",
        "available" => "No match"
    ],
    ".voto" => [
        "server" => "whois.afilias.net",
        "available" => "Domain not found"
    ],
    ".voyage" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".wales" => [
        "server" => "whois.nic.wales",
        "available" => "Available"
    ],
    ".wang" => [
        "server" => "whois.gtld.knet.cn",
        "available" => "The queried object does not exist: {\$domain}"
    ],
    ".watch" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".web.do" => [
        "server" => "http://www.nic.do/whoisingles.php3?dns_answer=&do=web.do&B1=Query&T1=",
        "available" => "This domain doesn't exist",
        "sldonly" => true
    ],
    ".web.za" => [
        "server" => "web-whois.registry.net.za",
        "available" => "Available"
    ],
    ".webcam" => [
        "server" => "whois.nic.webcam",
        "available" => "Domain not found"
    ],
    ".website" => [
        "server" => "whois.nic.website",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".wed" => [
        "server" => "whois.nic.wed",
        "available" => "No Object Found"
    ],
    ".wedding" => [
        "server" => "whois.nic.wedding",
        "available" => "The domain has not been registered"
    ],
    ".wf" => [
        "server" => "whois.nic.wf",
        "available" => "No entries found"
    ],
    ".wien" => [
        "server" => "whois.nic.wien",
        "available" => "No match"
    ],
    ".wiki" => [
        "server" => "whois.nic.wiki",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".wme" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".work" => [
        "server" => "whois-dub.mm-registry.com",
        "available" => "Not Registered"
    ],
    ".works" => [
        "server" => "whois.donuts.co",
        "available" => "Domain not found"
    ],
    ".world" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".ws" => [
        "server" => "whois.worldsite.ws",
        "available" => "The queried object does not exist",
        "namemin" => 4
    ],
    ".wtc" => [
        "server" => "whois.nic.wtc",
        "available" => "Available"
    ],
    ".wtf" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".xxx" => [
        "server" => "whois.nic.xxx",
        "available" => "NOT FOUND"
    ],
    ".xyz" => [
        "server" => "whois.nic.xyz",
        "available" => "DOMAIN NOT FOUND"
    ],
    ".yachts" => [
        "server" => "whois.afilias-srs.net",
        "available" => "NOT FOUND"
    ],
    ".yokohama" => [
        "server" => "whois.nic.yokohama",
        "available" => "Not found"
    ],
    ".yt" => [
        "server" => "whois.nic.yt",
        "available" => "No entries found"
    ],
    ".yu" => [
        "server" => "whois.ripe.net",
        "available" => "no entries found"
    ],
    ".za" => [
        "server" => "http://co.za/cgi-bin/whois.sh?Domain=",
        "available" => "No Matches"
    ],
    ".za.com" => [
        "server" => "whois.centralnic.com",
        "available" => "Not found"
    ],
    ".zaporizhzhe.ua" => [
        "server" => "whois.net.ua",
        "available" => "No match record"
    ],
    ".zm" => [
        "server" => "whois.nic.zm",
        "available" => "No Object Found"
    ],
    ".zone" => [
        "server" => "whois.donuts.co",
        "available" => "Not found"
    ],
    ".zp.ua" => [
        "server" => "whois.net.ua",
        "available" => "No match record"
    ],
    ".中国" => [
        "server" => "cwhois.cnnic.cn",
        "available" => "No matching record"
    ],
    ".中文网" => [
        "server" => "whois.teleinfo.cn",
        "available" => "No matching record"
    ],
    ".公司" => [
        "server" => "whois.ngtld.cn",
        "available" => "No matching record"
    ],
    ".在线" => [
        "server" => "whois.teleinfo.cn",
        "available" => "No matching record"
    ],
    ".我爱你" => [
        "server" => "whois.gtld.knet.cn",
        "available" => "The queried object does not exist"
    ],
    ".网址" => [
        "server" => "whois.registry.knet.cn"
    ],
    ".网店" => [
        "server" => "whois.nic.xn--hxt814e",
        "available" => "The queried object does not exist: {\$domain}"
    ],
    ".网络" => [
        "server" => "whois.ngtld.cn",
        "available" => "No matching record"
    ],
    "dn.ua" => [
        "server" => "whois.net.ua",
        "available" => "No entries found"
    ],
    "lg.ua" => [
        "server" => "whois.net.ua",
        "available" => "No match record"
    ]
];