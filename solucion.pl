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
%% Predicado auxiliar:
propiedadPerteneceABarrio(Barrio,Propiedad):-
    tienePropiedad(Persona,Propiedad),
    viveEn(Persona,Barrio).

barrioCopado(Barrio):-
    viveEn(_,Barrio),
    forall(propiedadPerteneceABarrio(Barrio,Propiedad),esCopada(Propiedad)).

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
    forall(propiedadPerteneceABarrio(Barrio,Propiedad),not(esBarata(Propiedad))).

esBarata(loft(FechaDeConstruccion)):-
    FechaDeConstruccion < 2005.

esBarata(casa(MetrosCuadrados)):-
    MetrosCuadrados < 90.

esBarata(departamento(1,_)).
esBarata(departamento(2,_)).

%% EJ 4)
%% valorDePropiedad(Persona,ValorInmueble).
valorDePropiedad(juan,150000).
valorDePropiedad(nico,80000).
valorDePropiedad(alf,75000).
valorDePropiedad(julian,140000).
valorDePropiedad(vale,95000).
valorDePropiedad(fer,60000).

puedoComprar(PropiedadesPosibles,Plata,PlataRestante):-
    findall(Persona,(valorDePropiedad(Persona,Valor),meAlcanza(Plata,Valor,Sobrante),Sobrante >= 0),Propiedades), %% Lista de nombres de las personas a las que le puedo comprar la casa
    sublista(Propiedades,PropiedadesPosibles), %% Hago la partición de todas las posibles combinaciones de listas
    flatten(PropiedadesPosibles, PropiedadesAComprar), %% aplano la lista para que me queden todas las posibles listas fuera de la lista de listas
    descontarEfectivo(Plata,PropiedadesAComprar,PlataRestante), %% Genero una lista de propiedades que va avanzando de propiedad si la plata me alcanza.
    PropiedadesAComprar \= [].

meAlcanza(Plata,Valor,PlataRestante):-
    PlataRestante is Plata - Valor.

descontarEfectivo(_,[],_).
descontarEfectivo(Plata,[PrimeraPropiedad|DemasPropiedades],PlataFinal):-
    valorDePropiedad(PrimeraPropiedad,Valor),
    meAlcanza(Plata,Valor,PlataRestante),
    descontarEfectivo(PlataRestante,DemasPropiedades,PlataFinal).

sublista([],[]).
sublista([_|Cola],Sublista):- sublista(Cola,Sublista).
sublista([Cabeza|Cola],[Cabeza|Sublista]):- sublista(Cola,Sublista).
