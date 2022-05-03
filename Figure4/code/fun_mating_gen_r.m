function Xdot = fun_mating_gen_r(t,X,fww,fwd,fdd,p,d,r)

Xdot = zeros(2,1);

% X(1) == X(1); (1-X(1)-X(2)) == (1-X(1)-X(2)); X(2) == X(2);
    
Fww = 0.5*r*(fdd.*X(2)+fwd.*(1-X(1)-X(2))+fww.*X(1)).^(r-1)*((-1).*fwd.*((-1)+p).*(1-X(1)-X(2))+ ...
  fww.*X(1)).*(((-1)+d).*fwd.*((-1)+p).*(1-X(1)-X(2))+fww.*X(1));

Fwd = 0.5*2*r*(fdd.*X(2)+fwd.*p.*(1-X(1)-X(2))).*(fdd.*X(2)+fwd.*(1-X(1)-X(2))+fww.*X(1)).^(r-1)*((-1) ...
  .*fwd.*((-1)+p).*(1-X(1)-X(2))+fww.*X(1));

Fdd = 0.5*r.*(fdd.*X(2)+fwd.*p.*(1-X(1)-X(2))).^2.*(fdd.*X(2)+fwd.*(1-X(1)-X(2))+fww.*X(1)).^(r-1);


Xdot(1) = Fww - X(1)*(Fww + Fwd + Fdd);
Xdot(2) = Fdd - X(2)*(Fww + Fwd + Fdd);

end