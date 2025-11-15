#!/usr/bin/env bash

clear

# Caminho absoluto do diretório do script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

CONFIG_FILE="${SCRIPT_DIR}/config.cfg"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo -e "\e[35m════════════════════════════════════════════════════════════════\e[0m"
    echo -e "\e[91m[!]Arquivo config.cfg não encontrado.\e[0m"
    echo -e "\e[32m[*] Vamos criá-lo agora!\e[0m"
    echo -e "\e[35m════════════════════════════════════════════════════════════════\e[0m"
    echo ""
    echo -e "\e[34mLink para chave API do Google Custom Search:\e[0m \e[32msupport.google.com/googleapi/answer/6158862?hl=en\e[0m"
    echo "" 
    echo -e "\e[34mDigite sua chave API do Google Custom Search:\e[0m"
    read -p "> " GOOGLE_API_KEY
    echo -e "\e[35m════════════════════════════════════════════════════════════════\e[0m"
    echo -e "\e[34mLink para ID de mecanismo de busca:\e[0m \e[32msupport.google.com/programmable-search/answer/12499034?hl=en\e[0m"
    echo ""
    echo -e "\e[34mDigite seu CX (ID de mecanismo de busca): \e[0m"
    read -p "> " GOOGLE_CX
    echo -e "\e[35m════════════════════════════════════════════════════════════════\e[0m"

    echo "GOOGLE_API_KEY=\"$GOOGLE_API_KEY\"" > "$CONFIG_FILE"
    echo "GOOGLE_CX=\"$GOOGLE_CX\"" >> "$CONFIG_FILE" 

    echo -e "\e[32m[*] Arquivo config.cfg criado com sucesso!\e[0m"
fi


while true; do

clear

echo ""
echo -e "\e[35m══════════════════════════════════════════════════════════════════════════════════════\e[0m"
echo ""

printf "\033[91m"

cat << 'EOF'
 /$$      /$$             /$$               /$$$$$$$                       /$$$$$$
| $$$    /$$$            | $$              | $$__  $$                     /$$__  $$
| $$$$  /$$$$  /$$$$$$  /$$$$$$    /$$$$$$ | $$  \ $$  /$$$$$$   /$$$$$$$| $$  \__/
| $$ $$/$$ $$ /$$__  $$|_  $$_/   |____  $$| $$  | $$ /$$__  $$ /$$_____/|  $$$$$$ 
| $$  $$$| $$| $$$$$$$$  | $$      /$$$$$$$| $$  | $$| $$  \ $$| $$       \____  $$
| $$\  $ | $$| $$_____/  | $$ /$$ /$$__  $$| $$  | $$| $$  | $$| $$       /$$  \ $$
| $$ \/  | $$|  $$$$$$$  |  $$$$/|  $$$$$$$| $$$$$$$/|  $$$$$$/|  $$$$$$$|  $$$$$$/
|__/     |__/ \_______/   \___/   \_______/|_______/  \______/  \_______/ \______/ 
EOF

printf "\033[0m"

source "$CONFIG_FILE" 2>/dev/null

echo -e "\e[35m══════════════════════════════════════════════════════════════════════════════════════\e[0m"
echo -e "                 \e[32mSuporte de extensões da ferramenta\e[0m"
echo -e "\e[35m══════════════════════════════════════════════════════════════════════════════════════\e[0m"

echo -e "\e[34m▶\e[0m  \e[33mpdf\e[0m      \e[90m(PDF)\e[0m"
echo -e "\e[34m▶\e[0m  \e[33mdoc\e[0m      \e[90m(Word antigo)\e[0m"
echo -e "\e[34m▶\e[0m  \e[33mdocx\e[0m     \e[90m(Word moderno)\e[0m"
echo -e "\e[34m▶\e[0m  \e[33mppt\e[0m      \e[90m(PowerPoint)\e[0m"
echo -e "\e[34m▶\e[0m  \e[33mpptx\e[0m     \e[90m(PowerPoint moderno)\e[0m"
echo -e "\e[34m▶\e[0m  \e[33mxls\e[0m      \e[90m(Excel antigo)\e[0m"
echo -e "\e[34m▶\e[0m  \e[33mxlsx\e[0m     \e[90m(Excel moderno)\e[0m"
echo -e "\e[34m▶\e[0m  \e[33mtxt\e[0m      \e[90m(Texto simples)\e[0m"
echo -e "\e[34m▶\e[0m  \e[33mrtf\e[0m      \e[90m(Rich Text Format)\e[0m"

echo -e "\e[35m══════════════════════════════════════════════════════════════════════════════════════\e[0m"
echo ""
printf "\e[32m[*] Insira o endereço do alvo (exemplo.com): \e[0m"
read ALVO
echo ""
echo -e "\e[35m══════════════════════════════════════════════════════════════════════════════════════\e[0m"
echo ""
printf "\e[32m[*] Insira a extensão desejada(EX:pdf): \e[0m"
read TIPO
echo ""

