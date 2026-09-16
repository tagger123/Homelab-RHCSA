# Homelab

Dokumentacja mojego laba. Buduję go po to, żeby mieć gdzie ćwiczyć rzeczy, których w pracy albo nie dotykam, albo dotykam raz na pół roku: segmentację sieci, centralną tożsamość, monitoring, provisioning.

Założenie jest takie, że lab ma wyglądać jak mała firma, a nie jak zbiór kontenerów na jednym Dockerze. Stąd osobne VLAN-y, osobny kontroler domeny, osobny serwer wydruku, własne lustro repozytoriów.

## Sprzęt

Dell mini PC, i5 10. generacji, 24 GB RAM. Dysk systemowy 256 GB SSD, do tego 500 GB NVMe jako pula ZFS.

Tak, to mało. Świadomie — chodzi o to, żeby nauczyć się planować zasoby, a nie żeby mieć ich w nadmiarze.

## Stos

| Warstwa | Co |
|---|---|
| Hypervisor | Proxmox VE, node `pve-01` |
| Router / firewall | OPNSense 26.7 |
| Tożsamość | Windows Server 2025 — AD DS, DNS, DHCP |
| Linux | Rocky Linux 10 (cała flota) |
| Kontenery | k3s |
| Monitoring | kube-prometheus-stack (Prometheus, Grafana, Alertmanager) |
| VPN | WireGuard na OPNSense |

W planach Terraform + Ansible, ale dopiero jak domknę wcześniejsze fazy. Nie ma sensu automatyzować czegoś, czego jeszcze nie umiem zrobić ręcznie.

## Co gdzie znaleźć

- [`docs/`](docs/) — opis poszczególnych warstw, od architektury po monitoring
- [`notes/`](notes/) — pułapki, na które wdepnąłem, i decyzje projektowe z uzasadnieniem
- [`rhcsa/`](rhcsa/) — osobny wątek: przygotowanie do egzaminu RHCSA EX200

## Stan na teraz

Fazy 0–5 zamknięte. Siedzę w fazie 6/7 (monitoring) i mam tam otwarty problem: target `pve` w Prometheusie leci `health: down`. Szczegóły w [`docs/07-monitoring.md`](docs/07-monitoring.md).

Faza 2 (WireGuard) jest domknięta połowicznie — tunel wstaje po surowym IP, po hostname z DuckDNS nie. Opis w [`docs/08-wireguard.md`](docs/08-wireguard.md).

## Uwaga o adresacji

W dokumentacji używam `lab.domain.com` i adresacji `10.10.0.0/16`. To jest lab domowy.

Materiały RHCSA w katalogu `rhcsa/` opisują osobną topologię (`10.0.0.0/24`) — zbudowaną pod kątem egzaminu, niezwiązaną z labiową siecią produkcyjną. Nie mieszać.
