%% PUNTO 1)
%% tienePropiedad(Persona,Propiedad).
tienePropiedad(juan,casa(120)).
tienePropiedad(nico,departamento(3,2)).
tienePropiedad(alf,departamento(3,1)).
tienePropiedad(julian,loft(2000)).
tienePropiedad(vale,departamento(4,1)).
tienePropiedad(fer,casa(110)).
%% En el futuro ver que hacer con Rocio, se quiere mudar pero NO tiene propiedad.

%% viveEn(Persona,Barrio).
viveEn(alf,almagro).
viveEn(juan,almagro).
viveEn(nico,almagro).
viveEn(julian,almagro).
viveEn(vale,flores).
viveEn(fer,flores).

%% PUNTO 2)
barrioCopado(Barrio):-
    viveEn(_,Barrio),
    forall((tienePropiedad(Persona,Propiedad),viveEn(Persona,Barrio)),esCopada(Propiedad)).

esCopada(casa(MetrosCuadrados)):-
    MetrosCuadrados > 100.

esCopada(departamento(Ambientes,_)):-
    Ambientes > 3.

esCopada(departamento(_,Banios)):-
    Banios > 1.

esCopada(loft(FechaDeConstruccion)):-
    FechaDeConstruccion > 2015.

%% PUNTO 3)
barrioCaro(Barrio):-
    viveEn(_,Barrio),
    forall((tienePropiedad(Persona,Propiedad),viveEn(Persona,Barrio)),not(esBarata(Propiedad))).

esBarata(loft(FechaDeConstruccion)):-
    FechaDeConstruccion < 2005.

esBarata(casa(MetrosCuadrados)):-
    MetrosCuadrados < 90.

esBarata(departamento(1,_)).
esBarata(departamento(2,_)).

%% EJ 4)
%% esto va a servir para verificar al final que la lista devuelta no es una lista vacia []
%% valorDePropiedad(Persona,ValorInmueble).
valorDePropiedad(juan,150000).
valorDePropiedad(nico,80000).
valorDePropiedad(alf,75000).
valorDePropiedad(julian,140000).
valorDePropiedad(vale,95000).
valorDePropiedad(fer,60000).

puedoComprar(PropiedadesPosibles,Plata,PlataRestante):-
    findall(Propiedad,(valorDePropiedad(Persona,Valor),descontarPlata(Plata,Valor,PlataRestante)),Propiedades),
    sublista(Propiedades,PropiedadesPosibles),
    PropiedadesPosibles \= [].

descontarPlata(Plata,Valor,PlataRestante):-
    PlataRestante is Plata - Valor,
    PlataRestante >= 0.

sublista([],[]).
sublista([_|Cola],Sublista):- sublista(Cola,Sublista).
sublista([Cola|Cabeza],[Cabeza,Sublista]):- sublista(Cola,Sublista).
