# Como consumir uma API REST
![Static Badge](https://img.shields.io/badge/Feito%20com%20ADVPL-363636?style=for-the-badge&logo=totvs) ![Static Badge](https://img.shields.io/badge/status-em_constru%C3%A7%C3%A3o-orange?style=for-the-badge&labelColor=%234A4A4A&color=%23F5A623)

---

**Índice**
1. [Includes](#includes)
2. [WSRestFul – Entendo a classe](#wsrestful--entendendo-a-classe)
    1. [Entendendo o cabeçalho](#entendendo-o-cabeçalho)
        1. [WSRestFul](#wsrestful)
        2. [Description](#description)
        3. [Format](#format)
    2. [Entendendo o conteúdo](#entendendo-o-conteúdo)
    3. [Entendendo os métodos](#entendendo-os-métodos)
        1. [GET](#get)
        2. [POST](#post)
        3. [PUT](#put)
        4. [DELETE](#delete)
3. [Construindo um Método GET](#construindo-um-método-get)
4. [Construindo um Método POST](#construindo-um-método-post)
5. [Construindo um Método PUT](#construindo-um-método-put)
6. [Construindo um Método DELETE](#construindo-um-método-delete)
---

## Includes
A primeira coisa a se levar em consideração em um código fonte em ADVPL são os [**includes**](# "arquivos *.ch que importam códigos de outros fontes pro fonte atual."). 
![Includes necessários para consumir a API](/imgs/includes.png)
Neste fonte específico fazemos uso dos includes `totvs.ch` e `restful.ch`. O primeiro traz consigo diversas funcionalidades padrão sendo indispensável a quase qualquer fonte ADVPL. Já o segundo, como o próprio nome sugere, é responsável por adicionar as funcionalidades voltadas para o consumo da API REST.

## WSRestFul – Entendendo a classe
![Estrutura básica de uma classe WSRestFul](/imgs/wsrestful.png)

### Entendendo o cabeçalho
#### WSRestFul
> 🏁  **Parâmetro Obrigatório** - Tipo: C (String)
>
> O nome de uma classe REST, deve ser iniciada por um caractere alfabético e deve conter apenas os caracteres alfabéticos compreendidos entre A e Z, os caracteres numéricos compreendidos entre 0 e 9, podendo também ser utilizado o caracter "_" (underline).
> 1. Um serviço não pode ter o nome de uma palavra reservada, da linguagem AdvPL, ou ter o nome igual a um tipo básico de informação.
> 2. O nome da classe REST é o mesmo utilizado na URI, desta forma, deve-se respeitar a estrutura de nomes permitidos na mesma.

Para construir uma classe que consumirá a API REST devemos iniciá-la declarando uma classe REST (server) por meio do comando **`WSRestFul`** e logo após passamos o nome do nosso serviço. Note que este é o nome que será chamado pelos métodos que construiremos adiante e não há necessidade de ser o mesmo nome dado ao fonte, no entanto, este nome também será exibido no painel de listagem de serviços REST da sua API e, portanto, é importante fazer com que ele seja facilmente identificável. O final do comando deve ser sinalizado através de um **`End WSRestFul`**.
#### Description
> 🏁  **Parâmetro Obrigatório** - Tipo: C (String)
>
> O segundo parâmetro que assinalimos no cabeçalho é a descrição do serviço que estamos criando e que também será exibido na no painel de listagem de serviços REST da sua API.

A descrição deve ser passada entre aspas (simples ou duplas, não há diferença).
#### Security
> Tipo: C (String)
>
> Informe o nome da rotina que tem relação com a API REST (exemplo CRMA980 ou MATA410), esse nome será utilizado para validação dos privilégios, permitindo assim o acesso ou não a API.

#### Format
> Tipo: C (String)
>
>Informe o formato de exportação do serviço. Esta informação é utilizada na listagem dos serviços REST.

Neste caso, normalmente utilizamos o formato APPLICATION_JSON, no entando há uma pequena [lista de formatos possíveis de utilizar](/utils/formats.txt).

#### SSL ONLY
>Tipo: -
>
>Indica que a classe só permitirá o acesso via conexão segura do tipo SSL (Secure Socket Layer).

### Entendendo o conteúdo
#### WSData
#### WSMethod

### Entendendo os métodos
#### GET
#### POST
#### PUT
#### DELETE

## Construindo um Método GET
## Construindo um Método POST
## Construindo um Método PUT
## Construindo um Método DELETE