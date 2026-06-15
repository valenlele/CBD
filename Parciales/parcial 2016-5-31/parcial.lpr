program parcial;

const
  FIN = -1;

type
  prod = record
    cod: integer;
    nom: string[15];
    desc: string[40];
    stock: integer;
  end;

  bin = file of prod;

procedure textoABinario(var archBin:bin; var archTxt:text);
var
  reg: prod;
begin
  reg.cod := -1;
  write(archBin, reg);

  while (not eof(archTxt)) do begin
    readln(archTxt, reg.cod);
    readln(archTxt, reg.nom);
    readln(archTxt, reg.desc);
    readln(archTxt, reg.stock);
    write(archBin, reg);
  end;
end;

procedure bajaLogica(var archBin: bin; codBuscar: integer);
var
  encontre: boolean;
  reg, sLibre: prod;
  nLibre: integer;
begin
  seek(archBin, 0); // posicionarse en el primer registro en cada iteracion
  encontre := false;
  read(archBin, sLibre);

  while ((not eof(archBin)) and (not encontre)) do begin
    read(archBin, reg);
    if (reg.cod = codBuscar) then encontre := true;
  end;

  if (encontre) then begin
    nLibre := filepos(archBin) - 1;
    seek(archBin, nLibre);
    reg.stock := -1;
    reg.cod := sLibre.cod;
    write(archBin, reg);

    sLibre.cod := nLibre;
    seek(archBin, 0);
    write(archBin, sLibre);
  end;
end;

var
  archTxt: text;
  archBin: bin;
  cod: integer;

begin
  assign(archTxt, 'productos.txt');
  reset(archTxt);
  assign(archBin, 'productos.bin');
  rewrite(archBin);

  textoABinario(archBin, archTxt);

  writeln('Se ingresan codigos de productos a eliminar');
  write('Codigo: ');
  readln(cod);
  while (cod <> FIN) do begin
    bajaLogica(archBin, cod);
    write('Codigo: ');
    readln(cod);
  end;

  close(archTxt);
  close(archBin);
end.

