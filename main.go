package main

import (
	"fmt"
	"net"
	"os"
	"strings"

	dnsserver "github.com/docker/dnsserver"
)

func main() {

	zone := os.Getenv("ZONE")

	if zone == "" {
		zone = "com"
	}

	ds := dnsserver.NewDNSServer(zone)

	domains := os.Getenv("DOMAINS")

	if domains == "" {
		domains = "test=127.0.0.1"
	}

	domainsAr := strings.Split(domains, ",")

	for _, v := range domainsAr {
		domainValues := strings.Split(v, "=")
		ds.SetA(domainValues[0], net.ParseIP(domainValues[1]))
	}

	fmt.Println("Starting DNS Server")
	fmt.Println("Domains: " + domains)
	if len(os.Args) > 1 {
		if err := ds.Listen(os.Args[1]); err != nil {
			panic(err)
		}
	} else {
		if err := ds.Listen("0.0.0.0:53"); err != nil {
			panic(err)
		}
	}

}
