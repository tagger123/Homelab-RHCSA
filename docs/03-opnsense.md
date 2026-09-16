# OPNSense

Wersja 26.7. Robi za router, firewall, DHCP relay i serwer WireGuard.

## Interfejsy

Karta trunkowa jako **Intel E1000**, nie VirtIO. Powód opisany w [01-siec-i-vlan.md](01-siec-i-vlan.md) — krótko: `vtnet` gubi tagi 802.1Q pod KVM.

Na trunku wiszą interfejsy VLAN 10, 20, 30, 40, 50. Każdy z własną bramą `.1`.

## Filozofia reguł

Domyślnie blokuję wszystko, otwieram punktowo. Każde otwarcie ma mieć powód, który da się zapisać jednym zdaniem. Jeśli nie umiem tego zdania napisać, to znaczy, że nie wiem, po co otwieram.

Pełny wzorzec i lista aktywnych reguł — [01-siec-i-vlan.md](01-siec-i-vlan.md).

## Pułapki UI

**`This Firewall`** — alias, który wygląda niewinnie, a otwiera dostęp do bram wszystkich VLAN-ów. Zamiast niego `[VLAN] address`.

**Reset States** — po każdej zmianie blokującej. `Diagnostics → States → Reset States`. Bez tego stare sesje żyją dalej i wygląda, jakby reguła nie zadziałała.

**DHCP Relay** — najpierw obiekt w *Destinations*, dopiero potem odwołanie w *Relays*.

**WireGuard** — w 26.7 zakładki nazywają się **Instances** i **Peers**. Większość poradników w sieci mówi o „Local" i „Endpoints", co jest nazewnictwem ze starszych wersji i tylko myli. WireGuard jest wbudowany w kernel, żadnej wtyczki się nie instaluje.

## Dostęp do Proxmoxa

Świadomie nie ma reguły pozwalającej wejść na WebUI Proxmoxa z VLAN-ów roboczych. Zarządzanie idzie przez WireGuard albo z sieci fizycznej.

Gdyby ktoś przejął maszynę w VLAN30, nie dostaje w prezencie panelu hypervisora.
