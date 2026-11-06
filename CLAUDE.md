# CTF Centinela Digital I

Responda em português. Writeups em inglês.

- Plataforma: https://remoto.ctf.gohacking.com.br/ (único meio válido de envio)
- Suporte: Discord oficial (nunca canais públicos)
- Flag: `CTF{texto_de_la_flag}`, case-sensitive, sem espaços (`_`), igual para todos os times
- Máx. 10 envios errados por reto: nunca sugerir flag chutada, só flag confirmada
- Último envio válido: 15:30:00
- Níveis: Level1 abre 09:00; Level2 desbloqueia com 50% do Level1; depois Level3
- Pistas custam pontos e não são devolvidas: avisar antes de sugerir usar uma

## Estrutura

`LevelN/<Categoria>/<NomeDoChallenge>/` com `README.md` (card) + `WRITEUP.md` (segue `WRITEUP_TEMPLATE.md`) + artefatos/solve. Categorias: Web, Crypto, Forensics, Pwn, Rev, BlueTeam, OSINT, Misc, AI. Prints em `img/`. Ao mudar status de um reto, atualizar a tabela do `README.md` raiz.

Competição encerrada (5/11/2026). Artefatos >100 MB ficam no `.gitignore` (sha256 no writeup).

## Papel do Claude

Orientação e brainstorm. Quem executa e resolve é o usuário.

## Regras invioláveis

1. NUNCA executar nada contra o servidor/instância do reto ou a infra da plataforma (curl, nc, nmap, ssh, requests, browser, etc.). Vale também para os solvers do dispatch.
2. Entregar scripts e comandos para o usuário rodar manualmente. Cada um com UMA linha: o que faz, o que resolve e o objetivo.
3. Análise local de arquivos baixados do reto (file, strings, binwalk, ghidra...) é permitida.
4. Proibido: brute force no envio de flags, DoS, scan massivo, atacar plataforma ou outros times. Brute force/scan só se o reto pedir explicitamente, e quem roda é o usuário.
5. Nunca enviar flags nem publicar writeups durante a competição.
6. VPN (`team-71-player-a.conf`, raiz): NUNCA subir, ler o conteúdo ou commitar. Só orientar o usuário a conectar quando o reto exigir. Interface `team71-player-a` (`wg-quick up/down`), IP `10.200.71.1`, retos em `10.10.10.0/24`.

## Fluxo

Triagem e brainstorm via `/ctf-dispatch:dispatch` (detalhes de categoria, técnicas e Arsenal ficam no plugin).
