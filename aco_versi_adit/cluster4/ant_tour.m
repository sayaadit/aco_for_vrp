%**************************************************************************
%      Function to calculate ants tour matrix during one cycle 
%--------------------------------------------------------------------------
%                     The function Start Here                    
%--------------------------------------------------------------------------

function [new_places]=ant_tour(start_places,m,n,h,t,alpha,beta);
for i=1:m
    mh=h;
    for j=1:n-1
        c=start_places(i,j);
        mh(:,c)=0;
        temp=(t(c,:).^beta).*(mh(c,:).^alpha);
        s=(sum(temp));
        p=(1/s).*temp;
        r=rand;
        s=0;
        for k=1:n
            s=s+p(k);
            if r<=s
                start_places(i,j+1)=k;
                break
            end
        end
    end
end
new_places=start_places;
%**************************************************************************
%                   Ending of Function                        
%**************************************************************************

