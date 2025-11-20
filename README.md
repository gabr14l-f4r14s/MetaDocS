# MetaDocS

Ferramenta de **OSINT automatizada em Bash** que utiliza a **API do Google Custom Search** para localizar arquivos públicos expostos na web por domínio usando *Google Dorks*.  
Após encontrar os arquivos, a ferramenta **baixa automaticamente** e extrai **metadados** usando **ExifTool**, salvando tudo de forma organizada.

---

## 📌 Funcionalidades

- 🔎 Busca arquivos públicos usando operadores `site:` e `filetype:`
- 🌐 Usa API oficial do **Google Custom Search**
- 📥 Faz download automático dos arquivos encontrados
- 🧩 Extrai metadados com **ExifTool**
- 📁 Organiza tudo em diretórios dedicados
- 🛠️ Totalmente automatizada em Bash
- 🔐 Ideal para OSINT técnico e reconhecimento inicial em pentests

---

## 📂 Estrutura de Diretórios

```
/Resultados/
    /Downloads/       → Arquivos baixados
    /Metadados/       → Metadados extraídos pelo ExifTool
```

---

## 📦 Requisitos

### **1. Bash**
Ferramenta desenvolvida especificamente para ambientes Linux.

### **2. ExifTool**
Necessário para extrair metadados.

Instalação:
```bash
sudo apt install exiftool
```

### **3. wget**
Usado para baixar os arquivos encontrados.
```bash
sudo apt install wget
```

### **4. API do Google Custom Search**
Você precisa de:

- **API Key**
- **Search Engine ID (CX)** configurado para permitir buscas na web

#### 🔗 Como conseguir a API Key:
1. Acesse o Google Cloud Console  
2. Crie um projeto  
3. Ative o serviço **Custom Search API**  
4. Vá em **APIs & Services → Credentials**  
5. Gere uma **API Key**

#### 🔗 Como conseguir o Search Engine ID (CX):
1. Acesse o site do **Programmable Search Engine** do Google  
2. Crie um mecanismo de pesquisa  
3. Ative a busca na web (“Search Entire Web”)  
4. Copie o **ID do mecanismo (CX)**

---

## ⚙️ Configuração

Crie um arquivo chamado **config.cfg** no mesmo diretório da ferramenta:

```ini
API_KEY="SUA_API_KEY_AQUI"
CX="SEU_SEARCH_ENGINE_ID_AQUI"
```

---

## ▶️ Como Usar

### **Modo básico**
```bash
chmod +x MetaDoc.sh
```
```bash
./MetaDoc.sh site.com pdf
```

Onde:
- `site.com` → domínio alvo  
- `pdf` → extensão desejada  

A ferramenta automaticamente aplicará:
```
site:site.com filetype:pdf
```

### **Saída esperada**
- Todos os PDFs públicos encontrados serão baixados em:  
  `/Resultados/Downloads/`
- Os metadados extraídos ficarão em:  
  `/Resultados/Metadados/arquivo.txt`

---

## 💡 Exemplo de Uso

```bash
./MetaDoc.sh governo.br docx
```

A ferramenta irá:
1. Buscar `site:governo.br filetype:docx`
2. Baixar todos os DOCX encontrados
3. Extrair metadados com ExifTool
4. Salvar tudo automaticamente

---

## ❗ Observação Importante

Esta ferramenta é destinada **somente para fins educacionais e atividades legais de OSINT e segurança ofensiva**.  
Use apenas em domínios autorizados.

---

