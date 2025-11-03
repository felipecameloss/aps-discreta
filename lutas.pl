% constantes: c = Charlies, a = Ankalaev
% Predicados (conforme seu enunciado)
% lutador(X). amador(X). luta_com(X,Y). treinador(X). plateia(X).
% vibra_por(P,X). ganha_de(X,Y). tem_treinador(X). tem_lutador(X). treina(X).

% ---- fatos básicos ----
lutador(c).
lutador(a).
% existência de um lutador amador com treinador (premissa existencial)
lutador(b).
amador(b).
tem_treinador(b).

% Ankalaev treina e Charlies ganhou de Ankalaev
treina(a).
ganha_de(c,a).

% exemplo de plateia (concretiza "plateia" para poder inferir vibra_por)
plateia(p1).
plateia(p2).

% exemplo de relação de luta (adversários)
luta_com(c,a).
luta_com(a,c).

% existe um treinador sem lutador (nem todo treinador tem um lutador)
treinador(t1).
% (não afirmamos tem_lutador(t1) para que t1 seja um treinador sem lutador)

% ---- regras (traduções das premissas universais/implicativas) ----

% 1) "Se Charlies ganhou de Ankalaev então toda plateia vibra por Charlies"
vibra_por(P, c) :-
    ganha_de(c, a),
    plateia(P).

% 2) "Todo lutador que não é Charlies já perdeu pra ele"
%    (interpretação: para qualquer X lutador distinto de c, Charlies ganhou de X)
ganha_de(c, X) :-
    lutador(X),
    X \= c.

% 3) "Para todo lutador, se a plateia vibra, ele ganhou de seu adversário."
%    (uso praticável: se existe pelo menos um membro da plateia que vibra por X
%     e X lutou com Y, então X ganhou de Y)
plateia_vibra_por_alguem(X) :-
    plateia(P),
    vibra_por(P, X).

ganhou_de_se_plateia_vibra(X, Y) :-
    lutador(X),
    plateia_vibra_por_alguem(X),
    luta_com(X, Y),
    ganha_de(X, Y).

% 4) "Para todo lutador que ganha, a plateia vibra." (regra geral)
vibra_por(P, X) :-
    lutador(X),
    ganha_de(X, _SomeOne),
    plateia(P).

% 5) "Todo lutador tem um treinador"
tem_treinador_de_lutador(X) :-
    lutador(X),
    tem_treinador(X).

% 6) "Todo lutador já perdeu para outro lutador"
perdeu_para(Quem, X) :-
    lutador(X),
    lutador(Quem),
    Quem \= X,
    ganha_de(Quem, X).

% 7) Restrição: "Nenhum amador ganha de um profissional."
%    Implementada como cláusula proibitiva: se essa situação for querida, ela contradiz a KB.
:- amador(X), \+ amador(Y), ganha_de(X, Y).
