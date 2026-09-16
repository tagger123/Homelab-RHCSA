# Flota Linux

Cała flota na Rocky Linux 10. Jeden system, jedna wersja — nie chcę tracić czasu na różnice między dystrybucjami, chcę je tracić na rzeczy, których się uczę.

## Maszyny

| Host | VMID | VLAN | IP | Rola |
|---|---|---|---|---|
| `lnx-db01` | 301 | 30 | `10.10.30.10` | PostgreSQL, wpięty w AD |
| `lnx-mon01` | 101 | 10 | `10.10.10.10` | k3s, monitoring |
| `repo-01` | 1000 | 40 | `10.10.40.10` | LXC, lustro dnf |

## Klucz GPG w Rocky 10

Nazwa pliku zmieniła się względem Rocky 8 i 9. Poprawna to:

```
/etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-10
```

Duże R, numer wersji. Nie `RPM-GPG-KEY-rockyofficial` — ta nazwa jest ze starszych wydań i wszystkie starsze poradniki ją podają.

Poprawione we wszystkich plikach `.repo` na flocie.

## PostgreSQL na lnx-db01

Dwie rzeczy, które trzeba ruszyć, żeby cokolwiek połączyło się z zewnątrz:

**`postgresql.conf`** — `listen_addresses` jest domyślnie zakomentowane. Odkomentować i ustawić. U mnie `10.10.30.10`, nie wildcard — nie ma powodu, żeby nasłuchiwał na wszystkim.

**`pg_hba.conf`** — osobny wpis na każdą sieć. Wpis dla VLAN40 nie obejmie połączeń testowych z VLAN30. Oczywiste, jak się wie, mniej oczywiste, jak się debuguje.

Do testów z hosta w domenie: `PGGSSENCMODE=disable`, szczegóły w [04-active-directory.md](04-active-directory.md).

## Automatyzacja

Timery systemd zamiast crona. Konkretnie:

- `RandomizedDelaySec` — rozrzut startów, żeby kilka zadań nie ruszyło w tej samej sekundzie
- `Persistent=true` — nadrabia przebieg, jeśli maszyna była wyłączona
- logi w `journalctl` razem z resztą systemu

Cron nie daje żadnej z tych trzech rzeczy bez dopisywania obudowy wokół.

Schemat: para `.service` + `.timer` na każde zadanie.
