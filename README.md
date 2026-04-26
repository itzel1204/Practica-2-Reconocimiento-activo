# Práctica 2: Reconocimiento activo

En esta práctica se han implementado técnicas de reconocimiento activo en redes utilizando herramientas como Scapy y Nmap. 
Por un lado, se ha desarrollado una función en Python capaz de generar y enviar paquetes de red (UDP, TCP ACK e ICMP timestamp) para detectar hosts activos. 
Por otro lado, se ha analizado el comportamiento de Nmap en el escaneo de puertos, observando cómo identifica puertos abiertos y cerrados a partir de las respuestas del sistema.

El objetivo principal es comprender cómo funcionan estas técnicas a bajo nivel y cómo se pueden utilizar para obtener información sobre dispositivos y servicios en una red.


## Estructura del proyecto

```text
P2_Reconocimiento_activo
├── doc
│   ├── bibliography.bib
│   ├── images
│   ├── report.typ
│   └── report.pdf
├── src
│   ├── host_discovery.py
│   ├── host_discovery.ipynb
│   └── pyproject.toml
├── pyproject.toml
├── README.md
└── .gitignore
```

```md
- Autor = Itzel Fajardo Umpierrez
- Grado = Ingenieria De Ciberseguridad
- Asignatura = Tecnicas De Hacking
```
