program ej3p3;

type
  indumentaria = record
    cod: integer;
    nom: string[20];
    desc: string[40];
    stock: integer;
  end;

  bin = file of indumentaria;

procedure textoABinario(var archTxt: Text);
var
  archBin: bin;
  reg: indumentaria;
begin
  assign(archTxt, 'indumentaria.txt');
  reset(archTxt);
  assign(archBin, 'indumentaria');
  rewrite(archBin);

  while (not (eof(archTxt))) do begin
    readln(archTxt, reg.cod);
    readln(archTxt, reg.nom);
    readln(archTxt, reg.desc);
    readln(archTxt, reg.stock);
    write(archBin, reg);
  end;

  close(archTxt);
  close(archBin);
end;

procedure bajaLogica(var archBin: bin; cod: integer);
var
  encontre: boolean;
  reg: indumentaria;
begin
  reset(archBin);
  seek(archBin, 0);
  encontre := false;

  while (not eof(archBin)) and (not encontre) do begin
    read(archBin, reg);
    if (reg.cod = cod) then encontre := true;
  end;

  if (encontre) then begin
    reg.stock := -1;
    seek(archBin, filepos(archBin) - 1);
    write(archBin, reg);
  end;

  close(archBin);
end;

procedure alta(var archBin: bin; reg: indumentaria);
begin
  reset(archBin);

  seek(archBin, filesize(archBin));
  write(archBin, reg);

  close(archBin);
end;

procedure bajaListaInvertida(var archBin: bin; cod: integer);
var
  rLibre, reg: indumentaria;
  encontre: boolean;
  nLibre: integer;
begin
  reset(archBin);

  seek(archBin, 0);
  read(archBin, rLibre);
  encontre := false;

  while (not eof(archBin)) and (not encontre) do begin
    read(archBin, reg);
    if (reg.cod = cod) then encontre := true;
  end;
  if (encontre) then begin
    nLibre := filepos(archBin) - 1;
    seek(archBin, nLibre);
    reg.cod := rLibre.cod;
    write(archBin, reg);
    seek(archBin, 0);
    rLibre.cod := nLibre;
    write(archBin, rLibre);
  end;

  close(archBin);
end;

procedure altaListaInvertida(var archBin: bin; reg: indumentaria);
var
  rLibre: indumentaria;
  nLibre: integer;
begin
  reset(archBin);

  seek(archBin, 0);
  read(archBin, rLibre);
  nLibre := rLibre.cod;

  if (nLibre = -1) then seek(archBin, filesize(archBin))
  else begin
    seek(archBin, nLibre);
    read(archBin, rLibre);
    seek(archBin, 0);
    rLibre.cod := nLibre;
    write(archBin, rLibre);
    seek(archBin, nLibre);
  end;
  write(archBin, reg);

  close(archBin);
end;

begin
end.

