# RHCSA EX200

Osobny wątek od reszty repo. Przygotowanie do egzaminu RHCSA na RHEL 10.

**Uwaga o adresacji.** Ten lab ma własną topologię (`10.0.0.0/24`) — osobną od labu głównego. Nie mieszać adresów między jednym a drugim.

## Topologia

Trzy elementy, celowo odwzorowujące układ firmowy:

| Host | Rola |
|---|---|
| DC | Windows Server 2025, Active Directory |
| MASTER | lokalny hub pakietów RHEL |
| node1, node2 | maszyny ćwiczeniowe |

Sens tego układu: na egzaminie pracuje się na czystych maszynach, ale w pracy nigdy nie pracuje się w próżni. Ćwiczenie z działającym DNS-em, katalogiem i lokalnym repo jest bliższe rzeczywistości.

## Hub pakietów

`reposync` + `createrepo_c` + Nginx na MASTER.

Poza wygodą to ćwiczenie samo w sobie — postawienie repozytorium wymaga zrozumienia, jak `dnf` w ogóle znajduje pakiety.

## Podman

**Nie jest już częścią wymagań RHCSA dla RHEL 10.** Warto sprawdzić aktualną listę celów przed nauką, bo materiały krążące w sieci wciąż go uwzględniają i można stracić czas na temat spoza zakresu.

## Pliki

- [`plan-nauki.md`](plan-nauki.md) — rozpiska 14 tygodni
- [`egzamin-probny.md`](egzamin-probny.md) — 27 zadań pokrywających cele egzaminu
