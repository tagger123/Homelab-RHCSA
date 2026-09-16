# Plan nauki — 14 tygodni

Rozpiska zbudowana wokół oficjalnych celów RHEL 10, z lab-em jako środowiskiem ćwiczeniowym.

Założenie: każdy blok kończy się zrobieniem czegoś działającego, nie przeczytaniem rozdziału.

## Bloki

**1–2. Podstawy i narzędzia**
Powłoka, przekierowania, potoki. `grep`, `sed`, `awk` w zakresie, jaki realnie pojawia się na egzaminie. Edycja plików w `vim` na tyle sprawnie, żeby nie tracić na to czasu.

**3–4. Pliki, uprawnienia, procesy**
Prawa, właściciele, bity specjalne. ACL. Zarządzanie procesami, priorytety, sygnały.

**5. Boot i systemd**
Jednostki, targety, zależności. Zmiana domyślnego targetu. Ratowanie systemu przez GRUB, reset hasła roota.

**6. Storage**
Partycje, LVM, rozszerzanie wolumenów. `/etc/fstab` i UUID-y. Swap. Stratis, jeśli jest w celach.

**7. Sieć**
`nmcli`, konfiguracja statyczna, hostname, rozwiązywanie nazw. Odtwarzanie konfiguracji po restarcie.

**8. Pakiety**
`dnf`, moduły, definiowanie własnych repozytoriów. Tu wchodzi hub na MASTER. Flatpak.

**9. Użytkownicy i uwierzytelnianie**
Konta lokalne, grupy, polityka haseł. `sudo`. Integracja z katalogiem.

**10. SELinux**
Tryby, konteksty, booleany. Diagnozowanie odmów z logów. To jest blok, który najczęściej odpada na egzaminie, więc dostaje własny tydzień.

**11. firewalld**
Strefy, usługi, porty, `rich rules`. Trwałość konfiguracji po restarcie.

**12. Zadania i czas**
`cron`, `at`, timery systemd. `chrony` i synchronizacja czasu.

**13. autofs i NFS**
Montowanie automatyczne, mapy, katalogi domowe z sieci.

**14. Powtórka i egzamin próbny**
Przejście [`egzamin-probny.md`](egzamin-probny.md) na czas, na czystych maszynach.

## Jak ćwiczę

Na czystym snapshocie, nie na maszynie z poprzedniego ćwiczenia. Zadanie zrobione raz na już-skonfigurowanym systemie nie uczy niczego o konfigurowaniu.

Po każdym bloku restart maszyny i sprawdzenie, czy to, co zrobiłem, przetrwało. Na egzaminie sprawdzane jest zachowanie po reboocie, a nie stan sesji.
