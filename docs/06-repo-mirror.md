# Lustro repozytoriów

`repo-01`, LXC o VMID 1000, Rocky Linux 10, VLAN40, `10.10.40.10`.

Powód istnienia: flota ciągnie te same pakiety, a łącze jest jakie jest. Przy okazji lab działa, gdy internet nie.

## Co jest lustrzane

BaseOS i AppStream, `x86_64` + `noarch`.

Ścieżki:

```
http://10.10.40.10/rocky/10/baseos/
http://10.10.40.10/rocky/10/appstream/
```

## Jak to działa

`dnf reposync` ściąga, nginx serwuje. Synchronizacja odpalana z timera systemd, nocą.

## Błąd, który mnie kosztował sporo

Skrypt synchronizacji miał `--arch=x86_64`, ale **nie miał** `--arch=noarch`. Do tego `--delete`.

Efekt: każdej nocy reposync widział pakiety `noarch` jako „nie należące do lustra" i kasował kolejną ich porcję. Lustro powoli gniło i objawiało się to instalacjami wywalającymi się na brakujących zależnościach — za każdym razem na innych, więc długo wyglądało to na przypadek.

Poprawka: **oba** argumenty `--arch`.

```
--arch=x86_64 --arch=noarch
```

Morał ogólniejszy: `--delete` w połączeniu z niepełnym filtrem to cicha piła. Nie wywala błędu, tylko po kawałku zabiera dane.

## Do zrobienia

Ewentualne dołożenie `extras` i EPEL, jeśli okaże się potrzebne. Na razie BaseOS + AppStream wystarcza.
