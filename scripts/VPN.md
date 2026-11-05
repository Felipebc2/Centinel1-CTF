# VPN da competição

Os retos ficam em `10.10.10.0/24`, acessível só pela VPN. Plataforma e envio de flags não precisam dela.

## Setup (uma vez)

1. Instale o WireGuard: `sudo pacman -S wireguard-tools` (Arch) ou `sudo apt install wireguard-tools` (Debian/Ubuntu).
2. Coloque o **seu** arquivo na raiz do repo: Player B = `team-71-player-b.conf`, Player C = `team-71-player-c.conf`. Ele é ignorado pelo git, **nunca commite**.

## Uso

```bash
chmod +x scripts/vpn.sh   # só na primeira vez
./scripts/vpn.sh
```

Menu: `1` conecta, `2` desconecta, `3` testa. O teste deve mostrar `OK: handshake há Xs.`

## Regras

- Cada um usa **só o próprio arquivo**. Dois PCs com o mesmo `.conf` derrubam um ao outro, e isso conta como conta múltipla.
- Todo tráfego na VPN é registrado. Nada de scan ou brute force fora do que o reto pedir.
- `SEM HANDSHAKE` ou `FALHA` persistente: suporte no Discord oficial.

## Sem o script

```bash
sudo install -m600 team-71-player-X.conf /etc/wireguard/team71-player-X.conf
sudo wg-quick up team71-player-X     # conecta
sudo wg show                          # "latest handshake" recente = OK
sudo wg-quick down team71-player-X   # desconecta
```

O nome da cópia perde o primeiro `-` porque o Linux aceita no máximo 15 caracteres em nome de interface. O conteúdo é o mesmo e o servidor identifica você pela chave, não pelo nome do arquivo.
