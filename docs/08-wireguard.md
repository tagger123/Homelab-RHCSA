# WireGuard

Faza 2. **Częściowo działa.**

## Konfiguracja

Serwer na OPNSense 26.7, port **51900**. Pula dla klientów: VLAN50, `10.10.50.0/24`.

W 26.7 konfiguruje się to w zakładkach **Instances** i **Peers**. Poradniki mówiące o „Local" i „Endpoints" dotyczą starszych wersji. WireGuard siedzi w kernelu, nic się nie doinstalowuje.

## DDNS

DuckDNS, skonfigurowany na OPNSense.

**I tu jest problem.** Tunel wstaje, gdy w konfiguracji klienta wpiszę surowy adres IP. Po hostname z DuckDNS — nie wstaje.

Skoro po IP działa, to sam WireGuard i reguły są w porządku. Rzecz rozbija się o rozwiązywanie nazwy albo o aktualizację rekordu.

Do sprawdzenia:

1. czy DuckDNS faktycznie ma aktualny adres — porównać rekord z tym, co widać na zewnątrz
2. czy klient w ogóle rozwiązuje ten hostname (`nslookup` z sieci zewnętrznej)
3. czy OPNSense wysyła update — logi klienta DDNS
4. czy nie siedzę za CGNAT, co unieważniłoby cały pomysł

Punkt 4 jest wart sprawdzenia w pierwszej kolejności, bo jeśli operator daje adres z puli współdzielonej, to żaden DDNS tego nie naprawi i trzeba iść w stronę VPS-a jako punktu wejścia.

## Road warrior — niedokończone

Docelowo laptop ma się wpinać z dowolnej sieci i widzieć zasoby laba.

Zostało do zrobienia:

- laptop jako peer z adresem w `10.10.50.0/24`
- `AllowedIPs` obejmujące wewnętrzne podsieci
- routing z VLAN50 do pozostałych VLAN-ów, z regułami ograniczającymi zasięg
- test z sieci zewnętrznej, nie z domowej

Osobno: połączenie z `192.168.8.0/24` do zakresu `10.10.10.x` przez OPNSense było planowane, ale nie doszło do skutku.

## Po co to

Zdalne zarządzanie Proxmoxem bez otwierania WebUI z VLAN-ów roboczych. VPN jest jedyną drogą dostępu do warstwy zarządzania spoza sieci fizycznej — patrz [00-architektura.md](00-architektura.md).
