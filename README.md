# Como consumir uma API REST com ADVPL

[![forthebadge](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMzkuMzk5OTk3NzExMTgxNjQiIGhlaWdodD0iMzUiIHZpZXdCb3g9IjAgMCAyMzkuMzk5OTk3NzExMTgxNjQgMzUiPjxyZWN0IHdpZHRoPSI3NC45NTAwMDA3NjI5Mzk0NSIgaGVpZ2h0PSIzNSIgZmlsbD0iIzRhNGE0YSIvPjxyZWN0IHg9Ijc0Ljk1MDAwMDc2MjkzOTQ1IiB3aWR0aD0iMTY0LjQ0OTk5Njk0ODI0MjIiIGhlaWdodD0iMzUiIGZpbGw9IiNmNWE2MjMiLz48dGV4dCB4PSIzNy40NzUwMDAzODE0Njk3MyIgeT0iMjEuNSIgZm9udC1zaXplPSIxMiIgZm9udC1mYW1pbHk9IidSb2JvdG8nLCBzYW5zLXNlcmlmIiBmaWxsPSIjRkZGRkZGIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBsZXR0ZXItc3BhY2luZz0iMiI+U1RBVFVTPC90ZXh0Pjx0ZXh0IHg9IjE1Ny4xNzQ5OTkyMzcwNjA1NSIgeT0iMjEuNSIgZm9udC1zaXplPSIxMiIgZm9udC1mYW1pbHk9IidNb250c2VycmF0Jywgc2Fucy1zZXJpZiIgZmlsbD0iI0ZGRkZGRiIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZm9udC13ZWlnaHQ9IjkwMCIgbGV0dGVyLXNwYWNpbmc9IjIiPkVNIENPTlNUUlXDh8ODTzwvdGV4dD48L3N2Zz4=)](https://forthebadge.com)

**Índice**
1. [Includes](#includes)
2. [WSRestFul – Entendo a classe]()


## Includes
A primeira coisa a se levar em consideração em um código fonte em ADVPL são os [**includes**](# "arquivos *.ch que importam códigos de outros fontes pro fonte atual."). 
![Includes necessários para consumir a API](/imgs/includes.png)
Neste fonte específico fazemos uso dos includes `totvs.ch` e `restful.ch`. O primeiro traz consigo diversas funcionalidades padrão sendo indispensável a quase qualquer fonte ADVPL. Já o segundo, como o próprio nome sugere, é responsável por adicionar as funcionalidades voltadas para o consumo da API REST.

## WSRestFul – Entendendo a classe
![Includes necessários para consumir a API](/imgs/wsrestful.png)
