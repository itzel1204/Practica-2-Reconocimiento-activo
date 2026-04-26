from scapy.all import IP, ICMP, TCP, UDP, sr


def craft_discovery_pkts(protocols, ip_range, counts=None, port=80):
    if isinstance(protocols, str):
        protocols = [protocols]

    protocols = [p.lower() for p in protocols]
    allowed = {"udp", "tcp_ack", "icmp_timestamp"}

    for proto in protocols:
        if proto not in allowed:
            raise ValueError(f"Protocolo no soportado: {proto}")

    if counts is None:
        counts = {}

    packets = []

    for proto in protocols:
        number = counts.get(proto, 1)

        for _ in range(number):
            if proto == "udp":
                packets.append(IP(dst=ip_range) / UDP(dport=port))

            elif proto == "tcp_ack":
                packets.append(IP(dst=ip_range) / TCP(dport=port, flags="A"))

            elif proto == "icmp_timestamp":
                packets.append(IP(dst=ip_range) / ICMP(type=13))

    return packets


def discover_hosts(protocols, ip_range, counts=None, port=80, timeout=2):
    packets = craft_discovery_pkts(protocols, ip_range, counts, port)

    answered, unanswered = sr(packets, timeout=timeout, verbose=False)

    active_ips = set()

    for sent, received in answered:
        active_ips.add(received.src)

    return sorted(active_ips)


if __name__ == "__main__":
    target = input("Introduce una IP o rango CIDR, por ejemplo 192.168.1.0/24: ")

    protocols = ["udp", "tcp_ack", "icmp_timestamp"]

    print(f"\n[*] Enviando paquetes de descubrimiento a {target}...\n")

    active_hosts = discover_hosts(protocols, target)

    if active_hosts:
        print("[+] Hosts activos encontrados:")
        for host in active_hosts:
            print(f" - {host}")
    else:
        print("[-] No se detectaron hosts activos.")
