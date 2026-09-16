# Active Directory

Domena `lab.domain.com`, NetBIOS `LAB`. Windows Server 2025.

## DC01

VLAN20, `10.10.20.10`. Role: AD DS, DNS, DHCP. Tymczasowo także serwer plików — docelowo do wydzielenia.

## PRINT01

Serwer wydruku na osobnej maszynie. To nie jest przesada z separacją, tylko wniosek z historii PrintNightmare. Spooler ma na tyle brzydki dorobek CVE, że nie ma go po co trzymać na kontrolerze domeny.

## GPO i hasła

Polityka haseł działa **tylko** podpięta na poziomie domeny. Podpięcie jej pod pojedyncze OU nie da żadnego efektu — GPO się zaaplikuje, ale ustawienia haseł zostaną zignorowane.

Jeśli chcę różne polityki dla różnych grup, to wyłącznie przez Fine-Grained Password Policies (PSO).

Zajęło mi chwilę, zanim to zrozumiałem, bo brak efektu wygląda identycznie jak źle podpięte GPO.

## Wpinanie Linuksów w domenę

Stos: `realmd`, `sssd`, `authselect`, `oddjobd`.

**Nazwy grup AD w `/etc/sudoers.d` nie mogą zawierać spacji.** Nawet poprawnie zacytowana grupa ze spacją wywala błąd parsowania „group is empty". Trzymam się myślników: `Linux-Admins`, nie `Linux Admins`.

To jest błąd, który wygląda na problem z uprawnieniami, a jest problemem ze składnią.

## Kerberos a psql

Klient AD-owy domyślnie próbuje GSSAPI/Kerberos przy łączeniu do PostgreSQL. Przy testach uwierzytelniania hasłem trzeba to wyłączyć:

```
PGGSSENCMODE=disable psql -h 10.10.30.10 -U user -d baza
```

Bez tego dostaje się błąd, który sugeruje problem z hasłem, a chodzi o metodę uwierzytelnienia.
