# Architektura

## Zasady, których się trzymam

**Jeden router.** OPNSense robi cały L3 — routing i filtrowanie. Kiedy dojdzie MikroTik, będzie pracował wyłącznie jako zarządzalny switch L2. Nie chcę dwóch miejsc, w których trzeba szukać, dlaczego pakiet nie doszedł.

**VLAN to tylko L2.** Same VLAN-y rozdzielają domeny rozgłoszeniowe i tyle. Cała izolacja bierze się z reguł na firewallu, nie z tagowania.

**Reguły minimalne, per źródłowy VLAN.** Żadnych szerokich „allow any to any" z komentarzem „dopracuję później". Jak robię wyjątek, to ląduje w [`notes/decyzje.md`](../notes/decyzje.md) z uzasadnieniem.

**Nazwy mówiące.** Schemat `rola+numer`: `lnx-db01`, `lnx-mon01`, `repo-01`, `pve-01`. Numeracja z zerem wiodącym, bo hostname Proxmoxa jest koszmarem do zmiany po dołączeniu do klastra.

**Zarządzanie osobno.** Do WebUI Proxmoxa nie da się dostać z VLAN-ów roboczych. Ani z AD, ani z Linuksów, ani z LXC. Tylko przez WireGuard albo bezpośrednio. To nie jest niedopatrzenie w regułach, to celowe.

## Podział na VLAN-y

| VLAN | Nazwa | Podsieć | Co tam siedzi |
|---|---|---|---|
| 10 | MGMT | `10.10.10.0/24` | monitoring, stacja zarządzania |
| 20 | WINDOWS-AD | `10.10.20.0/24` | DC01, PRINT01 |
| 30 | LINUX | `10.10.30.0/24` | serwery Linux |
| 40 | LXC | `10.10.40.0/24` | kontenery, lustro repo |
| 50 | WIREGUARD | `10.10.50.0/24` | pula dla klientów VPN |
| 60 | DMZ | — | zarezerwowany pod honeypot, jeszcze nie utworzony |

Sieć fizyczna to `192.168.8.0/24` — tam siedzi zarządzanie Proxmoxa (`192.168.8.2`) i mój laptop.

## Mosty w Proxmoxie

- `vmbr0` — fizyczny, WAN i zarządzanie
- `vmbr1` — VLAN-aware trunk, tędy idzie cały ruch wewnętrzny

Maszyny wewnętrzne wpinam wyłącznie w `vmbr1`. Wpięcie czegokolwiek wewnętrznego w `vmbr0` omija firewall i łamie cały sens podziału.

## Inwentarz

| Host | VMID | System | VLAN | IP | Rola |
|---|---|---|---|---|---|
| `pve-01` | — | Proxmox VE | fiz. | `192.168.8.2` | hypervisor |
| OPNSense | — | OPNSense 26.7 | trunk | bramy VLAN | router, firewall, VPN |
| `DC01` | — | Windows Server 2025 | 20 | `10.10.20.10` | AD DS, DNS, DHCP, chwilowo plikowy |
| `PRINT01` | — | Windows Server 2025 | 20 | — | serwer wydruku |
| `lnx-db01` | 301 | Rocky Linux 10 | 30 | `10.10.30.10` | PostgreSQL, wpięty w domenę |
| `lnx-mon01` | 101 | Rocky Linux 10 | 10 | `10.10.10.10` | k3s, monitoring |
| `repo-01` | 1000 | Rocky Linux 10 (LXC) | 40 | `10.10.40.10` | lustro dnf |

Domena: `lab.domain.com`, NetBIOS `LAB`.

## Storage

- 256 GB SSD — `local` i `local-lvm`, na system i obrazy
- 500 GB NVMe — pula ZFS `data`, `ashift=12`

`ashift=12` ustawiony przy tworzeniu puli, bo po fakcie się tego nie zmienia.
