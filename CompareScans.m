pairs={
    {'V_7_Cycles_10_TxISO_without_skull.mat','V_7_Cycles_10_TxISO_with_skull.mat'},...
    {'V_7_Cycles_10_TxHarsonics_without_skull.mat','V_7_Cycles_10_TxHarsonics_with_skull.mat'},...
    {'V_7_Cycles_5_without_skull_226.mat','V_7_Cycles_5_with_skull_226.mat'},...
    {'V_7_cycles_15_without_skull_184.mat','V_7_cycles_15_with_skull_184.mat'}
    };

n_acquisitions = 100;
speed_ups = zeros([n_acquisitions, 4*length(pairs)]);
for i = 1:length(pairs)
    ind = (i-1)*4+1;
    skull = pairs{i}{2};
    no_skull = pairs{i}{1};

    [d_t] = calculate_speedup(skull,no_skull,true);
    speed_ups(:,ind:ind+3)=d_t;
end


% figs = {'V_7_Cycles_5_TxHarsonics.fig','V_7_Cycles15_TxHarsonics.fig',...,
%     'V_7_Cycles10_TxISO.fig','V_7_Cycles10_TxHarsonics.fig'};
speed_ups2 = speed_ups(:,1:12);
n_measurements = size(speed_ups2,1)*size(speed_ups2,2);
h=figure;
subplot(3,1,1);
hist(y,(1.35:0.1:2.85),'BinLimits',[1.4,2.8]);
xlabel('\Delta t (us)');
ylabel('# of Occurances');
title('Measurements Distribution');

subplot(3,1,2);
y = 1e6*reshape(speed_ups2,[1,n_measurements]);
x = 1:n_measurements;
colors= {'b','m','c','r'};
for i = 1:12
    ind = (i-1)*100+1;
    ind2 = i*100;
    plot(x(ind:ind2),y(ind:ind2),'o');%,strcat([colors(mod(i,4)+1),'o']));
    hold on;
end
xlabel('Acquisition Number');
ylabel('\Delta t (us)');
title('All 1600 Aquisitions');

subplot(3,1,3);
means = zeros([1,12]);
err = zeros([1,12]);
for i = 1:12
    ind = (i-1)*100+1;
    ind2 = i*100;
    means(i)=mean(y(ind:ind2));
    err(i) = std(y(ind:ind2));
end    
errorbar(1:12,means,err,'.');%,strcat([colors(mod(i,4)+1),'o']));
xlabel('Measurement Number');
ylabel('\Delta t (us)');
title('Speedup Measuremet at 16 Positions');
makeFigureBig(h);