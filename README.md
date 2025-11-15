# MetaDocs

Uma ferramenta de **OSINT técnico** desenvolvida em **Bash**, capaz de localizar arquivos públicos associados a um domínio utilizando **Google Dorks via API do Google Custom Search**, realizar o download dos documentos encontrados e extrair seus metadados com **ExifTool**, organizando tudo automaticamente.

---

## ✨ Funcionalidades
- 🔎 Busca arquivos públicos usando `site:` + `filetype:`
- ☁️ Integração completa com Google Custom Search API
- 📥 Download automático dos arquivos encontrados
- 🧾 Extração de metadados com ExifTool
- 📂 Organização em diretórios estruturados com timestamp
- 🔁 Permite buscas consecutivas
- 🎨 Interface colorida e amigável no terminal

---

## 🛠️ Requisitos

### Dependências do sistema
- bash  
- curl  
- wget  
- exiftool  

Instalação (Debian/Ubuntu):

```bash
sudo apt install curl wget libimage-exiftool-perl

