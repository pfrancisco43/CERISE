function [Cp]=CalibrationPhase(Mp)
    qp=size(Mp,1); %Qtd de pacotes
    qs=size(Mp,2); %Qtd de subportadoras
    Cp=zeros(qp,qs);    
    m=-floor(qs/2):floor(qs/2);
    n=pi;    
    for j=1:qp        
        diff=0; 
        Tp=zeros(1,qs);
        Tp(1)=Mp(j,1);
        for i=2:qs
            if((Mp(j,i)-Mp(j,i-1))>n)
                diff=diff+1;
            end
            Tp(i)=Mp(j,i)-diff*2*pi;
        end
        k=(Tp(qs)-Tp(1))/(m(qs)-m(1));
        b=mean(Tp);
        for i=1:qs
            Cp(j,i)=Tp(i)-k*m(i)-b;
        end        
    end
end