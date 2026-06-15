program parcial;

type
  reg = record
    cod, cantVentas: integer;
    nom: string[15];
    desc: string[30];
  end;

  archBin = file of reg;

procedure leerTxt(var txt: Text; var rTxt: reg);
begin
  readln(txt, rTxt.cod);
  readln(txt, rTxt.nom);
  readln(txt, rTxt.desc);
  readln(txt, rTxt.cantVentas);
end;

procedure crearArchBin(var txt: Text);
var
  arch: archBin;
  codAct: integer;
  rTxt, rBin: reg;
begin
  reset(txt);
  assign(arch, 'excursionesCompact.dat');
  rewrite(arch);

  if (not eof(txt)) then leerTxt(txt, rTxt);

  while (not eof(txt)) do begin
    codAct := rTxt.cod;
    rBin.cod := codAct;
    rBin.nom := rTxt.nom;
    rBin.desc := rTxt.desc;
    rBin.cantVentas := 0;
    while (not eof(txt)) and (rTxt.cod = codAct) do begin
      rBin.cantVentas := rBin.cantVentas + rTxt.cantVentas;
      leerTxt(txt, rTxt);
    end;
    write(arch, rBin);
  end;
  close(arch);
  close(txt);
end;

var
  txt: Text;

begin
  assign(txt, 'excursiones.txt');
  crearArchBin(txt);
end.