QUERY="site:${ALVO} filetype:${TIPO}"
NUM=10
BASE_URL="https://www.googleapis.com/customsearch/v1"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BASE_DIR="${SCRIPT_DIR}/arquivos/docs/${ALVO}_${TIPO}_${TIMESTAMP}"

mkdir -p "$BASE_DIR"
mkdir -p "$BASE_DIR/Metadados"

cd "$BASE_DIR" || exit 1


links=()

resp=$(curl -sG --max-time 15 "$BASE_URL" \
    --data-urlencode "key=${GOOGLE_API_KEY}" \
    --data-urlencode "cx=${GOOGLE_CX}" \
    --data-urlencode "q=${QUERY}" \
    --data-urlencode "num=${NUM}" \
    --data-urlencode "start=1")

if grep -q '"error"' <<< "$resp"; then
    echo -e "\e[91m[!] Erro detectado na API. Possivelmente limite de requisições atingido.\e[0m"
    echo -e "\e[91m[!] Ou chave API/CX incorreta, Altere no arquivo config.cfg.\e[0m"
    exit 1
fi

total=$(echo "$resp" | grep -oP '"totalResults":\s*"\K[0-9]+' | tr -d '\n\r')
if [[ -z "$total" || "$total" == "0" ]]; then
    echo -e "\e[35m══════════════════════════════════════════════════════════════════════════════════════\e[0m"
    echo -e "\e[91m[!]Nenhum resultado encontrado.\e[0m"
fi

max_pages=$(( (total + NUM - 1) / NUM ))
if (( max_pages > 10 )); then max_pages=10; fi

echo -e "\e[35m══════════════════════════════════════════════════════════════════════════════════════\e[0m"
echo ""
echo -e  "\e[32m[*] Encontrados ~$total resultados. Buscando até $max_pages páginas...\e[0m"
echo ""


for ((page=0; page<max_pages; page++)); do
    start=$((1 + page*NUM))
    resp=$(curl -sG --max-time 15 "$BASE_URL" \
        --data-urlencode "key=${GOOGLE_API_KEY}" \
        --data-urlencode "cx=${GOOGLE_CX}" \
        --data-urlencode "q=${QUERY}" \
        --data-urlencode "num=${NUM}" \
        --data-urlencode "start=${start}")

    if grep -q '"error"' <<< "$resp"; then
        echo -e "\e[91m[!] Erro detectado na API. Possivelmente limite de requisições atingido.\e[0m"
        echo -e "\e[91m[!] Ou chave API/CX incorreta, Altere no arquivo config.cfg.\e[0m"
        exit 1
    fi

    while IFS= read -r l; do
        links+=("$l")
    done < <(echo "$resp" | grep -oP '"link":\s*"\K[^"]+')
done

echo -e "\e[35m══════════════════════════════════════════════════════════════════════════════════════\e[0m"
echo ""
echo -e "\e[32m[*] Total de arquivos encontrados: ${#links[@]}\e[0m"
echo ""
echo -e "\e[35m══════════════════════════════════════════════════════════════════════════════════════\e[0m"
echo ""

for url in "${links[@]}"; do
    echo -e "\e[32m[*] Baixando... :\e[0m $url"
    wget -q --content-disposition --trust-server-names \
     --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64)" \
     "$url" || echo -e "\e[91m[!]falha ao baixar:\e[0m $url"
done
echo ""
echo -e "\e[35m══════════════════════════════════════════════════════════════════════════════════════\e[0m"

# Agora o diretório é ABSOLUTO e consistente
METADIR="${SCRIPT_DIR}/arquivos/Metadados"
mkdir -p "$METADIR"

echo -e "\e[32m[*] Extraindo informações de ${#links[@]}  arquivos...\e[0m"
echo -e "\e[35m══════════════════════════════════════════════════════════════════════════════════════\e[0m"
echo ""
echo ""

for file in *.${TIPO}; do
    [[ -f "$file" ]] || continue
    echo -e "\e[34m══════════════════════════════════════════\e[0m\e[32m$file\e[0m\e[34m══════════════════════════════════════════\e[0m"
    
    exiftool "$file" > "${METADIR}/${file}.txt"
    cat "${METADIR}/${file}.txt"

    echo
done

echo -e "\e[35m══════════════════════════════════════════════════════════════════════════════════════\e[0m"
echo -e "\e[32m[+]Salvando os metadados no diretório /docs/Metadados/... \e[0m"
echo -e "\e[35m══════════════════════════════════════════════════════════════════════════════════════\e[0m"


echo ""
echo -e "\e[32mDeseja buscar novamente? (s/n)\e[0m"
read resposta
echo ""

# Sempre volta ao diretório do script — agora corretamente
cd "$SCRIPT_DIR"

if [[ "$resposta" =~ ^[Nn]$ ]]; then
    echo -e "\e[91m[*] Encerrando ferramenta...\e[0m"
    break
fi

clear
done
