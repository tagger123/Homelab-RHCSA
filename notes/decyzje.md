# Decyzje

Świadome kompromisy. Zapisuję je, bo za pół roku nie będę pamiętał, czy coś jest wyborem, czy niedopatrzeniem.

---

## k3s zamiast kubeadm

**Za:** lżejszy, wstaje od razu, mieści się w budżecie RAM-u. Składnia YAML i Helm identyczna jak w pełnym Kubernetesie.

**Przeciw:** to nie jest dokładnie to, co stoi w produkcji.

**Dlaczego tak:** wszystko, czego się uczę na tym poziomie, przenosi się jeden do jednego. Różnice siedzą w warstwie, której na tym etapie nie dotykam. Migracja później jest do przejścia.

---

## DNS jedną regułą Floating

**Za:** jedno miejsce zamiast pięciu identycznych reguł per VLAN.

**Przeciw:** łamie wzorzec „reguły per źródłowy VLAN", którego trzymam się wszędzie indziej.

**Dlaczego tak:** pięć kopii tej samej reguły to pięć miejsc, w których można zapomnieć o zmianie. VLAN20 wykluczony, bo DC jest tam lokalnie.

To jedyne odstępstwo od wzorca i ma tu zostać jedynym.

---

## Brak dostępu do Proxmoxa z VLAN-ów roboczych

**Za:** przejęcie maszyny w dowolnym VLAN-ie nie daje dostępu do hypervisora.

**Przeciw:** żeby cokolwiek zrobić zdalnie, muszę najpierw wstać z VPN-em.

**Dlaczego tak:** panel hypervisora to klucz do wszystkich maszyn naraz. Niewygoda jest tu ceną, którą płacę świadomie.

---

## PRINT01 osobno od DC

**Za:** Spooler ma paskudną historię CVE, PrintNightmare to tylko najgłośniejszy przypadek.

**Przeciw:** kolejna maszyna zjadająca RAM, którego nie mam za dużo.

**Dlaczego tak:** rola z takim dorobkiem nie ma czego szukać na kontrolerze domeny.

---

## `genbot-01` odłożony na koniec

**Dlaczego:** generator ruchu ma sens, gdy jest co obserwować. Dopóki monitoring nie działa w całości, produkowałbym ruch donikąd.

---

## Terraform i Ansible dopiero po domknięciu wczesnych faz

**Dlaczego:** automatyzacja procedury, której się jeszcze nie rozumie, daje kod działający z niejasnych powodów. Najpierw ręcznie, ze zrozumieniem, potem opakować.

---

## Rocky Linux 10 na całej flocie

**Dlaczego:** jedna dystrybucja, jedna wersja. Chcę tracić czas na rzeczy, których się uczę, a nie na różnice w nazwach pakietów.

---

## Lustro repozytoriów zamiast ciągnięcia z sieci

**Za:** oszczędza łącze, lab działa bez internetu, przy okazji nauka reposync i nginx.

**Przeciw:** kolejny kontener do utrzymania, plus błąd z `--delete` pokazał, że to nie jest „postaw i zapomnij".

**Dlaczego tak:** flota ciągnie te same pakiety w kółko. Przy ograniczonym łączu to realna różnica.

---

## Timery systemd zamiast crona

**Dlaczego:** `RandomizedDelaySec`, `Persistent=true` i logi w `journalctl`. Cron nie daje żadnej z tych rzeczy bez dopisywania obudowy.

---

## MikroTik jako czysty L2

**Dlaczego:** gdy routing jest w dwóch miejscach, debugowanie zaczyna się od pytania „które urządzenie to zrobiło". Wolę mieć jedną odpowiedź. OPNSense trzyma cały L3.
