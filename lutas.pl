% Código para colar no SWISH - ufc_mundo

% --- fatos / constantes ---
lutador(charlies).
lutador(ankalaev).

plateia(p1).
plateia(p2).

treinador(ze).
treinador_de(ankalaev, ze).

amador(ankalaev).

luta(charlies, ankalaev).
luta(ankalaev, charlies).

% fato conhecido
ganha(charlies, ankalaev).

% --- regras (todas agrupadas) ---
% se alguém ganhou, todos os membros da plateia vibram por esse vencedor
vibra(P, X) :-
    plateia(P),
    ganha(X, _).

% todo lutador que não é charlies já perdeu para ele
perdeu_para(X, charlies) :-
    lutador(X),
    X \= charlies,
    ganha(charlies, X).

% todo lutador já perdeu para outro lutador
ja_perdeu_para(X, Y) :-
    lutador(X),
    lutador(Y),
    ganha(Y, X),
    X \= Y.

% verificação: nenhum amador ganha de um profissional
violacao_amador_prof(X, Y) :-
    amador(X),
    lutador(Y),
    \+ amador(Y),
    ganha(X, Y).

% todo lutador tem treinador (existência modelada)
tem_treinador(X) :-
    lutador(X),
    treinador_de(X, _).
