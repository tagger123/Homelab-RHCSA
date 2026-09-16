# Pułapki

Rzeczy, na które wdepnąłem, zebrane w jednym miejscu. Kolejność mniej więcej według tego, ile czasu kosztowały.

---

**reposync z `--delete` bez `--arch=noarch`**

Kasuje pakiety `noarch` po kawałku, każdej nocy. Nie wywala błędu. Objawia się instalacjami wywalającymi się na losowych brakujących zależnościach.
→ Zawsze oba: `--arch=x86_64 --arch=noarch`.

---

**VirtIO na trunku OPNSense**

Sterownik `vtnet` we FreeBSD gubi tagi 802.1Q pod KVM. Link jest, interfejs wstaje, ruch tagowany nie przechodzi.
→ Karta trunkowa jako Intel E1000.

---

**Brak Reset States po dodaniu reguły blokującej**

OPNSense jest stateful, stare sesje żyją dalej. Wygląda dokładnie jak niedziałająca reguła.
→ `Diagnostics → States → Reset States`.

---

**Alias `This Firewall`**

Otwiera dostęp do bram wszystkich VLAN-ów, nie tylko tego, o który chodzi. Cicha dziura w izolacji.
→ `[VLAN] address` zamiast tego.

---

**Nazwa klucza GPG w Rocky 10**

Zmieniła się względem 8 i 9. Poprawna: `RPM-GPG-KEY-Rocky-10`. Starsze poradniki podają `RPM-GPG-KEY-rockyofficial`.

---

**Spacje w nazwach grup AD w sudoers**

`group is empty` przy parsowaniu, nawet z poprawnym cytowaniem. Błąd wygląda na problem z uprawnieniami.
→ Myślniki: `Linux-Admins`.

---

**Polityka haseł podpięta pod OU**

Nie działa. GPO się aplikuje, ustawienia haseł są ignorowane.
→ Podpiąć na poziomie domeny, a różnicowanie robić przez PSO.

---

**`listen_addresses` w PostgreSQL**

Zakomentowane domyślnie. Bez odkomentowania nic się nie połączy z zewnątrz.

---

**`pg_hba.conf` per sieć**

Wpis dla jednego VLAN-u nie obejmuje innego. Test z VLAN30 nie przejdzie na wpisie dla VLAN40.

---

**GSSAPI przy psql z hosta w domenie**

Klient AD-owy próbuje Kerberosa. Błąd sugeruje złe hasło.
→ `PGGSSENCMODE=disable` do testów hasłem.

---

**Nazewnictwo WireGuard w OPNSense 26.7**

Zakładki to **Instances** i **Peers**. Poradniki mówiące o „Local" i „Endpoints" są nieaktualne. Wtyczki się nie instaluje, WireGuard jest w kernelu.

---

**DHCP Relay — kolejność**

Nie da się wpisać IP bezpośrednio. Najpierw obiekt w *Destinations*, potem odwołanie w *Relays*.

---

**Wklejanie YAML-a przez noVNC**

Rozjeżdża wcięcia i psuje kodowanie. YAML potem nie parsuje się z komunikatem, który nie wskazuje przyczyny.
→ SSH do wszystkiego wieloliniowego.

---

**Hostname Proxmoxa**

Praktycznie nie do zmiany po dołączeniu do klastra. Ustalić schemat przed instalacją, z zerem wiodącym.
