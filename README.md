#MetaDocS

Uma ferramenta de OSINT técnico desenvolvida em Bash, capaz de localizar arquivos públicos associados a um domínio utilizando Google Dorks via API do Google Custom Search, realizar o download automático dos documentos encontrados e extrair seus metadados com ExifTool, organizando tudo em diretórios estruturados.

✨ Funcionalidades

🔎 Busca arquivos públicos de um domínio usando:

site:dominio.com

filetype:extensão

☁️ Integração com Google Custom Search API

📥 Download automático dos arquivos encontrados

🧾 Extração de metadados usando ExifTool

📂 Organização automática em pastas com timestamp

🔁 Suporte a buscas sequenciais

🎨 Interface simples, colorida e amigável no terminal

🛠️ Requisitos

Para usar a ferramenta, você precisa ter:

Dependências obrigatórias

bash

curl

wget

exiftool

Instalar no Linux (Debian/Ubuntu):

sudo apt install curl wget libimage-exiftool-perl

🌐 Requisitos do Google API

A ferramenta precisa da API do Google Custom Search:

1. Criar API Key

Acesse:
https://support.google.com/googleapi/answer/6158862

2. Criar mecanismo de busca (CX)

Acesse:
https://support.google.com/programmable-search/answer/12499034

⚠️ Importante:
No mecanismo de busca, habilite para pesquisar em toda a web.

Ao rodar o script pela primeira vez, ele irá pedir:

API KEY

CX (ID do mecanismo de busca)

E salvará tudo automaticamente no arquivo config.cfg.

🚀 Como usar
1. Dê permissão para executar:
chmod +x nome_do_script.sh

2. Execute:
./nome_do_script.sh

3. Informe:

O domínio-alvo (ex: exemplo.com)

A extensão desejada (ex: pdf, docx, ppt, etc.)

4. O script irá:

Realizar a busca via Google API

Baixar os arquivos encontrados

Salvar em:

arquivos/docs/<domínio>_<extensão>_<data>/


Extrair metadados para:

arquivos/Metadados/

📂 Estrutura gerada
arquivos/
 ├── docs/
 │    └── dominio_ext_data/
 │         ├── arquivo1.pdf
 │         ├── arquivo2.pdf
 │         └── ...
 └── Metadados/
      ├── arquivo1.pdf.txt
      ├── arquivo2.pdf.txt
      └── ...

🔧 Extensões suportadas

pdf

doc / docx

ppt / pptx

xls / xlsx

txt

rtf

🕵️ Categoria OSINT

Essa ferramenta se enquadra em:

✔️ Technical OSINT

Busca arquivos expostos publicamente e extrai seus metadados, possibilitando identificar:

autores

softwares utilizados

caminhos internos da máquina

datas e versões

informações sensíveis incluídas acidentalmente

⚠️ Aviso Legal

Esta ferramenta deve ser usada apenas para fins educacionais, auditoria autorizada e pesquisa em OSINT.
Você é responsável pelo uso seguro e legal.
