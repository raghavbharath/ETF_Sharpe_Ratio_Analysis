% Raghav Bharathan ECE 321 Term Project
% ECE 321 Term Project - ETF Sharpe Ratio Analysis

% ---------------------------
% Part 1: Extract the data from excel to make it into a Matrix
% ---------------------------

% Use opts (given in MATLAB) to select the range of cells from the spreadsheet
% The variable range selects the stock data that enters the matrix 

filename = '4INDEX-1MIN-05012007-02272009.xlsx';
opts = detectImportOptions(filename);
opts.DataRange = '3:187291';

opts.SelectedVariableNames = [2];
DIA_MX = readmatrix(filename,opts);

opts.SelectedVariableNames = [3];
IWM_MX = readmatrix(filename,opts);

opts.SelectedVariableNames = [4];
QQQ_MX = readmatrix(filename,opts);

opts.SelectedVariableNames = [5];
SPY_MX = readmatrix(filename,opts);

% Reorganizes the column vector from 187289x1 to 391xk
DIA_t = reshape(DIA_MX, 391, []);
IWM_t = reshape(IWM_MX, 391, []);
QQQ_t = reshape(QQQ_MX, 391, []);
SPY_t = reshape(SPY_MX, 391, []);

% k = 479

% Transposed matrix (each column is now one minute)
DIA = DIA_t';
IWM = IWM_t';
QQQ = QQQ_t';
SPY = SPY_t';



for i = 2:391
    r_DIA(:,i)= (DIA(:, i)./DIA(:,i-1)) - 1;
    r_IWM(:,i)= (IWM(:, i)./IWM(:,i-1)) - 1;
    r_QQQ(:,i)= (QQQ(:, i)./QQQ(:,i-1)) - 1;
    r_SPY(:,i)= (SPY(:, i)./SPY(:,i-1)) - 1;
end

% Initializes the first column to null (9:00 price is not included)
r_DIA(:, 1) = [];
r_IWM(:, 1) = [];
r_QQQ(:, 1) = [];
r_SPY(:, 1) = [];

% Mean, standard deviation, and variance of the normalized return matrices

% DIA Mean, Variances and Standard Deviations
rDIA_mean = mean(r_DIA);
rDIA_var = var(r_DIA);
rDIA_std = std(r_DIA);

% IWM Mean, Variances and Standard Deviations
rIWM_mean = mean(r_IWM);
rIWM_var = var(r_IWM);
rIWM_std = std(r_IWM);

% QQQ Mean, Variances and Standard Deviations
rQQQ_mean = mean(r_QQQ);
rQQQ_var = var(r_QQQ);
rQQQ_std = std(r_QQQ);

% SPY Mean, Variances and Standard Deviations
rSPY_mean = mean(r_SPY);
rSPY_var = var(r_SPY);
rSPY_std = std(r_SPY);

% Vector in minutes
n = 1:390;

% DIA Plots

% DIA Mean Graph
figure;
plot(n, rDIA_mean, 'k'), xlabel('N'), ylabel('rDIA Mean')
title('Minute-wise Mean Value of rDIA')

% DIA Variance
figure;
plot(n, rDIA_var, 'k'), xlabel('N'), ylabel('rDIA Variance')
title('Minute-wise Variance of rDIA')

% DIA Standard deviation
figure;
plot(n, rDIA_std, 'k'), xlabel('N'), ylabel('rDIA Standard Deviation')
title('Minute-wise Standard Deviation of rDIA')


% ---------------------------
% Part 2: Find r(n) matrix for each column
% ---------------------------

% IWM Plots

% IWM Mean
figure;
plot(n, rIWM_mean, '-b'), xlabel('N'), ylabel('rIWM Mean')
title('Minute-wise Mean Value of rIWM')

% IWM Variance
figure;
plot(n, rIWM_var, '-b'), xlabel('N'), ylabel('rIWM Variance')
title('Minute-wise Variance of rIWM')

% IWM Standard deviation
figure;
plot(n, rIWM_std, '-b'), xlabel('N'), ylabel('rIWM Standard Deviation')
title('Minute-wise Standard Deviation of rIWM')


% QQQ Plots

% QQQ Mean
figure;
plot(n, rQQQ_mean, 'r'), xlabel('N'), ylabel('rQQQ Mean')
title('Minute-wise Mean Value of rQQQ')

% QQQ Variance
figure;
plot(n, rQQQ_var, 'r'), xlabel('N'), ylabel('rQQQ Variance')
title('Minute-wise Variance of rQQQ')

% QQQ Standard deviation
figure;
plot(n, rQQQ_std, 'r'), xlabel('N'), ylabel('rQQQ Standard Deviation')
title('Minute-wise Standard Deviation of rQQQ')


