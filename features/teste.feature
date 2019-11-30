# language: pt
# encoding: UTF-8

Funcionalidade: Testar essa merda

Contexto: Dar puts em puts
    Dado que puts

Cenario: Somar 1 mais 3
Quando pegar 1
E somar com 3
Então tenho 4


Cenario: Somar 1 mais 2
Quando pegar 1
E somar com 2
Então tenho 3

Cenario: Pegar pagina principal google
Quando bater no endpoint "https://www.google.com"
Então devo estar no site da google

Cenario: Fazer login no netshoes
Quando preencher meu payload de login invalido
E executar login
Então Então devo receber uma resposta 401 erro