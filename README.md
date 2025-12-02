Desafio Final – Desenvolvimento Mobile (Flutter + Backend)
Aluno responsável: Felipe Cley

Este projeto foi desenvolvido como parte do desafio final da disciplina e consiste em duas aplicações separadas: um app mobile desenvolvido em Flutter e um backend que fornece uma API REST. O objetivo do trabalho é realizar o CRUD completo de Clientes e Produtos, com comunicação entre o backend e o aplicativo Flutter.

A estrutura do repositório é organizada em duas pastas principais:
- backend_flutter: onde está todo o código da API REST.
- desafio_flutter_: onde está o aplicativo Flutter.

Para executar o backend:
1. Abra o terminal na pasta backend_flutter.
2. Execute o comando: npm install (ou equivalente conforme seu backend).
3. Para rodar o servidor, use: npm start (ou o comando correspondente).
O servidor geralmente roda em http://localhost:3000.

Endpoints do backend:
Clientes:
GET /clientes
POST /clientes
PUT /clientes/:id
DELETE /clientes/:id

Produtos:
GET /produtos
POST /produtos
PUT /produtos/:id
DELETE /produtos/:id

Para executar o aplicativo Flutter:
1. Abra o terminal na pasta desafio_flutter_.
2. Execute: flutter pub get.
3. Rode o aplicativo com: flutter run.

Configuração da URL do backend no Flutter:
Se estiver usando emulador Android, a URL deve ser:
http://10.0.2.2:3000

Se estiver usando um dispositivo físico, deve usar o IP local da máquina:
Exemplo: http://SEU-IP-LOCAL:3000
Para descobrir seu IP, use o comando ipconfig (Windows) ou ifconfig (Linux/Mac).

Caso existam scripts SQL do banco de dados, eles podem estar dentro da pasta backend_flutter, geralmente na pasta "database". Esses scripts podem ser usados para criar ou popular o banco de dados do backend.

Vídeo de demonstração: https://unilavrasedu-my.sharepoint.com/:v:/g/personal/fcley69_sou_unilavras_edu_br/IQAlY2n2ZTjWQ4yQLUBSUwE_AcA1KyJsIlPq8nJzFV2PX2c?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=f2nEry


Checklist da entrega:
- Backend funcional
- Frontend funcional
- CRUD de clientes funcionando
- CRUD de produtos funcionando
- Comunicação entre app e backend funcionando
- Repositório no GitHub organizado e finalizado
- README preenchido (este arquivo)
- Vídeo com até 3 minutos concluído

Autor do projeto:
Felipe Cley
