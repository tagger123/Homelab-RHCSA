# Monitoring

Faza 6/7. **W trakcie, z otwartym problemem na końcu dokumentu.**

## lnx-mon01

VMID 101, Rocky Linux 10, VLAN10, `10.10.10.10/24`.
4 vCPU, 6 GB RAM, 40 GB dysku, typ CPU `host`.

## k3s zamiast kubeadm

Świadomy wybór. Składnia YAML i Helm jest identyczna, więc wszystko, czego się tu nauczę, przenosi się jeden do jednego. Różnica jest w warstwie, której na tym etapie i tak nie dotykam.

Gdy przyjdzie moment na pełny klaster, migracja jest do przejścia.

## Stack

`kube-prometheus-stack` z Helma — Prometheus, Grafana, Alertmanager w jednym.

Grafana: `http://10.10.10.10:30300`

Manifesty trzymam w `/root/k8s-manifest/` na `lnx-mon01`.

## Exportery

| Exporter | Gdzie | Port | Status |
|---|---|---|---|
| `pve_exporter` | lnx-mon01 (pod) | — | pod działa, scrape nie |
| `windows_exporter` | DC01 | 9182 | do wdrożenia |
| `node_exporter` | lnx-db01 | 9100 | do wdrożenia |

Reguły firewalla pod dwa ostatnie są opisane, ale jeszcze nie dodane — dodaję je razem z wdrożeniem, nie wcześniej.

## Otwarty problem — scrape target `pve`

**Objaw:** target `pve` w Prometheusie ma `health: down`. Zapytanie `up{job="pve"}` w Grafanie nie zwraca nic.

**Co już sprawdzone:**

- pod `pve_exporter` działa
- odpytany ręcznie zwraca poprawne metryki `pve_*`

Czyli sam exporter jest w porządku. Problem siedzi między Prometheusem a exporterem.

**Gdzie szukać dalej:**

1. definicja targetu w konfiguracji Prometheusa — adres i port, pod jakim próbuje się dobić
2. czy `ServiceMonitor` ma selektor zgodny z labelami serwisu
3. czy serwis w ogóle wystawia port, na który leci scrape
4. `kubectl logs` z poda Prometheusa — co konkretnie zgłasza przy próbie

Podejrzenie idzie w stronę punktu 2, bo to najczęstsze źródło ciszy zamiast błędu przy kube-prometheus-stack.

## Dalej

- domknąć powyższe
- `windows_exporter` na DC01 + reguła VLAN10 → VLAN20:9182
- `node_exporter` na lnx-db01 + reguła VLAN10 → VLAN30:9100
- dashboardy w Grafanie, jak będą dane ze wszystkich trzech źródeł
