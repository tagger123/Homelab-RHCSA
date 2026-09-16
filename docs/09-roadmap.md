# Roadmapa

Pracuję fazami, z jawnym warunkiem zamknięcia każdej. Faza jest skończona, gdy powstał do niej dokument i wpis w dzienniku wdrożenia — nie gdy „w sumie działa".

Dzięki temu po dwóch miesiącach przerwy wiem, gdzie stanąłem.

## Stan faz

| Faza | Zakres | Stan |
|---|---|---|
| 0 | Proxmox, storage, mosty | zamknięta |
| 1 | OPNSense, VLAN-y, reguły bazowe | zamknięta |
| 2 | WireGuard, DDNS | **częściowa** — DDNS nie rozwiązuje |
| 3 | AD DS, DNS, DHCP, PRINT01 | zamknięta |
| 4 | Flota Linux, wpięcie w domenę, PostgreSQL | zamknięta |
| 4.5 | `genbot-01` — generator ruchu | **odłożona celowo** |
| 5 | Lustro repozytoriów | zamknięta |
| 6/7 | Monitoring — k3s, Prometheus, Grafana | **w trakcie** |

## Dlaczego 4.5 jest odłożona

`genbot-01` (VMID 302, `10.10.30.20`, VLAN30) ma generować ruch, żeby monitoring i późniejsze wykrywanie miały co obserwować.

Generator ruchu jest przydatny dopiero wtedy, gdy jest co mierzyć. Bez działających dashboardów produkowałbym ruch donikąd. Wraca na koniec roadmapy.

## Do domknięcia najpierw

1. scrape target `pve` w Prometheusie — szczegóły w [07-monitoring.md](07-monitoring.md)
2. `windows_exporter` na DC01, `node_exporter` na lnx-db01, plus reguły firewalla
3. reguła VLAN40 → `10.10.30.10:5432`
4. DDNS albo potwierdzenie CGNAT — [08-wireguard.md](08-wireguard.md)
5. road warrior WireGuard do końca

## Dalej

**Honeypot w DMZ.** VLAN60, Cowrie na SSH, logi do Wazuha. Zablokowane, dopóki nie potwierdzę, czy mam publiczny adres i czy regulamin operatora tego nie zabrania. Alternatywa: VPS w chmurze jako miejsce wystawienia — wtedy problem CGNAT znika, ale dochodzi koszt.

**Terraform + Ansible.** Terraform stawia maszyny, Ansible konfiguruje. Zamiast ręcznego klikania.

Nie zaczynam tego wcześniej celowo. Automatyzowanie procedury, której się jeszcze nie rozumie, kończy się kodem, który działa i nie wiadomo dlaczego.

**Drugi kontroler domeny.** Redundancja AD. Pojedynczy DC to pojedynczy punkt awarii, ale przy 24 GB RAM to na razie luksus.

**Rozbudowa Proxmoxa do klastra.** Perspektywa roku–dwóch. Wtedy dopiero sens ma dedykowany sprzęt pod monitoring.
