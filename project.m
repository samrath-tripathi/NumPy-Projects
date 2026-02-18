
% Decomposed daily returns of ANZ, CBA, NAB, and WBC into systematic and 
% idiosyncratic components using MATLAB. Used Gram–Schmidt and vector 
% projections to compute factor contributions. Measured daily idiosyncratic
% volatility to assess stock-specific risk


% Daily returns for each company (oldest to newest, Feb 10 → Feb 13)

ANZ  = [-0.0159; 0.0280; 0.0847; 0.0134]   % Company 1
CBA  = [-0.0046; 0.0590; 0.0541; -0.0142]  % Company 2
NAB  = [-0.0018; 0.0215; 0.0231; -0.0114]  % Company 3
WBC  = [-0.0182; 0.0252; 0.0181; -0.0117]  % Company 4

b1 = 1/sqrt(dot(ANZ,ANZ))*ANZ

w2 = CBA - dot(CBA,b1)*b1
b2 = 1/sqrt(dot(w2,w2))*w2

w3 = WBC - dot(WBC, b1)*b1 - dot(WBC,b2)*b2
b3 = 1/sqrt(dot(w3, w3)) * w3

% let the subspace of span(b1,b2,b3) be explainable factors

% Calculate the projection of NAB onto the span of b1, b2, and b3

projection = dot(NAB,b1)*b1 + dot(NAB,b2)*b2 + dot(NAB,b3)*b3

% the idyosyncratic returns are given by orthgonal complement to the
% projection

idyo = NAB - projection

mag = sqrt(dot(idyo,idyo)) % Over 4 day period
var_idyo = dot(idyo,idyo)/length(idyo)
std_idyo = sqrt(var_idyo)

% Percentage of idyosyncratic deviation from companies

fanz = dot(NAB,b1)^2/dot(NAB,NAB)
fcba = dot(NAB,b2)^2/dot(NAB,NAB)
fwbc = dot(NAB,b3)^2/dot(NAB,NAB)

% Fraction explained by each factor (percent)
fanz_percent = fanz*100;
fcba_percent = fcba*100;
fwbc_percent = fwbc*100;
fidyo_percent = (1 - (fanz + fcba + fwbc))*100;


Factor = {'ANZ'; 'CBA'; 'WBC'; 'Idiosyncratic'};
FractionExplained = [fanz_percent; fcba_percent; fwbc_percent; fidyo_percent];

resultsTable = table(Factor, FractionExplained);
disp('Fraction of NAB daily returns explained by each factor:');
disp(resultsTable);

