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


