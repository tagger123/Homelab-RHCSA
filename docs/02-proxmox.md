# Proxmox

Node: `pve-01.lab.domain.com`, zarządzanie pod `192.168.8.2`.

## Hostname

Ustawiony przy instalacji, z zerem wiodącym — `pve-01`, nie `pve1`. Zmiana hostname'a po dołączeniu node'a do klastra to operacja, której się po prostu nie robi. Lepiej od razu przyjąć schemat, który zniesie rozbudowę do dwucyfrowej liczby node'ów.

## Sieć

| Most | Rola |
|---|---|
| `vmbr0` | fizyczny — WAN i zarządzanie |
| `vmbr1` | VLAN-aware trunk, ruch wewnętrzny |

Maszyny wewnętrzne wyłącznie na `vmbr1`, z ustawionym tagiem VLAN. Wpięcie w `vmbr0` obchodzi firewall.

## Storage

- `local` / `local-lvm` — 256 GB SSD, system i obrazy
- `data` — pula ZFS na 500 GB NVMe, `ashift=12`

## Typ CPU

Dla maszyn z k3s ustawiam `host`. Domyślny `kvm64` nie przepuszcza części flag CPU i niektóre komponenty potrafią się o to potknąć.

## Konsola

noVNC nadaje się do ratowania maszyny, która nie wstaje. Do pracy z konfigami się nie nadaje — wklejanie wieloliniowego YAML-a rozjeżdża wcięcia i psuje kodowanie znaków. Straciłem na tym czas przy manifestach k8s.

Do wszystkiego, co ma więcej niż jedną linijkę, używam SSH.
