# Como consumir uma API REST
```
     ___      .______    __     .______       _______     _______.___________.
    /   \     |   _  \  |  |    |   _  \     |   ____|   /       |           |
   /  ^  \    |  |_)  | |  |    |  |_)  |    |  |__     |   (----`---|  |----`
  /  /_\  \   |   ___/  |  |    |      /     |   __|     \   \       |  |     
 /  _____  \  |  |      |  |    |  |\  \----.|  |____.----)   |      |  |     
/__/     \__\ | _|      |__|    | _| `._____||_______|_______/       |__|     
```

![Static Badge](https://img.shields.io/badge/Feito%20com%20ADVPL-363636?style=for-the-badge&logo=totvs) ![Static Badge](https://img.shields.io/badge/status-em_constru%C3%A7%C3%A3o-orange?style=for-the-badge&labelColor=%234A4A4A&color=%23F5A623)

---

**Índice**
1. [Introdução, Links e Referências](#)
2. [Includes](#includes)
2. [WsRestFul – Entendo a classe](#wsrestful--entendendo-a-classe)
    1. [Entendendo o cabeçalho](#entendendo-o-cabeçalho)
        1. [Sintaxe](#sintaxe)
        2. [WsRestFul](#wsrestful)
        3. [Description](#description)
        4. [Format](#format)
    2. [Entendendo o conteúdo](#entendendo-o-conteúdo)
        1. [WsData](#wsdata)
        2. [WsMethod](#wsmethod)
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
## Introdução, Links e Referências
💾 **INFORMAÇÕES PARA MELHOR APROVEITAR ESTE REPOSITÓRIO**
Este repositório foi criado com o propósito de servir como base para meus estudos em ADVPL/ADVPL MVC/TLPP. O processo de documentar o aprendizado (*public learning*) me ajuda a fixar conceitos importantes e ainda me garante acesso a materiais apropriados para meu trabalho no dia-a-dia. Sinta-se livre para explorá-lo e espero que lhe seja útil!
- Nos exemplos de sintaxe, os itens que aparecem entre colchetes são items opcionais. (i.e. `WsData [AS Integer]`)

🔗 **LINKS ÚTEIS**
1. [Documentação Oficial de REST - TOTVS TDN](https://tdn.totvs.com/display/public/framework/03.+Comandos+REST)

## Includes
A primeira coisa a se levar em consideração em um código fonte em ADVPL são os [**includes**](# "arquivos *.ch que importam códigos de outros fontes pro fonte atual."). 
![Includes necessários para consumir a API](/imgs/includes.png)
Neste fonte específico fazemos uso dos includes `totvs.ch` e `restful.ch`. O primeiro traz consigo diversas funcionalidades padrão sendo indispensável a quase qualquer fonte ADVPL. Já o segundo, como o próprio nome sugere, é responsável por adicionar as funcionalidades voltadas para o consumo da API REST.

## WsRestFul – Entendendo a classe
![Estrutura básica de uma classe WSRestFul](/imgs/wsrestful.png)

### Entendendo o cabeçalho
#### Sintaxe
```
WSRESTFUL <cServiceName> DESCRIPTION <cDescription> [SECURITY <cSecurity>] [FORMAT <cFormat>] [SSL ONLY]
```
#### WsRestFul
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
##### Sintaxe
```
WSDATA <cVarName> [AS <cVarType>] [OPTIONAL]
```
##### cVarName 
> 🏁  **Parâmetro Obrigatório** - Tipo: C (String)
>
>Indica o nome da propriedade da classe REST

O nome informado será utilizado para manipular o conteúdo da variável nos métodos que faremos.
##### cVarType
> Tipo: C (String)
>
>Indica o tipo do dado utilizado (STRING, DATE, INTEGER, FLOAT, BOOLEAN, BASE64Binary)
##### OPTIONAL
>Indica que não é um parâmetro obrigatório.

Quando passamos a flag `OPTIONAL` indicamos que aquele parâmetro pode ou não ser enviado na requisição que faremos.

> ⚠️ **ATENÇÃO!**
>
> Caso um parâmetro WsData seja declarado, mas não tenha nenhum Método recebendo (através de um WsReceive), isso desencadeará um erro na hora de fazer a requisição. 

#### WSMethod
#### Sintaxe
```
WSMETHOD <cVerb> [cId] DESCRIPTION <cDescription> [WSSYNTAX <cSintax>] [PATH <cPath>] [TTALK <cTTalkVersion>]
```
##### WsMethod
> 🏁  **Parâmetro Obrigatório** - Tipo: -
>
> Indica o tipo de método que vamos declarar: **PUT**, **POST**, **GET** ou **DELETE**.

Caso deseje usar o mesmo método com características diferentes (i.e. um método GET para puxar todos os registros e outro para selecionar um registro por Id) é preciso declarar um Id. Veremos isso nos exemplos do método GET.
##### Description
> 🏁  **Parâmetro Obrigatório** - Tipo: C (String)
>
> Declara a descrição do método REST.
##### WsSyntax
> Tipo: C (String)
>
> Sintaxe HTTP da chamada REST. Esta informação é utilizada apenas para documentação do REST.

Basicamente é o mesmo endereço declarado no parâmetro `Path`.
##### Path
> Tipo: C (String)
>
> Definição do endpoint que irá acionar aquele método.

Não é considerado um parâmetro obrigatório, mas vai passar como endpoint padrão o endereço ``'/'``;
##### TTalk
> Tipo: C (String)
>
>Valor "v1" para sinalizar que o método utiliza o padrão de mensagem de erro do TTALK.	

### Entendendo a declaração dos métodos
#### WsMethod
> Declara o método a ser utilizado. Caso deseje criar mais de uma chamada para um mesmo método é necessário passar um Id para cada rota.

Por exemplo:
```
WsMethod GET ALL Description "Chama todos os registros" WsSyntax '/' Path '/'
WsMethod GET UNIQUE Description "Chama um registro específico" WsSyntax '/{id}' Path '/{id}'
```
Neste caso, o primeiro `WsMethod GET` possui o Id `ALL` e é responsável por chamar todos os registros de uma tabela. Já o segundo método `GET` possui o Id `UNIQUE` e será responsável por chamar apenas um registro do banco de dados.
#### WsSyntax
Ver [WsSyntax](#wssyntax).	
#### WsReceive (QueryParms/PathParms/HeaderParms)
Indica os parâmetros que iremos receber (geralmente declarado como `WsData`) e que podem ser `QueryParms`, `Pathparms` ou `HeaderParms`. Caso deseje, pode trocar o WsReceive por um desses métodos, mas o WsReceive é mais abrangente e permite receber parâmetros diversos enquanto o QueryParms, PathParms e HeaderParms são específicos - sendo mais utilizados para facilitar a leitura do código.
#### WsRestful (WsService/WsRest)
Indica o nome da classe, do serviço, que o método atual pertence. O serviço foi declarado em [WsRestful](#wsrestful). O método pode ser declarado como `WsSerice` ou `WsRest` também.

---
## Construindo um Método GET
![Exemplo 1 de declaração de um método GET](/imgs/method_GET.png)
## Construindo um Método POST
## Construindo um Método PUT
## Construindo um Método DELETE