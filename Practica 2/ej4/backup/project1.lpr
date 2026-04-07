program ej4p2;

const
  CANT_DETALLES = 20;

type
  pelicula = record
    cod:integer;
    nom:string[30];
    genero:string[15];
    director:string[30];
    duracion:integer;
    fecha:string[10];
    asistencia:integer;
  end;

  fPelicula = file of pelicula;

  arregloDetalles = array [1..CANT_DETALLES] of fPelicula;

procedure merge(var d: arregloDetalles; ruta:string);
begin

end;

var
  d: arregloDetalles;

begin
  merge(d, 'maestroSemanal.dat');
end.