% SPY Plots
% SPY Mean
figure;
plot(n, rSPY_mean, 'g'), xlabel('N'), ylabel('rSPY Mean')
title('Minute-wise Mean Value of rSPY')

% SPY Variance
figure;
plot(n, rSPY_var, 'g'), xlabel('N'), ylabel('rSPY Variance')
title('Minute-wise Variance of rSPY')

% SPY Standard deviation
figure;
plot(n, rSPY_std, 'g'), xlabel('N'), ylabel('rSPY Standard Deviation')
title('Minute-wise Standard Deviation of rSPY')


% ---------------------------
% Part 3: Sharpe Ratios
% ---------------------------


% Sharpe Ratio

% SR(n) = r(n)/sd(n)

% DIA SR
SR_DIA = r_DIA./rDIA_std;

% IWM SR
SR_IWM = r_IWM./rIWM_std;

% QQQ SR
SR_QQQ = r_QQQ./rQQQ_std;

% SPY SR
SR_SPY = r_SPY./rSPY_std;

% Vector in days
n_k = 1:479;

% DIA SR
figure;
plot(n_k, SR_DIA, 'k'), xlabel('N'), ylabel('Sharpe Ratio DIA')
title('Daily DIA Sharpe Ratio')


% IWM SR
figure;
plot(n_k, SR_IWM, '-b'), xlabel('N'), ylabel('Sharpe Ratio IWM')
title('Daily IWM Sharpe Ratio')


% QQQ SR
figure;
plot(n_k, SR_QQQ, 'r'), xlabel('N'), ylabel('Sharpe Ratio QQQ')
title('Daily QQQ Sharpe Ratio')

% SPY SR
figure;
plot(n_k, SR_SPY, 'g'), xlabel('N'), ylabel('Sharpe Ratio SPY')
title('Daily SPY Sharpe Ratio')



% Mean of the SR/day with transpose
SR_DIA_mean = mean(SR_DIA');
SR_IWM_mean = mean(SR_IWM');
SR_QQQ_mean = mean(SR_QQQ');
SR_SPY_mean = mean(SR_SPY');
SR_DIA_Total = 1:479;
SR_IWM_Total = 1:479;
SR_QQQ_Total = 1:479;
SR_SPY_Total = 1:479;

% Initialize the beginning value to the day 1 SR mean
SR_DIA_Total(1) = SR_DIA_mean(1);
SR_IWM_Total(1) = SR_IWM_mean(1);
SR_QQQ_Total(1) = SR_QQQ_mean(1);
SR_SPY_Total(1) = SR_SPY_mean(1);

%Sums the current + next day for the following total return

for i = 1:478
    SR_DIA_Total(i+1) = SR_DIA_Total(i) + SR_DIA_mean(i+1);
    SR_IWM_Total(i+1) = SR_IWM_Total(i) + SR_IWM_mean(i+1);
    SR_QQQ_Total(i+1) = SR_QQQ_Total(i) + SR_QQQ_mean(i+1);
    SR_SPY_Total(i+1) = SR_SPY_Total(i) + SR_SPY_mean(i+1);
end


SR_DIA_Total_check = sum(SR_DIA_mean)

SR_IWM_Total_check = sum(SR_IWM_mean)

SR_QQQ_Total_check = sum(SR_QQQ_mean)

SR_SPY_Total_check = sum(SR_SPY_mean)

% SR DIA Standard Deviation
SR_DIA_std = std(SR_DIA');

% SR IWM Standard Deviation
SR_IWM_std = std(SR_IWM');

% SR QQQ Standard Deviation
SR_QQQ_std = std(SR_QQQ');

% SR SPY Standard Deviation
SR_SPY_std = std(SR_SPY');

% SR Mean
figure;
plot(n_k, SR_DIA_Total, 'k', n_k, SR_IWM_Total, '-b', n_k, SR_QQQ_Total, 'r', n_k, SR_SPY_Total, 'g'), xlabel('N'), ylabel('SR Mean')
legend('DIA', 'IWM', 'QQQ', 'SPY')
title('Cumulative (Sum) Mean Value of Sharpe Ratios')

% Conclusion 1: QQQ is the best stock to have invested in within this time period
% Conclusion 2: IWM had the lowest performance, both in terms of mean SR and stability.

% SR Standard Deviation
figure;
plot(n_k, SR_DIA_std, 'k', n_k, SR_IWM_std, '-b', n_k, SR_QQQ_std, 'r', n_k, SR_SPY_std, 'g'), xlabel('N'), ylabel('SR Standard Deviations')
legend('DIA', 'IWM', 'QQQ', 'SPY')
title('Daily SR Standard Deviation')