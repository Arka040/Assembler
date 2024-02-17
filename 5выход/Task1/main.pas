program main;
var
    X: longword;
    RES: shortint;
procedure Power2(X: longword; var RES: shortint);
stdcall;
external name '_Power2@0';
{$L u1.obj}

begin
    
    write('X = ');
    read(X);
    
    Power2(X, RES);
    
    write(RES);
    readln;readln
end.
