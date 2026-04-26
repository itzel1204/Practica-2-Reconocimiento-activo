#set document(
  title: "Práctica 2: Reconocimiento activo",
  author: "Itzel Fajardo Umpierrez",
)

#align(center)[
  #text(18pt, weight: "bold")[Práctica 2: Reconocimiento activo]

  #v(0.3cm)

  Técnicas de hacking

  Itzel Fajardo Umpierrez

  #datetime.today().display()
]

#pagebreak()

= Resumen

En esta práctica se ha realizado el análisis de técnicas de reconocimiento activo en un entorno controlado. Se ha desarrollado una herramienta en Python utilizando Scapy para detectar hosts activos mediante distintos tipos de paquetes de red.

También se ha estudiado el comportamiento de Nmap para identificar el estado de los puertos y comprender las respuestas generadas por el sistema.

= Índice

#outline()

= Introducción

El reconocimiento activo permite identificar sistemas disponibles mediante el envío de paquetes de red y el análisis de sus respuestas.

A diferencia del reconocimiento pasivo, este método genera tráfico directo, lo que permite obtener información más precisa sobre los sistemas.

En esta práctica se utilizan Scapy y Nmap para analizar este comportamiento.

= Desarrollo

== Entorno de trabajo

La práctica se ha realizado en una máquina virtual Kali Linux en un entorno controlado.

La estructura del repositorio es:

```text
P2_Reconocimiento_activo
├── doc
│   ├── bibliography.bib
│   ├── images
│   ├── report.typ
├── src
│   ├── host_discovery.py
│   ├── host_discovery.ipynb
│   └── pyproject.toml
├── README.md

```

== Descubrimiento de hosts con Scapy

Se implementó una función para generar paquetes utilizando:

UDP
TCP ACK
ICMP timestamp

Estos paquetes se envían usando sr() para detectar respuestas.

== Pruebas

=== Host activo

discover_hosts("icmp_timestamp", "127.0.0.1")

Resultado:

['127.0.0.1']


=== Host inactivo

discover_hosts("icmp_timestamp", "10.255.255.1")

Resultado:

[]

=== Múltiples protocolos

discover_hosts(["udp", "tcp_ack", "icmp_timestamp"], "127.0.0.1")

Resultado:

['127.0.0.1']

#figure(
  image("images/scapy_host_activo.png", width: 90%),
)

== Evidencia con tcpdump

sudo tcpdump -i lo -nn icmp

#figure(
  image("images/tcpdump1.png", width: 90%),
)
#figure(
  image("images/tcpdump2.png", width: 90%),
)
Se incluyen también archivos .pcap en el repositorio para análisis adicional.

= Nmap y estado de puertos

== Estados

Abierto -> responde con SYN/ACK
Cerrado -> responde con RST
Filtrado -> no hay respuesta

== Pruebas

nmap 127.0.0.1
#figure(
  image("images/nmap1.png", width: 90%),
)

nmap -p 80 127.0.0.1
#figure(
  image("images/nmap2.png", width: 90%),
)

nmap -p 81 127.0.0.1
#figure(
  image("images/nmap3.png", width: 90%),
)

== Captura de tráfico

sudo tcpdump -i lo -nn host 127.0.0.1

#figure(
  image("images/tcpdump_nmap1.png", width: 90%),
)

#figure(
  image("images/tcpdump_nmap.png", width: 90%),
)



= Resultados

#table(
columns: (1fr, 1fr, 1fr),
[Prueba], [Resultado], [Interpretación],

[Host activo], [['127.0.0.1']], [Detectado correctamente],
[Host inactivo], [[]], [Sin respuesta],
[Múltiples protocolos], [['127.0.0.1']], [Funcionamiento correcto],
[Puerto abierto], [Detectado], [Servicio activo],
[Puerto cerrado], [Detectado], [Sin servicio],
)

= Conclusiones

Se ha comprobado que mediante Scapy es posible detectar hosts activos mediante el envío de paquetes personalizados.

También se ha analizado cómo Nmap identifica el estado de los puertos a partir de las respuestas del sistema.

Estas herramientas permiten comprender el funcionamiento del reconocimiento activo a bajo nivel.

= Bibliografía

#bibliography("bibliography.bib", full: true)


