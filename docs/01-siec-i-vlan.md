# Sieć i VLAN-y

## Trunk

Ruch wewnętrzny idzie tagowany przez `vmbr1` do OPNSense, tam się rozjeżdża na interfejsy VLAN.

Jedna rzecz kosztowała mnie sporo czasu na starcie: **karta trunkowa w OPNSense nie może być VirtIO.** Sterownik `vtnet` we FreeBSD ma znany problem ze znakowaniem 802.1Q pod KVM. Objaw jest podły, bo interfejs wstaje, link jest, a tagowane ramki po prostu nie przechodzą. Zmiana typu karty na Intel E1000 rozwiązuje sprawę.

## Wzorzec reguł per VLAN

Kolejność ma znaczenie, reguły są ewaluowane od góry:

1. **Allow** do `[VLAN] address` — czyli do własnej bramy i tylko do niej
2. **Allow** do `Destination: NOT RFC1918_LAB` — wyjście do internetu, z wykluczeniem sieci wewnętrznych
3. reszta wpada w domyślny block

Kluczowe: w kroku 1 **nie** używać aliasu `This Firewall`. On otwiera dostęp do bram wszystkich VLAN-ów naraz, co kompletnie niszczy izolację. Trzeba wskazać konkretny adres danego VLAN-u.

`RFC1918_LAB` to mój alias obejmujący wewnętrzne podsieci laba.

## DNS

Wszystkie wewnętrzne VLAN-y (10, 30, 40, 50) pytają DC01 pod `10.10.20.10:53`. Zrobiłem to **jedną regułą Floating** zamiast pięcioma per-VLAN.

To odstępstwo od wzorca wyżej i jestem tego świadomy — powtarzanie tej samej reguły w pięciu miejscach to pięć miejsc do zapomnienia przy zmianie. VLAN20 wykluczony, bo DC stoi lokalnie i nie potrzebuje przechodzić przez firewall.

## Reguły dodatkowe

Działające:

- VLAN10 → `10.10.40.10:80` — dostęp do lustra repo

Do dodania, jak wystawię exportery:

- VLAN10 → VLAN20 `:9182` — windows_exporter na DC01
- VLAN10 → VLAN30 `:9100` — node_exporter na lnx-db01
- VLAN40 → `10.10.30.10:5432` — PostgreSQL dla przyszłych kontenerów

## Reset states

**To jest rzecz, o której się zapomina i potem traci godzinę.**

OPNSense jest stateful. Po dodaniu reguły blokującej istniejące połączenia dalej działają, bo siedzą w tablicy stanów. Wygląda to dokładnie tak, jakby reguła nie działała.

`Diagnostics → States → Reset States` po każdej zmianie blokującej. Zawsze.

## DHCP Relay

Nieoczywista kolejność w UI. Nie da się wpisać adresu serwera DHCP bezpośrednio w relay — walidacja to odrzuca.

Trzeba najpierw:

1. zakładka **Destinations** — utworzyć nazwany obiekt wskazujący na DC01
2. zakładka **Relays** — dopiero tu odwołać się do tego obiektu
