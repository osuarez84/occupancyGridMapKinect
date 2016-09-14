function [probMap, probMapAux] = probabilisticMap(Ra, epsilon, kd, probMap, probMapAux, obsDA)

[dm, I] = min(obsDA(:,1));

mask1 = (Ra >= dm) & (Ra <= dm+epsilon);
mask2 = (Ra < dm) & (Ra > 0);
probMap(mask1) = 0.5 + (0.5/kd);
probMap(mask2) = 0.1;


probMap = (probMap.*probMapAux)./((probMap.*probMapAux) +...
    (1 - probMap).*(1 - probMapAux));

probMapAux = probMap;


end