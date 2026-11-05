#!/usr/bin/env bash
# VPN da competição (WireGuard). Uso: scripts/vpn.sh [arquivo.conf]
set -uo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
conf="${1:-}"
if [[ -z $conf ]]; then
  shopt -s nullglob
  confs=("$root"/team-*.conf)
  (( ${#confs[@]} == 1 )) || { echo "Coloque UM team-*.conf na raiz do repo ou passe o caminho: $0 arquivo.conf"; exit 1; }
  conf=${confs[0]}
fi
[[ -f $conf ]] || { echo "Arquivo não encontrado: $conf"; exit 1; }

# Linux limita nome de interface a 15 chars: team-71-player-a (16) -> team71-player-a
iface=$(basename "$conf" .conf)
iface=${iface/team-/team}
iface=${iface:0:15}

command -v wg-quick >/dev/null || {
  echo "WireGuard não instalado: sudo pacman -S wireguard-tools (Arch) | sudo apt install wireguard-tools (Debian/Ubuntu)"
  exit 1
}

is_up() { ip link show "$iface" &>/dev/null; }

connect() {
  is_up && { echo "Já conectado ($iface)."; return; }
  sudo install -m600 "$conf" "/etc/wireguard/$iface.conf" && sudo wg-quick up "$iface"
}

disconnect() {
  is_up || { echo "Não está conectado."; return; }
  sudo wg-quick down "$iface"
}

test_conn() {
  is_up || { echo "DESCONECTADO: interface $iface não existe."; return; }
  echo "IP: $(ip -4 -br a show "$iface" | awk '{print $3}')"
  sudo wg show "$iface" transfer | awk '{printf "Tráfego: %s B recebidos, %s B enviados\n", $2, $3}'
  local hs age
  hs=$(sudo wg show "$iface" latest-handshakes | awk 'NR==1 {print $2}')
  if [[ -z $hs || $hs == 0 ]]; then
    echo "SEM HANDSHAKE: aguarde ~30s e teste de novo. Persistindo, suporte no Discord."
    return
  fi
  age=$(( $(date +%s) - hs ))
  # WireGuard refaz o handshake a cada ~2 min com tráfego (keepalive 25s garante tráfego)
  if (( age < 180 )); then
    echo "OK: handshake há ${age}s."
  else
    echo "FALHA: último handshake há ${age}s, servidor não responde. Reconecte (2 e 1)."
  fi
}

while true; do
  printf '\nVPN %s\n 1) Conectar\n 2) Desconectar\n 3) Testar conexão\n 0) Sair\n> ' "$iface"
  read -r op || exit 0
  case $op in
    1) connect ;;
    2) disconnect ;;
    3) test_conn ;;
    0|q) exit 0 ;;
    *) echo "Opção inválida." ;;
  esac
done
