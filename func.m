function  dy  = func( t,y )
   a=2;b=0.2;c=3;d=0.3;    % zarayeb halate navasani
   dy = zeros(2,1);        % a column vector
   dy(1)=a*y(1)*(1-b*y(2));
   dy(2)=c*y(2)*(-1+d*y(1));
end

