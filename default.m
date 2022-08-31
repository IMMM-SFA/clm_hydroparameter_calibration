%% load all data

clear all; clc;

US = load('./us_coor.txt');
SL = load('./sl_coor.txt');

label_size = 12; line_width = 1; tick_size = 11; legend_size = 10; box_width = 0.5;
title_size = 12; tick_size = 12; text_size = 14; scatter_size = 20; colorbar_size= 10;


%% plot regional lines  default and best



data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
annual_v_bias = data.Var40; winter_v_bias = data.Var56; spring_v_bias = data.Var57; summer_v_bias = data.Var58;
fall_v_bias = data.Var59; q0_10_v_bias = data.Var42; q10_25_v_bias = data.Var44;
q25_50_v_bias = data.Var46; q50_75_v_bias = data.Var48; q75_90_v_bias = data.Var50; q90_100_v_bias = data.Var52;



scatter_size = 40; label_size = 14; legend_size = 14; tick_size = 14; colorbar_size= 14;title_size = 14;




x = 1:11;

% red = [139, 0, 0]/255;
% pink = [255, 192, 203]/255;
% length = size(bias_metric,1);
% colors_p = [linspace(red(1),pink(1),length)', linspace(red(2),pink(2),length)', linspace(red(3),pink(3),length)'];


% for i = 1:size(bias_metric,1)
%     if i == 1
%         h1 = plot(x, bias_metric(i,:), 'Color', colors_p(i,:)); hold on; ylim([-200, 400]);
%     else
%          plot(x, bias_metric(i,:), 'Color', colors_p(i,:)); hold on; ylim([-200, 400]);
%     end
% end

cluster= 1; marker_size = 10;
bias_metric = [annual_v_bias(cluster_ID==cluster), winter_v_bias(cluster_ID==cluster), spring_v_bias(cluster_ID==cluster),...
               summer_v_bias(cluster_ID==cluster), fall_v_bias(cluster_ID==cluster), q0_10_v_bias(cluster_ID==cluster),...
               q10_25_v_bias(cluster_ID==cluster), q25_50_v_bias(cluster_ID==cluster), q50_75_v_bias(cluster_ID==cluster),...
               q75_90_v_bias(cluster_ID==cluster), q90_100_v_bias(cluster_ID==cluster)];
h1 = plot(x, nanmedian(bias_metric,1), '-s', 'MarkerSize',marker_size, 'MarkerFaceColor',[230 159 0]/255, 'Color', [230 159 0]/255, 'linewidth', line_width+2); hold on; 



cluster= 2; 
bias_metric = [annual_v_bias(cluster_ID==cluster), winter_v_bias(cluster_ID==cluster), spring_v_bias(cluster_ID==cluster),...
               summer_v_bias(cluster_ID==cluster), fall_v_bias(cluster_ID==cluster), q0_10_v_bias(cluster_ID==cluster),...
               q10_25_v_bias(cluster_ID==cluster), q25_50_v_bias(cluster_ID==cluster), q50_75_v_bias(cluster_ID==cluster),...
               q75_90_v_bias(cluster_ID==cluster), q90_100_v_bias(cluster_ID==cluster)];
h2 = plot(x, nanmedian(bias_metric,1), '-s', 'MarkerSize',marker_size, 'MarkerFaceColor',[86 180 233]/255, 'Color', [86 180 233]/255, 'linewidth', line_width+2); hold on; 


cluster= 3; 
bias_metric = [annual_v_bias(cluster_ID==cluster), winter_v_bias(cluster_ID==cluster), spring_v_bias(cluster_ID==cluster),...
               summer_v_bias(cluster_ID==cluster), fall_v_bias(cluster_ID==cluster), q0_10_v_bias(cluster_ID==cluster),...
               q10_25_v_bias(cluster_ID==cluster), q25_50_v_bias(cluster_ID==cluster), q50_75_v_bias(cluster_ID==cluster),...
               q75_90_v_bias(cluster_ID==cluster), q90_100_v_bias(cluster_ID==cluster)];
h3 = plot(x, nanmedian(bias_metric,1), '-s', 'MarkerSize',marker_size, 'MarkerFaceColor',[0 158 115]/255, 'Color', [0 158 115]/255, 'linewidth', line_width+2); hold on; 

cluster= 4; 
bias_metric = [annual_v_bias(cluster_ID==cluster), winter_v_bias(cluster_ID==cluster), spring_v_bias(cluster_ID==cluster),...
               summer_v_bias(cluster_ID==cluster), fall_v_bias(cluster_ID==cluster), q0_10_v_bias(cluster_ID==cluster),...
               q10_25_v_bias(cluster_ID==cluster), q25_50_v_bias(cluster_ID==cluster), q50_75_v_bias(cluster_ID==cluster),...
               q75_90_v_bias(cluster_ID==cluster), q90_100_v_bias(cluster_ID==cluster)];
h4 = plot(x, nanmedian(bias_metric,1), '-s', 'MarkerSize',marker_size, 'MarkerFaceColor',[213 94 0]/255,'Color', [213 94 0]/255, 'linewidth', line_width+2); hold on; 

cluster= 5; 
bias_metric = [annual_v_bias(cluster_ID==cluster), winter_v_bias(cluster_ID==cluster), spring_v_bias(cluster_ID==cluster),...
               summer_v_bias(cluster_ID==cluster), fall_v_bias(cluster_ID==cluster), q0_10_v_bias(cluster_ID==cluster),...
               q10_25_v_bias(cluster_ID==cluster), q25_50_v_bias(cluster_ID==cluster), q50_75_v_bias(cluster_ID==cluster),...
               q75_90_v_bias(cluster_ID==cluster), q90_100_v_bias(cluster_ID==cluster)];
h5 = plot(x, nanmedian(bias_metric,1), '-s', 'MarkerSize',marker_size, 'MarkerFaceColor',[0 114 178]/255,'Color', [0 114 178]/255, 'linewidth', line_width+2); hold on; 

cluster= 6; 
bias_metric = [annual_v_bias(cluster_ID==cluster), winter_v_bias(cluster_ID==cluster), spring_v_bias(cluster_ID==cluster),...
               summer_v_bias(cluster_ID==cluster), fall_v_bias(cluster_ID==cluster), q0_10_v_bias(cluster_ID==cluster),...
               q10_25_v_bias(cluster_ID==cluster), q25_50_v_bias(cluster_ID==cluster), q50_75_v_bias(cluster_ID==cluster),...
               q75_90_v_bias(cluster_ID==cluster), q90_100_v_bias(cluster_ID==cluster)];
h6 = plot(x, nanmedian(bias_metric,1), '-s', 'MarkerSize',marker_size, 'MarkerFaceColor',[240 228 66]/255,'Color', [240 228 66]/255, 'linewidth', line_width+2); hold on; 


cluster= 7; 
bias_metric = [annual_v_bias(cluster_ID==cluster), winter_v_bias(cluster_ID==cluster), spring_v_bias(cluster_ID==cluster),...
               summer_v_bias(cluster_ID==cluster), fall_v_bias(cluster_ID==cluster), q0_10_v_bias(cluster_ID==cluster),...
               q10_25_v_bias(cluster_ID==cluster), q25_50_v_bias(cluster_ID==cluster), q50_75_v_bias(cluster_ID==cluster),...
               q75_90_v_bias(cluster_ID==cluster), q90_100_v_bias(cluster_ID==cluster)];
h7 = plot(x, nanmedian(bias_metric,1), '-s', 'MarkerSize',marker_size, 'MarkerFaceColor',[204 121 167]/255,'Color', [204 121 167]/255, 'linewidth', line_width+2); hold on; 



% title('(a) Default Performance', 'FontSize', title_size);


ylim([-100, 600]);
ylabel('Flow Volume Bias (%) in 2005-2014', 'FontSize', label_size); 
grid on;


l = legend([h1, h2, h3, h4, h5, h6, h7], {'Cluster 1-Northeast', 'Cluster 2-Pacific','Cluster 3-AZ/NM','Cluster 4-Rockies','Cluster 5-Great Plains',...
    'Cluster 6-Great Lakes','Cluster 7-Southeast'});
set(l,'FontSize',legend_size, 'Location','northwest','Orientation','vertical'); 
legend boxoff

xticks(x)
xticklabels({'Annual','Winter','Spring','Summer','Fall','Q0-10','Q10-25', 'Q25-50', 'Q50-75', 'Q75-90', 'Q90-100'})
set(gca,'FontSize',tick_size);
set(gca,'color',[240 240 240]/255)





%% best parameter regional ines (does not look good)
data = readtable('./flow_metrics/OUT_daily_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
annual_v_bias = metric_daily;

data = readtable('./flow_metrics/OUT_daily_winter_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
winter_v_bias = metric_daily;

data = readtable('./flow_metrics/OUT_daily_spring_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
spring_v_bias = metric_daily;

data = readtable('./flow_metrics/OUT_daily_summer_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
summer_v_bias = metric_daily;

data = readtable('./flow_metrics/OUT_daily_fall_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
fall_v_bias = metric_daily;

data = readtable('./flow_metrics/OUT_daily_q0_10_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
q0_10_v_bias = metric_daily;

data = readtable('./flow_metrics/OUT_daily_q10_25_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
q10_25_v_bias = metric_daily;

data = readtable('./flow_metrics/OUT_daily_q25_50_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
q25_50_v_bias = metric_daily;

data = readtable('./flow_metrics/OUT_daily_q50_75_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
q50_75_v_bias = metric_daily;

data = readtable('./flow_metrics/OUT_daily_q75_90_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
q75_90_v_bias = metric_daily;

data = readtable('./flow_metrics/OUT_daily_q90_100_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
q90_100_v_bias = metric_daily;


cluster= 1; 
bias_metric = [annual_v_bias(cluster_ID==cluster), winter_v_bias(cluster_ID==cluster), spring_v_bias(cluster_ID==cluster),...
               summer_v_bias(cluster_ID==cluster), fall_v_bias(cluster_ID==cluster), q0_10_v_bias(cluster_ID==cluster),...
               q10_25_v_bias(cluster_ID==cluster), q25_50_v_bias(cluster_ID==cluster), q50_75_v_bias(cluster_ID==cluster),...
               q75_90_v_bias(cluster_ID==cluster), q90_100_v_bias(cluster_ID==cluster)];
h1 = plot(x, nanmedian(bias_metric,1), 'Color', [139 0 0]/255, 'linewidth', line_width+2); hold on; 



cluster= 2; 
bias_metric = [annual_v_bias(cluster_ID==cluster), winter_v_bias(cluster_ID==cluster), spring_v_bias(cluster_ID==cluster),...
               summer_v_bias(cluster_ID==cluster), fall_v_bias(cluster_ID==cluster), q0_10_v_bias(cluster_ID==cluster),...
               q10_25_v_bias(cluster_ID==cluster), q25_50_v_bias(cluster_ID==cluster), q50_75_v_bias(cluster_ID==cluster),...
               q75_90_v_bias(cluster_ID==cluster), q90_100_v_bias(cluster_ID==cluster)];
h2 = plot(x, nanmedian(bias_metric,1), 'Color', [205 92 92]/255, 'linewidth', line_width+2); hold on; 


cluster= 3; 
bias_metric = [annual_v_bias(cluster_ID==cluster), winter_v_bias(cluster_ID==cluster), spring_v_bias(cluster_ID==cluster),...
               summer_v_bias(cluster_ID==cluster), fall_v_bias(cluster_ID==cluster), q0_10_v_bias(cluster_ID==cluster),...
               q10_25_v_bias(cluster_ID==cluster), q25_50_v_bias(cluster_ID==cluster), q50_75_v_bias(cluster_ID==cluster),...
               q75_90_v_bias(cluster_ID==cluster), q90_100_v_bias(cluster_ID==cluster)];
h3 = plot(x, nanmedian(bias_metric,1), 'Color', [255 182 193]/255, 'linewidth', line_width+2); hold on; 

cluster= 4; 
bias_metric = [annual_v_bias(cluster_ID==cluster), winter_v_bias(cluster_ID==cluster), spring_v_bias(cluster_ID==cluster),...
               summer_v_bias(cluster_ID==cluster), fall_v_bias(cluster_ID==cluster), q0_10_v_bias(cluster_ID==cluster),...
               q10_25_v_bias(cluster_ID==cluster), q25_50_v_bias(cluster_ID==cluster), q50_75_v_bias(cluster_ID==cluster),...
               q75_90_v_bias(cluster_ID==cluster), q90_100_v_bias(cluster_ID==cluster)];
h4 = plot(x, nanmedian(bias_metric,1), 'Color', [135 206 250]/255, 'linewidth', line_width+2); hold on; 

cluster= 5; 
bias_metric = [annual_v_bias(cluster_ID==cluster), winter_v_bias(cluster_ID==cluster), spring_v_bias(cluster_ID==cluster),...
               summer_v_bias(cluster_ID==cluster), fall_v_bias(cluster_ID==cluster), q0_10_v_bias(cluster_ID==cluster),...
               q10_25_v_bias(cluster_ID==cluster), q25_50_v_bias(cluster_ID==cluster), q50_75_v_bias(cluster_ID==cluster),...
               q75_90_v_bias(cluster_ID==cluster), q90_100_v_bias(cluster_ID==cluster)];
h5 = plot(x, nanmedian(bias_metric,1), 'Color', [100 149 237]/255, 'linewidth', line_width+2); hold on; 

cluster= 6; 
bias_metric = [annual_v_bias(cluster_ID==cluster), winter_v_bias(cluster_ID==cluster), spring_v_bias(cluster_ID==cluster),...
               summer_v_bias(cluster_ID==cluster), fall_v_bias(cluster_ID==cluster), q0_10_v_bias(cluster_ID==cluster),...
               q10_25_v_bias(cluster_ID==cluster), q25_50_v_bias(cluster_ID==cluster), q50_75_v_bias(cluster_ID==cluster),...
               q75_90_v_bias(cluster_ID==cluster), q90_100_v_bias(cluster_ID==cluster)];
h6 = plot(x, nanmedian(bias_metric,1), 'Color', [70 130 180]/255, 'linewidth', line_width+2); hold on; 


cluster= 7; 
bias_metric = [annual_v_bias(cluster_ID==cluster), winter_v_bias(cluster_ID==cluster), spring_v_bias(cluster_ID==cluster),...
               summer_v_bias(cluster_ID==cluster), fall_v_bias(cluster_ID==cluster), q0_10_v_bias(cluster_ID==cluster),...
               q10_25_v_bias(cluster_ID==cluster), q25_50_v_bias(cluster_ID==cluster), q50_75_v_bias(cluster_ID==cluster),...
               q75_90_v_bias(cluster_ID==cluster), q90_100_v_bias(cluster_ID==cluster)];
h7 = plot(x, nanmedian(bias_metric,1), 'Color', [0 0 128]/255, 'linewidth', line_width+2); hold on; 



title('(b) Best Performance in Ensembles', 'FontSize', title_size);

set(gca,'color',[240 240 240]/255)
ylim([-100, 100]);
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 
grid on;


l = legend([h1, h2, h3, h4, h5, h6, h7], {'Cluster 1', 'Cluster 2','Cluster 3','Cluster 4','Cluster 5','Cluster 6','Cluster 7'});
set(l,'FontSize',legend_size, 'Location','northwest','Orientation','vertical'); 
legend boxoff

xticks(x)
xticklabels({'Annual','Winter','Spring','Summer','Fall','Q0-10','Q10-25', 'Q25-50', 'Q50-75', 'Q75-90', 'Q90-100'})
set(gca,'FontSize',tick_size);
set(gca,'color',[240 240 240]/255)





%% plot one spatial plot only

scatter_size = 40; label_size = 14; legend_size = 14; tick_size = 14; colorbar_size= 14;title_size = 14;
data = readtable('./ET_metrics/default_monthly_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_daily = data.Var5;   % var6-nse, var7-kge
fmt = {'o','^','v','s','>','h','<'};
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

cluster=1;h1 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=2;h2 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=3;h3 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=4;h4 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=5;h5 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=6;h6 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=7;h7 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;

set(gca,'FontSize',tick_size);

c = colorbar; 
caxis([-50 50]);  
colormap(brewermap([],'*RdBu'));    
c.FontSize = colorbar_size;


c=colorbar;
x1=get(gca,'position');
x=get(c,'Position');
x(3)=0.02;
set(c,'Position',x)
set(gca,'position',x1)


d = cbarrow('down');



plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

% title('Daily Flow: KGE', 'FontSize', title_size);
box on; 

% l = legend([h1, h2, h3, h4, h5, h6, h7], {'1', '2', '3', '4', '5', '6','7'});
% set(l,'FontSize',legend_size, 'Location','southwest','Orientation','horizontal'); 
htitle = get(l,'Title');
set(htitle,'String','Cluster', 'FontSize', legend_size);
legend boxoff
htitle.NodeChildren.Position = [0.1 0.752577319650977 0] ;         

set(gca,'color',[240 240 240]/255)



%% plot the best


scatter_size = 40; label_size = 14; legend_size = 14; tick_size = 14; colorbar_size= 14;title_size = 14;
data = readtable('./flow_metrics/OUT_D_NSE.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nanmax(ensemble,[], 2);
fmt = {'o','^','v','s','>','h','<'};
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

cluster=1;h1 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=2;h2 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=3;h3 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=4;h4 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=5;h5 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=6;h6 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=7;h7 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;


set(gca,'FontSize',tick_size); colormap(jet)

c = colorbar; caxis([0 1]);  
% colormap(brewermap([],'*RdBu'));    
c.FontSize = colorbar_size;

% c=colorbar;
x1=get(gca,'position');
x=get(c,'Position');
x(3)=0.02;
set(c,'Position',x)
set(gca,'position',x1)


d = cbarrow('down');

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

% title('(a) Daily Flow KGE: Best', 'FontSize', title_size);
l = legend([h1, h2, h3, h4, h5, h6, h7], {'1', '2', '3', '4', '5', '6','7'});
set(l,'FontSize',legend_size, 'Location','southwest','Orientation','horizontal'); 
htitle = get(l,'Title');
set(htitle,'String','Cluster', 'FontSize', legend_size);
legend boxoff
htitle.NodeChildren.Position = [0.1 0.752577319650977 0] ;         

set(gca,'color',[240 240 240]/255)





















%% bar plot the overalpped parameter (%) among daily and monthly RMSE
load('matlab_overlap_matric.mat');
median_metric = nan(7, 1);

scatter_size = 40; label_size = 16; legend_size = 16; tick_size = 16; colorbar_size= 14;title_size = 16;


for cluster = 1:7
    
matrix1(:,:) = matrix(:,:,cluster);
median_metric(cluster,1) = matrix1(3,8);
end











bar(median_metric, 0.5, 'FaceColor',[169 169 169]/255,'EdgeColor',[0 0 0],'LineWidth',1.5);

xlim([0.5,7.5]); ylim([0 70]);
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Median Percentage', 'FontSize', label_size);
set(gca,'FontSize',tick_size);
box on; grid on;

set(gca,'color',[240 240 240]/255)









%% bar plot the 7 median KGE sites for each cluster

data = readtable('./flow_metrics/default_daily_metrics.csv');
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_daily = data.Var7;  %KGE
% metric_daily = data.Var40;  %annual volume bias
median_metric = nan(7, 1);

scatter_size = 40; label_size = 16; legend_size = 16; tick_size = 16; colorbar_size= 14;title_size = 16;


for cluster = 1:7
    
    cluster_value = metric_daily(cluster_ID==cluster);
    cluster_lat = lat(cluster_ID==cluster);
    cluster_lon = lon(cluster_ID==cluster);
    cluster_id = basin_id(cluster_ID==cluster);
    
    median_metric(cluster,1) = median(cluster_value);



end


bar(median_metric, 0.5, 'FaceColor',[169 169 169]/255,'EdgeColor',[0 0 0],'LineWidth',1.5);

xlim([0.5,7.5]); %ylim([-10, 250]);
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Median Flow Bias (%)', 'FontSize', label_size);
set(gca,'FontSize',tick_size);
box on; grid on;

set(gca,'color',[240 240 240]/255)




%% bar plot for the best daily KGE

median_metric = nan(7, 1);

scatter_size = 40; label_size = 16; legend_size = 16; tick_size = 16; colorbar_size= 14;title_size = 16;
data = readtable('./flow_metrics/OUT_D_KGE.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nanmax(ensemble,[], 2);

for cluster = 1:7
    
    cluster_value = metric_daily(cluster_ID==cluster);
    cluster_lat = lat(cluster_ID==cluster);
    cluster_lon = lon(cluster_ID==cluster);
    cluster_id = basin_id(cluster_ID==cluster);
    
    median_metric(cluster,1) = median(cluster_value);



end


bar(median_metric, 0.5, 'FaceColor',[169 169 169]/255,'EdgeColor',[0 0 0],'LineWidth',1.5);

xlim([0.5,7.5]); ylim([0,0.6]);
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Median KGE', 'FontSize', label_size);
set(gca,'FontSize',tick_size);
box on; grid on;

set(gca,'color',[240 240 240]/255)









%% plot the 7 median KGE sites for each cluster
data = readtable('./flow_metrics/default_daily_metrics.csv');
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_daily = data.Var7;
repre_basin = nan(7, 6); % 1, cluster, 2-basin id, 3-lat, 4-lon, 5-median KGE daily, 6-basin KGE vlalue

label_size = 20; line_width = 1; tick_size = 11; legend_size = 17; box_width = 0.5;
title_size = 20; tick_size = 20; text_size = 20; scatter_size = 20; colorbar_size= 10;

for cluster = 1:7
    
    cluster_value = metric_daily(cluster_ID==cluster);
    cluster_lat = lat(cluster_ID==cluster);
    cluster_lon = lon(cluster_ID==cluster);
    cluster_id = basin_id(cluster_ID==cluster);
    
    median_value = median(cluster_value);
    repre_basin(cluster,5) = median_value;
    repre_basin(cluster,1) = cluster;
    
    [m,i] = min(abs(cluster_value - median_value));
    
    if cluster==2
        i = 60;
    end
    
    if cluster==7
        i=40;
    end
    
    repre_basin(cluster,3) = cluster_lat(i);
    repre_basin(cluster,4) = cluster_lon(i);
    repre_basin(cluster,6) = cluster_value(i);
    
    repre_basin(cluster,2) = cluster_id(i);
   
end













id =1;


data = readtable('./flow_metrics/default_daily_metrics.csv');
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
D_KGE = data.Var7; D_NSE = data.Var6; D_E50 = data.Var55;

data = readtable('./flow_metrics/default_monthly_metrics.csv');
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
M_KGE = data.Var7; M_NSE = data.Var6; M_E50 = data.Var55;

index = find(basin_id==repre_basin(id,2));
D_KGE = D_KGE(index); D_NSE = D_NSE(index); D_E50 = D_E50(index);
M_KGE = M_KGE(index); M_NSE = M_NSE(index); M_E50 = M_E50(index);

subplot(2,1,1)

daily = load(sprintf('./flow_metrics/%08d_daily',repre_basin(id,2)));     daily(daily(:)==-9999) = nan;
monthly = load(sprintf('./flow_metrics/%08d_monthly',repre_basin(id,2))); monthly(monthly(:)==-9999) = nan;

sim_datenum = nan(size(daily,1),1);
for i = 1:size(daily,1)
    sim_datenum(i,1) = datenum([daily(i,1), daily(i,2), daily(i,3), 0, 0 ,0]);
end
h2 = plot(sim_datenum, daily(:,4), '-', 'color', [100 149 237]/255,  'Linewidth', line_width); hold on; 
h1 = plot(sim_datenum, daily(:,5), '-', 'color', [205 92 92]/255,  'Linewidth', line_width); hold on; 

l = legend([h1, h2], {'Obs.', 'Sim.'});
set(l,'FontSize',legend_size, 'Location','northwest','Orientation','horizontal'); 
legend boxoff
grid on;
box on;



xlabel('Date (MM/YY)', 'FontSize', label_size); 
ylabel('Streamflow (m^3/s)', 'FontSize', label_size);
set(gca,'FontSize',tick_size);
xlim([sim_datenum(1) sim_datenum(end)]);
NumTicks = 10;
L = get(gca,'XLim'); set(gca,'XTick',linspace(L(1),L(2),NumTicks))
datetick('x','mm/yy','keeplimits', 'keepticks'); 
title(sprintf('(b) Daily Flow of Cluster %d: Basin %08d', id, repre_basin(id,2)), 'FontSize', title_size); 


text(0.6, 0.9, sprintf('KGE = %4.2f', D_KGE), 'FontSize',text_size, 'Units','Normalized');
text(0.6, 0.8, sprintf('NSE = %4.2f', D_NSE), 'FontSize',text_size, 'Units','Normalized');
% text(0.6, 0.7, sprintf('E50 of Squared Error = %d days', D_E50), 'FontSize',text_size, 'Units','Normalized');

set(gca,'color',[240 240 240]/255)


subplot(2,1,2)

sim_datenum = nan(size(monthly,1),1);
for i = 1:size(monthly,1)
    sim_datenum(i,1) = datenum([monthly(i,1), monthly(i,2), 1, 0, 0 ,0]);
end
h2 = plot(sim_datenum, monthly(:,3), '-', 'color', [100 149 237]/255,  'Linewidth', line_width); hold on; 
h1 = plot(sim_datenum, monthly(:,4), '-', 'color', [205 92 92]/255,  'Linewidth', line_width); hold on; 

xlabel('Date (MM/YY)', 'FontSize', label_size); 
ylabel('Streamflow (m^3/s)', 'FontSize', label_size);
set(gca,'FontSize',tick_size);
xlim([sim_datenum(1) sim_datenum(end)]);
NumTicks = 10;
L = get(gca,'XLim'); set(gca,'XTick',linspace(L(1),L(2),NumTicks))
datetick('x','mm/yy','keeplimits', 'keepticks'); 
title(sprintf('(c) Monthly Flow of Cluster %d: Basin %08d', id, repre_basin(id,2)), 'FontSize', title_size); 

grid on;
box on;

text(0.6, 0.9, sprintf('KGE = %4.2f', M_KGE), 'FontSize',text_size, 'Units','Normalized');
text(0.6, 0.8, sprintf('NSE = %4.2f', M_NSE), 'FontSize',text_size, 'Units','Normalized');
% text(0.6, 0.7, sprintf('E50 of Squared Error = %d months', M_E50), 'FontSize',text_size, 'Units','Normalized');

set(gca,'color',[240 240 240]/255)

























%% plot ensemble time series
daily = load('./flow_metrics/02198100_daily'); daily(daily(:)==-9999) = nan;
daily_ensemble = load('./flow_metrics/02198100_daily_ensemble'); daily_ensemble(daily_ensemble(:)==-9999) = nan;


sim_datenum = nan(size(daily,1),1);
for i = 1:size(daily,1)
    sim_datenum(i,1) = datenum([daily(i,1), daily(i,2), daily(i,3), 0, 0 ,0]);
end
h2 = plot(sim_datenum, daily(:,4), '-', 'color', [100 149 237]/255,  'Linewidth', line_width); hold on; 
h1 = plot(sim_datenum, daily(:,5), '-', 'color', [205 92 92]/255,  'Linewidth', line_width); hold on; 


scatter(daily(:,5), daily(:,4)); hold on;


data = readtable('./flow_metrics/OUT_D_RMSE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;
index = find(common_daily_monthly(:,1)==2198100);
ensemble = ensemble(index,:);
[i,m] = max(ensemble);
plot(sim_datenum, daily_ensemble(:,m), '-', 'color', [0 0 0]/255,  'Linewidth', line_width/2); hold on;




data = readtable('./flow_metrics/OUT_D_TRMSE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;
index = find(common_daily_monthly(:,1)==2198100);
ensemble = ensemble(index,:);
[i,m] = max(ensemble);
plot(sim_datenum, daily_ensemble(:,m), '-', 'color', [255 0 255]/255,  'Linewidth', line_width/2); hold on;









% l = legend([h1, h2], {'Obs.', 'Sim.'});
% set(l,'FontSize',legend_size, 'Location','northwest','Orientation','horizontal'); 
% legend boxoff
% grid on;
% box on;


%% plot time series for only 2 basin at daily and monthly scale


daily = load('./flow_metrics/09065500_daily'); daily(daily(:)==-9999) = nan;
daily_ensemble = load('./flow_metrics/09065500_daily_ensemble'); daily_ensemble(daily_ensemble(:)==-9999) = nan;
monthly = load('./flow_metrics/09065500_monthly'); monthly(monthly(:)==-9999) = nan;
monthly_ensemble = load('./flow_metrics/09065500_monthly_ensemble'); monthly_ensemble(monthly_ensemble(:)==-9999) = nan;

data = readtable('./flow_metrics/OUT_D_RMSE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;
index = find(common_daily_monthly(:,1)==9065500);
ensemble = ensemble(index,:);
[i,m] = max(ensemble);
daily_ensemble_best = daily_ensemble(:,m);

data = readtable('./flow_metrics/OUT_M_RMSE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;
index = find(common_daily_monthly(:,1)==9065500);
ensemble = ensemble(index,:);
[i,m] = max(ensemble);
monthly_ensemble_best = monthly_ensemble(:,m);

data = readtable('./flow_metrics/OUT_D_NSE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
index = find(common_daily_monthly(:,1)==9065500);
ensemble = ensemble(index,:);
D_NSE_best = max(ensemble);

data = readtable('./flow_metrics/OUT_M_NSE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
index = find(common_daily_monthly(:,1)==9065500);
ensemble = ensemble(index,:);
M_NSE_best = max(ensemble);

data = readtable('./flow_metrics/default_daily_metrics.csv');
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
D_KGE = data.Var7; D_NSE = data.Var6; D_E50 = data.Var55;

data = readtable('./flow_metrics/default_monthly_metrics.csv');
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
M_KGE = data.Var7; M_NSE = data.Var6; M_E50 = data.Var55;

index = find(basin_id==9065500);
D_KGE = D_KGE(index); D_NSE = D_NSE(index); D_E50 = D_E50(index);
M_KGE = M_KGE(index); M_NSE = M_NSE(index); M_E50 = M_E50(index);



label_size = 12; line_width = 1; tick_size = 12; legend_size = 12; box_width = 0.5;
title_size = 12; tick_size = 12; text_size = 12; scatter_size = 20; colorbar_size= 10;


subplot(4,1,1)
sim_datenum = nan(size(daily,1),1);
for i = 1:size(daily,1)
    sim_datenum(i,1) = datenum([daily(i,1), daily(i,2), daily(i,3), 0, 0 ,0]);
end
h2 = plot(sim_datenum, daily(:,4), '-', 'color', [213 94 0]/255,  'Linewidth', line_width/2); hold on; 
h1 = plot(sim_datenum, daily(:,5), '-', 'color', [0 0 0]/255,  'Linewidth', line_width/2); hold on; 
h3 = plot(sim_datenum, daily_ensemble_best, '-', 'color', [0 114 178]/255,  'Linewidth', line_width/2); hold on; 


l = legend([h1, h2, h3], {'Obs', sprintf('Sim: Default (NSE=%4.2f, E50=%d days)', D_NSE, D_E50), sprintf('Sim: Lowest Daily RMSE (NSE=%4.2f)', D_NSE_best)});
set(l,'FontSize',legend_size, 'Location','northwest','Orientation','horizontal'); 
legend boxoff
grid on;
box on;

% xlabel('Date (MM/YY)', 'FontSize', label_size); 
ylabel('Daily Streamflow (m^3/s)', 'FontSize', label_size);
set(gca,'FontSize',tick_size);
xlim([sim_datenum(1) sim_datenum(end)]);
NumTicks = 10;
L = get(gca,'XLim'); set(gca,'XTick',linspace(L(1),L(2),NumTicks))
datetick('x','mm/yy','keeplimits', 'keepticks'); 
title('(a) Basin 09065500 in CO, Cluster 4', 'FontSize', title_size); 
set(gca,'color',[240 240 240]/255)

text(0.025, 0.7, 'Top 3 Parameters to Daily RMSE (Normalized Sensitivity Score)', 'FontSize',text_size, 'Units','Normalized');
% text(0.55, 0.75, '(Normalized Sensitivity Score)', 'FontSize',text_size, 'Units','Normalized');
text(0.025, 0.6, '1. Ɵ_{sat} (1.00)', 'FontSize',text_size, 'Units','Normalized');
text(0.025+0.13, 0.61, '2. fff (0.54)', 'FontSize',text_size, 'Units','Normalized');
text(0.025+0.13*2, 0.6, '3. Ɵ_{ini} (0.50)', 'FontSize',text_size, 'Units','Normalized');


subplot(4,1,2)
sim_datenum = nan(size(monthly,1),1);
for i = 1:size(monthly,1)
    sim_datenum(i,1) = datenum([monthly(i,1), monthly(i,2), 1, 0, 0 ,0]);
end
h2 = plot(sim_datenum, monthly(:,3), '-', 'color', [213 94 0]/255,  'Linewidth', line_width); hold on; 
h1 = plot(sim_datenum, monthly(:,4), '-', 'color', [0 0 0]/255,  'Linewidth', line_width); hold on; 
h3 = plot(sim_datenum, monthly_ensemble_best, '-', 'color', [0 114 178]/255,  'Linewidth', line_width); hold on; 

% xlabel('Date (MM/YY)', 'FontSize', label_size); 
ylabel('Monthly Streamflow (m^3/s)', 'FontSize', label_size);
set(gca,'FontSize',tick_size);
xlim([sim_datenum(1) sim_datenum(end)]);
NumTicks = 10;
L = get(gca,'XLim'); set(gca,'XTick',linspace(L(1),L(2),NumTicks))
datetick('x','mm/yy','keeplimits', 'keepticks'); 
title('(b) Basin 09065500 in CO, Cluster 4', 'FontSize', title_size); 
ylim([0, 10]);
grid on;
box on;
set(gca,'color',[240 240 240]/255)

l = legend([h1, h2, h3], {'Obs', sprintf('Sim: Default (NSE=%4.2f, E50=%d months)', M_NSE, M_E50), sprintf('Sim: Lowest Monthly RMSE (NSE=%4.2f)', M_NSE_best)});
set(l,'FontSize',legend_size, 'Location','northwest','Orientation','horizontal'); 
legend boxoff
grid on;
box on;

text(0.025, 0.7, 'Top 3 Parameters to Monthly RMSE (Normalized Sensitivity Score)', 'FontSize',text_size, 'Units','Normalized');
% text(0.55, 0.85, '(Normalized Sensitivity Score)', 'FontSize',text_size, 'Units','Normalized');
text(0.025, 0.6, '1. k_{acc} (1.00)', 'FontSize',text_size, 'Units','Normalized');
text(0.025+0.13, 0.6, '2. N_{melt} (0.99)', 'FontSize',text_size, 'Units','Normalized');
text(0.025+0.13*2, 0.6, '3. Ɵ_{ini} (0.84)', 'FontSize',text_size, 'Units','Normalized');





daily = load('./flow_metrics/07060710_daily'); daily(daily(:)==-9999) = nan;
daily_ensemble = load('./flow_metrics/07060710_daily_ensemble'); daily_ensemble(daily_ensemble(:)==-9999) = nan;
monthly = load('./flow_metrics/07060710_monthly'); monthly(monthly(:)==-9999) = nan;
monthly_ensemble = load('./flow_metrics/07060710_monthly_ensemble'); monthly_ensemble(monthly_ensemble(:)==-9999) = nan;

data = readtable('./flow_metrics/OUT_D_RMSE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;
index = find(common_daily_monthly(:,1)==7060710);
ensemble = ensemble(index,:);
[i,m] = max(ensemble);
daily_ensemble_best = daily_ensemble(:,m);

data = readtable('./flow_metrics/OUT_M_RMSE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;
index = find(common_daily_monthly(:,1)==7060710);
ensemble = ensemble(index,:);
[i,m] = max(ensemble);
monthly_ensemble_best = monthly_ensemble(:,m);

data = readtable('./flow_metrics/OUT_D_NSE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
index = find(common_daily_monthly(:,1)==7060710);
ensemble = ensemble(index,:);
D_NSE_best = max(ensemble);

data = readtable('./flow_metrics/OUT_M_NSE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
index = find(common_daily_monthly(:,1)==7060710);
ensemble = ensemble(index,:);
M_NSE_best = max(ensemble);

data = readtable('./flow_metrics/default_daily_metrics.csv');
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
D_KGE = data.Var7; D_NSE = data.Var6; D_E50 = data.Var55;

data = readtable('./flow_metrics/default_monthly_metrics.csv');
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
M_KGE = data.Var7; M_NSE = data.Var6; M_E50 = data.Var55;

index = find(basin_id==7060710);
D_KGE = D_KGE(index); D_NSE = D_NSE(index); D_E50 = D_E50(index);
M_KGE = M_KGE(index); M_NSE = M_NSE(index); M_E50 = M_E50(index);






subplot(4,1,3)
sim_datenum = nan(size(daily,1),1);
for i = 1:size(daily,1)
    sim_datenum(i,1) = datenum([daily(i,1), daily(i,2), daily(i,3), 0, 0 ,0]);
end
h2 = plot(sim_datenum, daily(:,4), '-', 'color', [213 94 0]/255,  'Linewidth', line_width/2); hold on; 
h1 = plot(sim_datenum, daily(:,5), '-', 'color', [0 0 0]/255,  'Linewidth', line_width/2); hold on; 
h3 = plot(sim_datenum, daily_ensemble_best, '-', 'color', [0 114 178]/255,  'Linewidth', line_width/2); hold on; 


l = legend([h1, h2, h3], {'Obs', sprintf('Sim: Default (NSE=%4.2f, E50=%d days)', D_NSE, D_E50), sprintf('Sim: Lowest Daily RMSE (NSE=%4.2f)', D_NSE_best)});
set(l,'FontSize',legend_size, 'Location','northwest','Orientation','horizontal'); 
legend boxoff
grid on;
box on;

% xlabel('Date (MM/YY)', 'FontSize', label_size); 
ylabel('Daily Streamflow (m^3/s)', 'FontSize', label_size);
set(gca,'FontSize',tick_size);
xlim([sim_datenum(1) sim_datenum(end)]);
NumTicks = 10;
L = get(gca,'XLim'); set(gca,'XTick',linspace(L(1),L(2),NumTicks))
datetick('x','mm/yy','keeplimits', 'keepticks'); 
title('(c) Basin 07060710 in AR, Cluster 1', 'FontSize', title_size); 
set(gca,'color',[240 240 240]/255)

text(0.025, 0.7, 'Top 3 Parameters to Daily RMSE (Normalized Sensitivity Score)', 'FontSize',text_size, 'Units','Normalized');
% text(0.55, 0.75, '(Normalized Sensitivity Score)', 'FontSize',text_size, 'Units','Normalized');
text(0.025, 0.6, '1. K_{bf} (1.00)', 'FontSize',text_size, 'Units','Normalized');
text(0.025+0.13, 0.6, '2. Ɵ_{sat} (0.36)', 'FontSize',text_size, 'Units','Normalized');
text(0.025+0.13*2, 0.6, '3. ψ_{sat} (0.17)', 'FontSize',text_size, 'Units','Normalized');


subplot(4,1,4)
sim_datenum = nan(size(monthly,1),1);
for i = 1:size(monthly,1)
    sim_datenum(i,1) = datenum([monthly(i,1), monthly(i,2), 1, 0, 0 ,0]);
end
h2 = plot(sim_datenum, monthly(:,3), '-', 'color', [213 94 0]/255,  'Linewidth', line_width); hold on; 
h1 = plot(sim_datenum, monthly(:,4), '-', 'color', [0 0 0]/255,  'Linewidth', line_width); hold on; 
h3 = plot(sim_datenum, monthly_ensemble_best, '-', 'color', [0 114 178]/255,  'Linewidth', line_width); hold on; 

xlabel('Date (MM/YY)', 'FontSize', label_size); 
ylabel('Monthly Streamflow (m^3/s)', 'FontSize', label_size);
set(gca,'FontSize',tick_size);
xlim([sim_datenum(1) sim_datenum(end)]);
NumTicks = 10;
L = get(gca,'XLim'); set(gca,'XTick',linspace(L(1),L(2),NumTicks))
datetick('x','mm/yy','keeplimits', 'keepticks'); 
title('(d) Basin 07060710 in AR, Cluster 1', 'FontSize', title_size); 
ylim([0, 20]);
grid on;
box on;
set(gca,'color',[240 240 240]/255)

l = legend([h1, h2, h3], {'Obs', sprintf('Sim: Default (NSE=%4.2f, E50=%d months)', M_NSE, M_E50), sprintf('Sim: Lowest Monthly RMSE (NSE=%4.2f)', M_NSE_best)});
set(l,'FontSize',legend_size, 'Location','northwest','Orientation','horizontal'); 
legend boxoff
grid on;
box on;

text(0.025, 0.7, 'Top 3 Parameters to Monthly RMSE (Normalized Sensitivity Score)', 'FontSize',text_size, 'Units','Normalized');
% text(0.55, 0.85, '(Normalized Sensitivity Score)', 'FontSize',text_size, 'Units','Normalized');
text(0.025, 0.6, '1. Ɵ_{sat} (1.00)', 'FontSize',text_size, 'Units','Normalized');
text(0.025+0.13, 0.61, '2. fff (0.61)', 'FontSize',text_size, 'Units','Normalized');
text(0.025+0.13*2, 0.6, '3. K_{bf} (0.25)', 'FontSize',text_size, 'Units','Normalized');















%% plot time series
daily = load('./flow_metrics/02215100_daily'); daily(daily(:)==-9999) = nan;
weekly = load('./flow_metrics/09065500_weekly'); weekly(weekly(:)==-9999) = nan;
monthly = load('./flow_metrics/09065500_monthly'); monthly(monthly(:)==-9999) = nan;
annually = load('./flow_metrics/09065500_annually'); annually(annually(:)==-9999) = nan;





subplot(2,2,1)
sim_datenum = nan(size(daily,1),1);
for i = 1:size(daily,1)
    sim_datenum(i,1) = datenum([daily(i,1), daily(i,2), daily(i,3), 0, 0 ,0]);
end
h2 = plot(sim_datenum, daily(:,4), '-', 'color', [100 149 237]/255,  'Linewidth', line_width); hold on; 
h1 = plot(sim_datenum, daily(:,5), '-', 'color', [205 92 92]/255,  'Linewidth', line_width); hold on; 

l = legend([h1, h2], {'Obs.', 'Sim.'});
set(l,'FontSize',legend_size, 'Location','northwest','Orientation','horizontal'); 
legend boxoff
grid on;
box on;



xlabel('Date (MM/YY)', 'FontSize', label_size); 
ylabel('Streamflow (m^3/s)', 'FontSize', label_size);
set(gca,'FontSize',tick_size);
xlim([sim_datenum(1) sim_datenum(end)]);
NumTicks = 10;
L = get(gca,'XLim'); set(gca,'XTick',linspace(L(1),L(2),NumTicks))
datetick('x','mm/yy','keeplimits', 'keepticks'); 
title('(a): Daily Scale', 'FontSize', title_size); 






subplot(2,2,2)
sim_datenum = nan(size(weekly,1),1);
for i = 1:size(weekly,1)
    sim_datenum(i,1) = datenum([weekly(i,1), weekly(i,2), weekly(i,3), 0, 0 ,0]);
end
h2 = plot(sim_datenum, weekly(:,4), '-', 'color', [100 149 237]/255,  'Linewidth', line_width); hold on; 
h1 = plot(sim_datenum, weekly(:,5), '-', 'color', [205 92 92]/255,  'Linewidth', line_width); hold on; 


xlabel('Date (MM/YY)', 'FontSize', label_size); 
ylabel('Streamflow (m^3/s)', 'FontSize', label_size);
set(gca,'FontSize',tick_size);
xlim([sim_datenum(1) sim_datenum(end)]);
NumTicks = 3;
L = get(gca,'XLim'); set(gca,'XTick',linspace(L(1),L(2),NumTicks))
datetick('x','mm/yy','keeplimits', 'keepticks'); 
title('(b): Weekly Scale', 'FontSize', title_size); 
grid on;
box on;

subplot(2,2,3)

sim_datenum = nan(size(monthly,1),1);
for i = 1:size(monthly,1)
    sim_datenum(i,1) = datenum([monthly(i,1), monthly(i,2), 1, 0, 0 ,0]);
end
h2 = plot(sim_datenum, monthly(:,3), '-', 'color', [100 149 237]/255,  'Linewidth', line_width); hold on; 
h1 = plot(sim_datenum, monthly(:,4), '-', 'color', [205 92 92]/255,  'Linewidth', line_width); hold on; 


xlabel('Date (MM/YY)', 'FontSize', label_size); 
ylabel('Streamflow (m^3/s)', 'FontSize', label_size);
set(gca,'FontSize',tick_size);
xlim([sim_datenum(1) sim_datenum(end)]);
NumTicks = 10;
L = get(gca,'XLim'); set(gca,'XTick',linspace(L(1),L(2),NumTicks))
datetick('x','mm/yy','keeplimits', 'keepticks'); 
title('(c): Monthly Scale', 'FontSize', title_size); 

grid on;
box on;







subplot(2,2,4)


sim_datenum = nan(size(annually,1),1);
for i = 1:size(annually,1)
    sim_datenum(i,1) = datenum([annually(i,1), 12, 31, 0, 0 ,0]);
end
h2 = plot(sim_datenum, annually(:,2), '-', 'color', [100 149 237]/255,  'Linewidth', line_width); hold on; 
h1 = plot(sim_datenum, annually(:,3), '-', 'color', [205 92 92]/255,  'Linewidth', line_width); hold on; 


xlabel('Date (YY)', 'FontSize', label_size); 
ylabel('Streamflow (m^3/s)', 'FontSize', label_size);
set(gca,'FontSize',tick_size);
xlim([sim_datenum(1) sim_datenum(end)]);
NumTicks = 10;
L = get(gca,'XLim'); set(gca,'XTick',linspace(L(1),L(2),NumTicks))
datetick('x','yy','keeplimits', 'keepticks'); 
title('(d): Annually Scale', 'FontSize', title_size); 

grid on;
box on;


%% plot one figure for the top 5% quantiles 
scatter_size = 40; label_size = 14; legend_size = 14; tick_size = 14; colorbar_size= 14;title_size = 14;
common_daily_monthly = nan(464, 5); % 1-basin ID, 2-lat, 3-lon, 4-cluster, 5-percent rate
data = readtable('./flow_metrics/OUT_D_RMSE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;

temp = nan(464, 2); %1-basin id; 2-top5% quantile
temp(:,1) = cluster;

for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    temp(i,2) = quantile95;
    
    
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.2
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        daily_top5_index = nan(464, length(index)+5);
    end
    
    daily_top5_index(i,1:length(index)) = index;
end

temp = nan(464, 2); %1-basin id; 2-top5% quantile
temp(:,1) = cluster;
data = readtable('./flow_metrics/OUT_M_RMSE.csv'); 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
        temp(i,2) = quantile95;
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.2
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        monthly_top5_index = nan(464, length(index)+5);
    end
    
    monthly_top5_index(i,1:length(index)) = index;
end
for i = 1:464
    if common_daily_monthly(i,5)~=-9999
        common_index = intersect(daily_top5_index(i,:),monthly_top5_index(i,:));
        common_daily_monthly(i,5) = length(common_index)/sum(~isnan(monthly_top5_index(i,:)));
    else
        common_daily_monthly(i,5)=nan;
    end
end


metric_daily = common_daily_monthly(:,5)*100;
fmt = {'o','^','v','s','>','h','<'}; cluster_ID = cluster;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

cluster=1;h1 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=2;h2 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=3;h3 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=4;h4 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=5;h5 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=6;h6 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=7;h7 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;

c = colorbar; caxis([0 100]);  colormap(brewermap([],'*RdBu'));    
c.FontSize = colorbar_size;
set(gca,'FontSize',tick_size);
x1=get(gca,'position');
x=get(c,'Position');
x(3)=0.02;
set(c,'Position',x)
set(gca,'position',x1)


plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('Daily and Monthly RMSE', 'FontSize', title_size);
box on; 

l = legend([h1, h2, h3, h4, h5, h6, h7], {'1', '2', '3', '4', '5', '6','7'});
set(l,'FontSize',legend_size, 'Location','southwest','Orientation','horizontal'); 
htitle = get(l,'Title');
set(htitle,'String','Cluster', 'FontSize', legend_size);
legend boxoff
htitle.NodeChildren.Position = [0.1 0.752577319650977 0] ;         

set(gca,'color',[240 240 240]/255)





%% plot matrix for the overlapped probabilities using cluster regional median
matrix = nan(10, 10, 7);  % row and column order: D-KGE, D-NSE, D-RMSE, D-MAE, D-TRMSE, M-KGE, M-NSE, M-RMSE, M-MAE, M-TRMSE; 7-7clusters

for cluster_ID = 1:7


    
var1_name = {'D_KGE', 'D_NSE', 'D_RMSE', 'D_MAE', 'D_TRMSE', 'M_KGE', 'M_NSE', 'M_RMSE', 'M_MAE', 'M_TRMSE'};
var2_name = {'D_KGE', 'D_NSE', 'D_RMSE', 'D_MAE', 'D_TRMSE', 'M_KGE', 'M_NSE', 'M_RMSE', 'M_MAE', 'M_TRMSE'};

for row = 1:10
    for col = 1:10
        
        data = readtable(sprintf('./flow_metrics/OUT_%s.csv', string(var1_name(row)))); 
        basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
        common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
        ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
        if row == 1 || row == 2 || row == 6 || row == 7
            ensemble = ensemble;
        else
            ensemble = -ensemble;
        end
        for i = 1:464
            quantile95 = quantile(ensemble(i,:), 0.95);
            if isnan(quantile95)
                common_daily_monthly(i, 5) = -9999;
                continue
            end
            index = find(ensemble(i,:) >= quantile95);
            if length(index) > size(ensemble,2)*0.1
                common_daily_monthly(i, 5) = -9999;
                continue
            end
            if i ==1
                daily_top5_index = nan(464, length(index)+5);
            end

            daily_top5_index(i,1:length(index)) = index;
        end

        data = readtable(sprintf('./flow_metrics/OUT_%s.csv', string(var2_name(col)))); 
        ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
        if col == 1 || col == 2 || col == 6 || col == 7
            ensemble = ensemble;
        else
            ensemble = -ensemble;
        end
        for i = 1:464
            quantile95 = quantile(ensemble(i,:), 0.95);
            if isnan(quantile95)
                common_daily_monthly(i, 5) = -9999;
                continue
            end
            index = find(ensemble(i,:) >= quantile95);
            if length(index) > size(ensemble,2)*0.1
                common_daily_monthly(i, 5) = -9999;
                continue
            end
            if i ==1
                monthly_top5_index = nan(464, length(index)+5);
            end

            monthly_top5_index(i,1:length(index)) = index;
        end
        for i = 1:464
            if common_daily_monthly(i,5)~=-9999
                common_index = intersect(daily_top5_index(i,:),monthly_top5_index(i,:));
                common_daily_monthly(i,5) = length(common_index)/sum(~isnan(monthly_top5_index(i,:)));
            else
                common_daily_monthly(i,5)=nan;
            end
        end


        metric_daily = common_daily_monthly(:,5)*100;
        matrix(row,col,cluster_ID) = median(metric_daily(cluster==cluster_ID));


    end
end
end



%% plot the matrix here
label_size = 10; line_width = 1; tick_size = 11; legend_size = 10; box_width = 0.5;
title_size = 10; tick_size = 10; text_size = 12; scatter_size = 20; colorbar_size= 10;
title_text = {'Cluster 1-Northeast', 'Cluster 2-Pacific','Cluster 3-AZ/NM','Cluster 4-Rockies','Cluster 5-Great Plains',...
    'Cluster 6-Great Lakes','Cluster 7-Southeast'};
for cluster = 1:7
    
subplot(3,3,cluster)

matrix1(:,:) = matrix(:,:,cluster);
imagesc(matrix1 ); hold on; 
% h = colorbar; 
caxis([0 100]);  colormap(brewermap([],'*RdBu'));   

x=1:10; xticks(x)
xticklabels({'D-KGE','D-NSE','D-RMSE','D-MAE','D-TRMSE','M-KGE','M-NSE', 'M-RMSE', 'M-MAE', 'M-TRMSE'})

y=1:10; yticks(y)
yticklabels({'D-KGE','D-NSE','D-RMSE','D-MAE','D-TRMSE','M-KGE','M-NSE', 'M-RMSE', 'M-MAE', 'M-TRMSE'})

xtickangle(90)
% add outline
for i = 0.5:1:10.5
    line([0,12], [i i], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

for i = 0.5:1:10.5
    line([i i], [0, 12], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

line([5.5 5.5], [0, 12], 'color',[0 0 0]/255,  'Linewidth', line_width+3, 'LineStyle','-' ); hold on;  
line([0 12], [5.5 5.5], 'color',[0 0 0]/255,  'Linewidth', line_width+3, 'LineStyle','-' ); hold on;  

set(gca,'FontSize',tick_size);
set(gca,'color',[240 240 240]/255)

title(sprintf('%s', string(title_text{cluster})), 'FontSize', title_size);


end

% h = colorbar; ylabel(h, 'Overlap Percentage', 'FontSize', label_size);
% set(gca,'YDir','normal')
% ylabel('Basin Number', 'FontSize', label_size); 
% xlabel('Parameter Number', 'FontSize', label_size); 
% xticks(1:15);






%% find the common top 5 quantiles indexes between daily and monthly for 3
% metrics; same metrics but different temporal scales

common_daily_monthly = nan(464, 5); % 1-basin ID, 2-lat, 3-lon, 4-cluster, 5-percent rate

subplot(2,2,1)
data = readtable('./flow_metrics/OUT_D_KGE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        daily_top5_index = nan(464, length(index)+5);
    end
    
    daily_top5_index(i,1:length(index)) = index;
end

data = readtable('./flow_metrics/OUT_M_KGE.csv'); 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        monthly_top5_index = nan(464, length(index)+5);
    end
    
    monthly_top5_index(i,1:length(index)) = index;
end

for i = 1:464
    if common_daily_monthly(i,5)~=-9999
        common_index = intersect(daily_top5_index(i,:),monthly_top5_index(i,:));
        common_daily_monthly(i,5) = length(common_index)/sum(~isnan(monthly_top5_index(i,:)));
    else
        common_daily_monthly(i,5)=nan;
    end
end




metric_daily = common_daily_monthly(:,5);
fmt = {'o','^','v','s','>','h','<'}; cluster_ID = cluster;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

cluster=1;h1 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=2;h2 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=3;h3 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=4;h4 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=5;h5 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=6;h6 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=7;h7 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(a) Daily and Monthly KGE', 'FontSize', title_size);
box on; 

l = legend([h1, h2, h3, h4, h5, h6, h7], {'1', '2', '3', '4', '5', '6','7'});
set(l,'FontSize',legend_size, 'Location','southwest','Orientation','horizontal'); 
htitle = get(l,'Title');
set(htitle,'String','Cluster', 'FontSize', legend_size);
legend boxoff
htitle.NodeChildren.Position = [0.1 0.752577319650977 0] ;   
l.ItemTokenSize(1) = 18;    



subplot(2,2,2)
data = readtable('./flow_metrics/OUT_D_RMSE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        daily_top5_index = nan(464, length(index)+5);
    end
    
    daily_top5_index(i,1:length(index)) = index;
end

data = readtable('./flow_metrics/OUT_M_RMSE.csv'); 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        monthly_top5_index = nan(464, length(index)+5);
    end
    
    monthly_top5_index(i,1:length(index)) = index;
end
for i = 1:464
    if common_daily_monthly(i,5)~=-9999
        common_index = intersect(daily_top5_index(i,:),monthly_top5_index(i,:));
        common_daily_monthly(i,5) = length(common_index)/sum(~isnan(monthly_top5_index(i,:)));
    else
        common_daily_monthly(i,5)=nan;
    end
end


metric_daily = common_daily_monthly(:,5);
fmt = {'o','^','v','s','>','h','<'}; cluster_ID = cluster;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(b) Daily and Monthly RMSE', 'FontSize', title_size);
box on; 



subplot(2,2,3)
data = readtable('./flow_metrics/OUT_D_MAE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        daily_top5_index = nan(464, length(index)+5);
    end
    
    daily_top5_index(i,1:length(index)) = index;
end

data = readtable('./flow_metrics/OUT_M_MAE.csv'); 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        monthly_top5_index = nan(464, length(index)+5);
    end
    
    monthly_top5_index(i,1:length(index)) = index;
end
for i = 1:464
    if common_daily_monthly(i,5)~=-9999
        common_index = intersect(daily_top5_index(i,:),monthly_top5_index(i,:));
        common_daily_monthly(i,5) = length(common_index)/sum(~isnan(monthly_top5_index(i,:)));
    else
        common_daily_monthly(i,5)=nan;
    end
end


metric_daily = common_daily_monthly(:,5);
fmt = {'o','^','v','s','>','h','<'}; cluster_ID = cluster;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(c) Daily and Monthly MAE', 'FontSize', title_size);
box on; 





subplot(2,2,4)
data = readtable('./flow_metrics/OUT_D_TRMSE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        daily_top5_index = nan(464, length(index)+5);
    end
    
    daily_top5_index(i,1:length(index)) = index;
end

data = readtable('./flow_metrics/OUT_M_TRMSE.csv'); 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        monthly_top5_index = nan(464, length(index)+5);
    end
    
    monthly_top5_index(i,1:length(index)) = index;
end
for i = 1:464
    if common_daily_monthly(i,5)~=-9999
        common_index = intersect(daily_top5_index(i,:),monthly_top5_index(i,:));
        common_daily_monthly(i,5) = length(common_index)/sum(~isnan(monthly_top5_index(i,:)));
    else
        common_daily_monthly(i,5)=nan;
    end
end


metric_daily = common_daily_monthly(:,5);
fmt = {'o','^','v','s','>','h','<'}; cluster_ID = cluster;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(d) Daily and Monthly TRMSE', 'FontSize', title_size);
box on; 



































% plot the ensmebles  
% subplot(2,1,1)
% sim_datenum = nan(size(daily,1),1);
% for i = 1:size(daily,1)
%     sim_datenum(i,1) = datenum([daily(i,1), daily(i,2), daily(i,3), 0, 0 ,0]);
% end
% 
% for i = 1:size(daily_ensemble,2)
%     if i ==1
%        h3 = plot(sim_datenum, daily_ensemble(:,i), '-', 'color', [211 211 211]/255,  'Linewidth', line_width/2); hold on; 
%     else
%         plot(sim_datenum, daily_ensemble(:,i), '-', 'color', [211 211 211]/255,  'Linewidth', line_width/2); hold on; 
%     end
% end
% 
% for i = 1:size(daily_ensemble,2)
%     if ismember(i, daily_top5_index)
%         h4 = plot(sim_datenum, daily_ensemble(:,i), '-', 'color', [255 140 0]/255,  'Linewidth', line_width/2); hold on; 
%     end
% end
% 
% 
% h2 = plot(sim_datenum, daily(:,4), '-', 'color', [100 149 237]/255,  'Linewidth', line_width/2); hold on; 
% h1 = plot(sim_datenum, daily(:,5), '-', 'color', [205 92 92]/255,  'Linewidth', line_width/2); hold on; 
% 
% ylim([0,50]);
% 
% l = legend([h1, h2, h3, h4], {'Obs.', 'Sim.', 'Ensemble', 'Top 5% Quantiles'});
% set(l,'FontSize',legend_size, 'Location','northwest','Orientation','horizontal'); 
% % legend boxoff
% grid on;
% box on;
% 
% 
% xlabel('Date (MM/YY)', 'FontSize', label_size); 
% ylabel('Streamflow (m^3/s)', 'FontSize', label_size);
% set(gca,'FontSize',tick_size);
% xlim([sim_datenum(1) sim_datenum(end)]);
% NumTicks = 10;
% L = get(gca,'XLim'); set(gca,'XTick',linspace(L(1),L(2),NumTicks))
% datetick('x','mm/yy','keeplimits', 'keepticks'); 
% title('(a) Daily Scale: Basin 09065500', 'FontSize', title_size); 
% 
% 
% subplot(2,1,2)
% sim_datenum = nan(size(monthly,1),1);
% for i = 1:size(monthly,1)
%     sim_datenum(i,1) = datenum([monthly(i,1), monthly(i,2), 1, 0, 0 ,0]);
% end
% 
% for i = 1:size(monthly_ensemble,2)
%     if i ==1
%        h3 = plot(sim_datenum, monthly_ensemble(:,i), '-', 'color', [100 149 237]/255,  'Linewidth', line_width/2); hold on; 
%     else
%         plot(sim_datenum, monthly_ensemble(:,i), '-', 'color', [211 211 211]/255,  'Linewidth', line_width/2); hold on; 
%     end
% end
% 
% for i = 1:size(monthly_ensemble,2)
%     if ismember(i, daily_top5_index)
%         h4 = plot(sim_datenum, monthly_ensemble(:,i), '-', 'color', [255 140 0]/255,  'Linewidth', line_width/2); hold on; 
%     end
% end
% ylim([0,10]);
% 
% 
% h2 = plot(sim_datenum, monthly(:,3), '-', 'color', [100 149 237]/255,  'Linewidth', line_width/2); hold on; 
% h1 = plot(sim_datenum, monthly(:,4), '-', 'color', [205 92 92]/255,  'Linewidth', line_width/2); hold on; 
% 
% xlabel('Date (MM/YY)', 'FontSize', label_size); 
% ylabel('Streamflow (m^3/s)', 'FontSize', label_size);
% set(gca,'FontSize',tick_size);
% xlim([sim_datenum(1) sim_datenum(end)]);
% NumTicks = 10;
% L = get(gca,'XLim'); set(gca,'XTick',linspace(L(1),L(2),NumTicks))
% datetick('x','mm/yy','keeplimits', 'keepticks'); 
% title('(b) Monthly Scale: Basin 09065500', 'FontSize', title_size);
% 
% 











%% find the common top 5 quantiles indexes between different metrics at the same temporal scale
common_daily_monthly = nan(464, 5); % 1-basin ID, 2-lat, 3-lon, 4-cluster, 5-percent rate

subplot(2,2,1)
data = readtable('./flow_metrics/OUT_D_KGE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        daily_top5_index = nan(464, length(index)+5);
    end
    
    daily_top5_index(i,1:length(index)) = index;
end

data = readtable('./flow_metrics/OUT_D_RMSE.csv'); 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        monthly_top5_index = nan(464, length(index)+5);
    end
    
    monthly_top5_index(i,1:length(index)) = index;
end
for i = 1:464
    if common_daily_monthly(i,5)~=-9999
        common_index = intersect(daily_top5_index(i,:),monthly_top5_index(i,:));
        common_daily_monthly(i,5) = length(common_index)/sum(~isnan(monthly_top5_index(i,:)));
    else
        common_daily_monthly(i,5)=nan;
    end
end


metric_daily = common_daily_monthly(:,5);
fmt = {'o','^','v','s','>','h','<'}; cluster_ID = cluster;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

cluster=1;h1 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=2;h2 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=3;h3 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=4;h4 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=5;h5 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=6;h6 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=7;h7 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(a) Daily: KGE and RMSE', 'FontSize', title_size);
box on; 

l = legend([h1, h2, h3, h4, h5, h6, h7], {'1', '2', '3', '4', '5', '6','7'});
set(l,'FontSize',legend_size, 'Location','southwest','Orientation','horizontal'); 
htitle = get(l,'Title');
set(htitle,'String','Cluster', 'FontSize', legend_size);
legend boxoff
htitle.NodeChildren.Position = [0.1 0.752577319650977 0] ;   
l.ItemTokenSize(1) = 18;        




subplot(2,2,2)
data = readtable('./flow_metrics/OUT_D_KGE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        daily_top5_index = nan(464, length(index)+5);
    end
    
    daily_top5_index(i,1:length(index)) = index;
end

data = readtable('./flow_metrics/OUT_D_MAE.csv'); 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -ensemble;
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        monthly_top5_index = nan(464, length(index)+5);
    end
    
    monthly_top5_index(i,1:length(index)) = index;
end
for i = 1:464
    if common_daily_monthly(i,5)~=-9999
        common_index = intersect(daily_top5_index(i,:),monthly_top5_index(i,:));
        common_daily_monthly(i,5) = length(common_index)/sum(~isnan(monthly_top5_index(i,:)));
    else
        common_daily_monthly(i,5)=nan;
    end
end


metric_daily = common_daily_monthly(:,5);
fmt = {'o','^','v','s','>','h','<'}; cluster_ID = cluster;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(b) Daily KGE and MAE', 'FontSize', title_size);
box on; 







subplot(2,2,3)
data = readtable('./flow_metrics/OUT_D_KGE.csv');
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        daily_top5_index = nan(464, length(index)+5);
    end
    
    daily_top5_index(i,1:length(index)) = index;
end

data = readtable('./flow_metrics/OUT_D_TRMSE.csv'); 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -(ensemble);
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        monthly_top5_index = nan(464, length(index)+5);
    end
    
    monthly_top5_index(i,1:length(index)) = index;
end
for i = 1:464
    if common_daily_monthly(i,5)~=-9999
        common_index = intersect(daily_top5_index(i,:),monthly_top5_index(i,:));
        common_daily_monthly(i,5) = length(common_index)/sum(~isnan(monthly_top5_index(i,:)));
    else
        common_daily_monthly(i,5)=nan;
    end
end


metric_daily = common_daily_monthly(:,5);
fmt = {'o','^','v','s','>','h','<'}; cluster_ID = cluster;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(c) Daily: KGE and TRMSE', 'FontSize', title_size);
box on; 







subplot(2,2,4)
data = readtable('./flow_metrics/OUT_D_RMSE.csv'); 
basin_id = data.Var1; lat = data.Var2; lon = data.Var3; cluster = data.Var4; 
common_daily_monthly(:,1) = basin_id; common_daily_monthly(:,2) = lat; common_daily_monthly(:,3) = lon; common_daily_monthly(:,4) = cluster; 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -abs(ensemble);
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        daily_top5_index = nan(464, length(index)+5);
    end
    
    daily_top5_index(i,1:length(index)) = index;
end

data = readtable('./flow_metrics/OUT_D_TRMSE.csv'); 
ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
ensemble = -(ensemble);
for i = 1:464
    quantile95 = quantile(ensemble(i,:), 0.95);
    if isnan(quantile95)
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    index = find(ensemble(i,:) >= quantile95);
    if length(index) > size(ensemble,2)*0.1
        common_daily_monthly(i, 5) = -9999;
        continue
    end
    if i ==1
        monthly_top5_index = nan(464, length(index)+5);
    end
    
    monthly_top5_index(i,1:length(index)) = index;
end
for i = 1:464
    if common_daily_monthly(i,5)~=-9999
        common_index = intersect(daily_top5_index(i,:),monthly_top5_index(i,:));
        common_daily_monthly(i,5) = length(common_index)/sum(~isnan(monthly_top5_index(i,:)));
    else
        common_daily_monthly(i,5)=nan;
    end
end


metric_daily = common_daily_monthly(:,5);
fmt = {'o','^','v','s','>','h','<'}; cluster_ID = cluster;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(d) Daily RMSE and TRMSE', 'FontSize', title_size);
box on; 



%% plot 1 spatial plot

data = readtable('./flow_metrics/default_monthly_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_daily = data.Var4;

scatter(lon, lat, 15, metric_daily); hold on;
colormap(jet(50)); hcbar = colorbar; %caxis([-100 100]);

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');


xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 




%% plot 2x2
subplot(2,2,1)
label_size = 12; line_width = 1; tick_size = 11; legend_size = 12; box_width = 0.5;
title_size = 10; tick_size = 12; text_size = 12; scatter_size = 50; colorbar_size= 10;
data = readtable('./flow_metrics/default_monthly_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_daily = data.Var7;
fmt = {'o','^','v','s','>','h','<'};
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

cluster=1;h1 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=2;h2 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=3;h3 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=4;h4 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=5;h5 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=6;h6 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=7;h7 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;

c = colorbar; caxis([-1 0.8]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(a) Monthly Flow: KGE', 'FontSize', title_size);
box on; 

l = legend([h1, h2, h3, h4, h5, h6, h7], {'1', '2', '3', '4', '5', '6','7'});
set(l,'FontSize',legend_size, 'Location','southwest','Orientation','horizontal'); 
htitle = get(l,'Title');
set(htitle,'String','Cluster', 'FontSize', legend_size);
legend boxoff
htitle.NodeChildren.Position = [0.1 0.752577319650977 0] ;         


subplot(2,2,2)
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_daily = data.Var41;
fmt = {'o','^','v','s','>','h','<'};
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([-200 200]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(b) Monthly Flow: Variance Bias (%)', 'FontSize', title_size);
box on; 


subplot(2,2,3)
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_daily = data.Var54;
fmt = {'o','^','v','s','>','h','<'};
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([-200 200]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(c) Monthly Flow: FDC Slope Bias (%)', 'FontSize', title_size);
box on; 



subplot(2,2,4)
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_daily = data.Var55;
fmt = {'o','^','v','s','>','h','<'};
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar;  colormap((jet(50)));  caxis([1 20]); 
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(d) Monthly Flow: E50 of Squared Error (months)', 'FontSize', title_size);
box on; 






%% plot 2x2 box plot for 4 hydrolgic metrics
subplot(2,2,1)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.lat; lon = data.lon; cluster_ID = data.cluster_id;
metric_daily = data.KGE; 
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/default_weekly_metrics.csv');
metric_weekly = data.Var7; 

data = readtable('./flow_metrics/default_monthly_metrics.csv');
metric_monthly = data.KGE; 


h1 = boxplot(metric_daily, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('KGE', 'FontSize', label_size); 
ylim([-5 1]); box on;


delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_weekly, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})

x3 = x2 + delta;
h3=boxplot(metric_monthly, cluster_ID, 'positions', x3, 'width', box_width); hold on;
set(h3,{'linew'},{line_width+1})

color1 = [100 149 237]/255;
color2 = [165 42 42]/255;
color3 = [34 139 34]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end
    if j>14 && j<=21
        patch(get(h(j),'XData'),get(h(j),'YData'),color3,'FaceAlpha',0.5);
    end    
end
ylim([-5 1]); box on;
xlim([0,max(x3)+1]);


c = get(gca, 'Children');
[hh, hleg1] = legend([c(1) c(8) c(20)],   'Daily', 'Weekly', 'Monthly'); 
set(hh,'FontSize',legend_size, 'Location','southwest','Orientation','vertical');

grid on;
legend boxoff;
PatchInLegend = findobj(hleg1, 'type', 'patch');
set(PatchInLegend(1), 'FaceAlpha', 0.5);
set(PatchInLegend(2), 'FaceAlpha', 0.5);
set(PatchInLegend(3), 'FaceAlpha', 0.5);

xticks(x2)
xticklabels({'1','2','3','4','5','6','7'})

title('(a)', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);




subplot(2,2,2)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.lat; lon = data.lon; cluster_ID = data.cluster_id;
metric_daily = data.variance_bias; 
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/default_weekly_metrics.csv');
metric_weekly = data.Var41; 

data = readtable('./flow_metrics/default_monthly_metrics.csv');
metric_monthly = data.variance_bias; 


h1 = boxplot(metric_daily, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Variance Bias (%)', 'FontSize', label_size); 
ylim([-5 1]); box on;


delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_weekly, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})

x3 = x2 + delta;
h3=boxplot(metric_monthly, cluster_ID, 'positions', x3, 'width', box_width); hold on;
set(h3,{'linew'},{line_width+1})

color1 = [100 149 237]/255;
color2 = [165 42 42]/255;
color3 = [34 139 34]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end
    if j>14 && j<=21
        patch(get(h(j),'XData'),get(h(j),'YData'),color3,'FaceAlpha',0.5);
    end    
end
ylim([-100 1000]); box on;
xlim([0,max(x3)+1]);

xticks(x2)
xticklabels({'1','2','3','4','5','6','7'})

grid on;
set(gca,'FontSize',tick_size);

title('(b)', 'FontSize', title_size); 





subplot(2,2,3)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.lat; lon = data.lon; cluster_ID = data.cluster_id;
metric_daily = data.FDC_slope_bias; 
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/default_weekly_metrics.csv');
metric_weekly = data.Var54; 

data = readtable('./flow_metrics/default_monthly_metrics.csv');
metric_monthly = data.FDC_slope_bias; 


h1 = boxplot(metric_daily, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('FDC Slope Bias (%)', 'FontSize', label_size); 
ylim([-5 1]); box on;


delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_weekly, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})

x3 = x2 + delta;
h3=boxplot(metric_monthly, cluster_ID, 'positions', x3, 'width', box_width); hold on;
set(h3,{'linew'},{line_width+1})

color1 = [100 149 237]/255;
color2 = [165 42 42]/255;
color3 = [34 139 34]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end
    if j>14 && j<=21
        patch(get(h(j),'XData'),get(h(j),'YData'),color3,'FaceAlpha',0.5);
    end    
end
ylim([-100 1000]); box on;
xlim([0,max(x3)+1]);

xticks(x2)
xticklabels({'1','2','3','4','5','6','7'})

grid on;
set(gca,'FontSize',tick_size);

title('(c)', 'FontSize', title_size);




subplot(2,2,4)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.lat; lon = data.lon; cluster_ID = data.cluster_id;
metric_daily = data.E50; 
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/default_weekly_metrics.csv');
metric_weekly = data.Var55; 

data = readtable('./flow_metrics/default_monthly_metrics.csv');
metric_monthly = data.E50; 


h1 = boxplot(metric_daily, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('E50 of Squared Error', 'FontSize', label_size); 
ylim([-5 1]); box on;


delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_weekly, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})

x3 = x2 + delta;
h3=boxplot(metric_monthly, cluster_ID, 'positions', x3, 'width', box_width); hold on;
set(h3,{'linew'},{line_width+1})

color1 = [100 149 237]/255;
color2 = [165 42 42]/255;
color3 = [34 139 34]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end
    if j>14 && j<=21
        patch(get(h(j),'XData'),get(h(j),'YData'),color3,'FaceAlpha',0.5);
    end    
end
ylim([0 100]); box on;
xlim([0,max(x3)+1]);

xticks(x2)
xticklabels({'1','2','3','4','5','6','7'})

grid on;
set(gca,'FontSize',tick_size);

title('(d)', 'FontSize', title_size);









%% plot regional (old ,not used)

data = readtable('./flow_metrics/default_monthly_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4;
metric_daily = data.Var40;
bin = 50; talpha = 0.5;


subplot(3,3,1)
metric1 = metric_daily(cluster==1);
[f,x] = ecdf(metric1);
h1 = plot(f,x, 'color',[70	130	180]/255,  'Linewidth',line_width+1 ); hold on;
Median_value = median(metric1);
line([0,0.5],[Median_value, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
line([0.5,0.5],[-100, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
h2 = scatter(0.5, Median_value,  80, 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor',[178 34 34]/255, 'LineWidth',1); hold on;
xlim([0,1]);
ylim([-100, 100]);
l = legend([h1, h2], {'Cluster CDF', 'Median'});
set(l,'FontSize',legend_size, 'Location','southeast'); 
legend boxoff
grid on; box on;
xlabel('Nonexceedance Probability', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size);
title('(a): Cluster 1', 'FontSize', title_size); 



% h1 = histogram(metric1, bin, 'FaceColor', [0 0 1], 'EdgeColor', [0 0 0], 'FaceAlpha', talpha); hold on;
% YL = get(gca, 'YLim');
% xlim([min(metric1), max(metric1)]);
% h2 = line([Median_value,Median_value],[YL(1),YL(2) ], 'color',[ 0.6350 0.0780 0.1840],  'Linewidth',line_width+1 , 'LineStyle', '--'); hold on;
% xlabel('Flow Volume Bias (%)', 'FontSize', label_size); 
% ylabel('Frequency', 'FontSize', label_size); 
% title('(a): Cluster 1', 'FontSize', title_size); 
% l = legend([h1, h2], {'Histogram', 'Median'});
% set(l,'FontSize',legend_size, 'Location','northwest'); 
% legend boxoff
% grid on; box on;




subplot(3,3,2)
metric1 = metric_daily(cluster==2);
[f,x] = ecdf(metric1);
h1 = plot(f,x, 'color',[70	130	180]/255,  'Linewidth',line_width+1 ); hold on;
Median_value = median(metric1);
line([0,0.5],[Median_value, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
line([0.5,0.5],[-100, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
h2 = scatter(0.5, Median_value,  80, 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor',[178 34 34]/255, 'LineWidth',1); hold on;
xlim([0,1]);
ylim([-100, 100]);
grid on; box on;
xlabel('Nonexceedance Probability', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size);
title('(b): Cluster 2', 'FontSize', title_size); 


subplot(3,3,3)
metric1 = metric_daily(cluster==3);
[f,x] = ecdf(metric1);
h1 = plot(f,x, 'color',[70	130	180]/255,  'Linewidth',line_width+1 ); hold on;
Median_value = median(metric1);
line([0,0.5],[Median_value, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
line([0.5,0.5],[-100, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
h2 = scatter(0.5, Median_value,  80, 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor',[178 34 34]/255, 'LineWidth',1); hold on;
xlim([0,1]);
ylim([-50, 300]);
grid on; box on;
xlabel('Nonexceedance Probability', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size);
title('(c): Cluster 3', 'FontSize', title_size); 


subplot(3,3,4)
metric1 = metric_daily(cluster==4);
[f,x] = ecdf(metric1);
h1 = plot(f,x, 'color',[70	130	180]/255,  'Linewidth',line_width+1 ); hold on;
Median_value = median(metric1);
line([0,0.5],[Median_value, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
line([0.5,0.5],[-100, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
h2 = scatter(0.5, Median_value,  80, 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor',[178 34 34]/255, 'LineWidth',1); hold on;
xlim([0,1]);
ylim([-50, 300]);
grid on; box on;
xlabel('Nonexceedance Probability', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size);
title('(d): Cluster 4', 'FontSize', title_size); 


subplot(3,3,5)
metric1 = metric_daily(cluster==5);
[f,x] = ecdf(metric1);
h1 = plot(f,x, 'color',[70	130	180]/255,  'Linewidth',line_width+1 ); hold on;
Median_value = median(metric1);
line([0,0.5],[Median_value, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
line([0.5,0.5],[-100, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
h2 = scatter(0.5, Median_value,  80, 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor',[178 34 34]/255, 'LineWidth',1); hold on;
xlim([0,1]);
ylim([0, 500]);
grid on; box on;
xlabel('Nonexceedance Probability', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size);
title('(e): Cluster 5', 'FontSize', title_size); 

subplot(3,3,6)
metric1 = metric_daily(cluster==6);
[f,x] = ecdf(metric1);
h1 = plot(f,x, 'color',[70	130	180]/255,  'Linewidth',line_width+1 ); hold on;
Median_value = median(metric1);
line([0,0.5],[Median_value, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
line([0.5,0.5],[-100, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
h2 = scatter(0.5, Median_value,  80, 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor',[178 34 34]/255, 'LineWidth',1); hold on;
xlim([0,1]);
ylim([-50, 100]);
grid on; box on;
xlabel('Nonexceedance Probability', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size);
title('(f): Cluster 6', 'FontSize', title_size); 

subplot(3,3,7)
metric1 = metric_daily(cluster==7);
[f,x] = ecdf(metric1);
h1 = plot(f,x, 'color',[70	130	180]/255,  'Linewidth',line_width+1 ); hold on;
Median_value = median(metric1);
line([0,0.5],[Median_value, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
line([0.5,0.5],[-100, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
h2 = scatter(0.5, Median_value,  80, 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor',[178 34 34]/255, 'LineWidth',1); hold on;
xlim([0,1]);
ylim([-50, 100]);
grid on; box on;
xlabel('Nonexceedance Probability', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size);
title('(g): Cluster 7', 'FontSize', title_size); 


subplot(3,3,8)
scatter(lon, lat, 15, cluster_ID, 'filled'); hold on; 
colormap(jet(7)); c = colorbar; colorbar('FontSize',colorbar_size)
xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size);
title('(h): Cluster ID', 'FontSize', title_size); 
box on;
plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');


subplot(3,3,9)
metric1 = metric_daily;
[f,x] = ecdf(metric1);
h1 = plot(f,x, 'color',[70	130	180]/255,  'Linewidth',line_width+1 ); hold on;
Median_value = median(metric1);
line([0,0.5],[Median_value, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
line([0.5,0.5],[-100, Median_value], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
h2 = scatter(0.5, Median_value,  80, 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor',[178 34 34]/255, 'LineWidth',1); hold on;
xlim([0,1]);
ylim([-100, 100]);
grid on; box on;
xlabel('Nonexceedance Probability', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size);
title('(i): CONUS', 'FontSize', title_size); 





%% plot multiple spatial plot for flow ranges

data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3;
Q0_10   = data.Var42;
% Q10_25  = data.Q10_25_volume_bias;
% Q25_50  = data.Q25_50_volume_bias;
% Q50_75  = data.Q50_75_volume_bias;
% Q75_90  = data.Q75_90_volume_bias;
% Q90_100 = data.Q90_100_volume_bias;

caxis_min = -200;
caxis_max = 200;

label_size = 12; line_width = 1; tick_size = 11; legend_size = 12; box_width = 0.5;
title_size = 10; tick_size = 12; text_size = 12; scatter_size = 50; colorbar_size= 10;

subplot(2,3,1)
fmt = {'o','^','v','s','>','h','<'};
metric_daily = Q0_10;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

cluster=1;h1 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=2;h2 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=3;h3 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=4;h4 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=5;h5 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=6;h6 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=7;h7 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;

c = colorbar; caxis([caxis_min caxis_max]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(a) Quantiles 0-10%: Flow Volume Bias (%)', 'FontSize', title_size);
box on; 

l = legend([h1, h2, h3, h4, h5, h6, h7], {'1', '2', '3', '4', '5', '6','7'});
set(l,'FontSize',legend_size, 'Location','southwest','Orientation','horizontal'); 
l.ItemTokenSize(1) = 18;

htitle = get(l,'Title');
set(htitle,'String','Cluster', 'FontSize', legend_size);
legend boxoff
htitle.NodeChildren.Position = [0.05 0.752577319650977 0] ;         


subplot(2,3,2)
fmt = {'o','^','v','s','>','h','<'};
metric_daily = Q10_25;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([caxis_min caxis_max]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(b) Quantiles 10-25%: Flow Volume Bias (%)', 'FontSize', title_size);
box on; 



subplot(2,3,3)
fmt = {'o','^','v','s','>','h','<'};
metric_daily = Q25_50;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([caxis_min caxis_max]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(c) Quantiles 25-50%: Flow Volume Bias (%)', 'FontSize', title_size);
box on; 



subplot(2,3,4)
fmt = {'o','^','v','s','>','h','<'};
metric_daily = Q50_75;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([caxis_min caxis_max]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(d) Quantiles 50-75%: Flow Volume Bias (%)', 'FontSize', title_size);
box on; 


subplot(2,3,5)
fmt = {'o','^','v','s','>','h','<'};
metric_daily = Q75_90;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([caxis_min caxis_max]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(e) Quantiles 75-90%: Flow Volume Bias (%)', 'FontSize', title_size);
box on; 


subplot(2,3,6)
fmt = {'o','^','v','s','>','h','<'};
metric_daily = Q90_100;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([caxis_min caxis_max]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(f) Quantiles 90-100%: Flow Volume Bias (%)', 'FontSize', title_size);
box on; 















%% one box plot for 6 flow regimes
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
Q0_10   = data.Var42;
Q10_25  = data.Var44;
Q25_50  = data.Var46;
Q50_75  = data.Var48;
Q75_90  = data.Var50;
Q90_100 = data.Var52;


subplot(2, 3, 1)
x1 = [1, 2, 3, 4, 5, 6, 7];
h1 = boxplot(Q0_10, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 
ylim([-200 1000]); box on;
color1 = [100 149 237]/255;
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
end
title('(a) Daily Flow Quantiles 0-10%', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
grid on; box on;


subplot(2, 3, 2)
x1 = [1, 2, 3, 4, 5, 6, 7];
h1 = boxplot(Q10_25, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 
ylim([-200 1000]); box on;
color1 = [100 149 237]/255;
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
end
title('(b) Daily Flow Quantiles 10-25%', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
grid on; box on;

subplot(2, 3, 3)
x1 = [1, 2, 3, 4, 5, 6, 7];
h1 = boxplot(Q25_50, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 
ylim([-200 1000]); box on;
color1 = [100 149 237]/255;
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
end
title('(c) Daily Flow Quantiles 25-50%', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
grid on; box on;


subplot(2, 3, 4)
x1 = [1, 2, 3, 4, 5, 6, 7];
h1 = boxplot(Q50_75, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 
ylim([-200 1000]); box on;
color1 = [100 149 237]/255;
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
end
title('(d) Daily Flow Quantiles 50-75%', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
grid on; box on;

subplot(2, 3, 5)
x1 = [1, 2, 3, 4, 5, 6, 7];
h1 = boxplot(Q75_90, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 
ylim([-200 1000]); box on;
color1 = [100 149 237]/255;
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
end
title('(e) Daily Flow Quantiles 75-90%', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
grid on; box on;

subplot(2, 3, 6)
x1 = [1, 2, 3, 4, 5, 6, 7];
h1 = boxplot(Q90_100, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 
ylim([-200 1000]); box on;
color1 = [100 149 237]/255;
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
end
title('(f) Daily Flow Quantiles 90-100%', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
grid on; box on;


%% plot seasonal and annualy


data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
winter_bias  = data.Var56;
spring_bias  = data.Var57;
summer_bias  = data.Var58;
fall_bias    = data.Var59;
annual_bias  = data.Var40;

caxis_min = -200;
caxis_max = 200;

subplot(2,3,1)
fmt = {'o','^','v','s','>','h','<'};
metric_daily = winter_bias;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

cluster=1;h1 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=2;h2 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=3;h3 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=4;h4 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=5;h5 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=6;h6 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=7;h7 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;

c = colorbar; caxis([caxis_min caxis_max]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(a) Winter (DJF) Flow Volume Bias (%)', 'FontSize', title_size);
box on; 

l = legend([h1, h2, h3, h4, h5, h6, h7], {'1', '2', '3', '4', '5', '6','7'});
set(l,'FontSize',legend_size, 'Location','southwest','Orientation','horizontal'); 
l.ItemTokenSize(1) = 18;

htitle = get(l,'Title');
set(htitle,'String','Cluster', 'FontSize', legend_size);
legend boxoff
htitle.NodeChildren.Position = [0.05 0.752577319650977 0] ;         


subplot(2,3,2)
fmt = {'o','^','v','s','>','h','<'};
metric_daily = spring_bias;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([caxis_min caxis_max]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(b) Spring (MAM) Flow Volume Bias (%)', 'FontSize', title_size);
box on; 



subplot(2,3,3)
fmt = {'o','^','v','s','>','h','<'};
metric_daily = summer_bias;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([caxis_min caxis_max]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(c) Summer (JJA) Flow Volume Bias (%)', 'FontSize', title_size);
box on; 



subplot(2,3,4)
fmt = {'o','^','v','s','>','h','<'};
metric_daily = fall_bias;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([caxis_min caxis_max]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(d) Fall (SON) Flow Volume Bias (%)', 'FontSize', title_size);
box on; 


subplot(2,3,5)
fmt = {'o','^','v','s','>','h','<'};
metric_daily = annual_bias;
cluster=1; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=2; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=3; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=4; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=5; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=6; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size+16, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;
cluster=7; scatter(lon(cluster_ID==cluster), lat(cluster_ID==cluster), scatter_size, metric_daily(cluster_ID==cluster), fmt{cluster},'filled', 'MarkerEdgeColor',[105 105 105]/255, 'LineWidth',line_width-0.5); hold on;

c = colorbar; caxis([caxis_min caxis_max]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(e) Annual Flow Volume Bias (%)', 'FontSize', title_size);
box on; 











%% one box plot for 4 seasonal and annual volume bias
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
winter_bias  = data.Var56;
spring_bias  = data.Var57;
summer_bias  = data.Var58;
fall_bias    = data.Var59;
annual_bias  = data.Var40;

subplot(2, 3, 1)
x1 = [1, 2, 3, 4, 5, 6, 7];
h1 = boxplot(winter_bias, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 
ylim([-100 500]); box on;
color1 = [100 149 237]/255;
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
end
title('(a) Winter (DJF)', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
grid on; box on;
   


subplot(2, 3, 2)
x1 = [1, 2, 3, 4, 5, 6, 7];
h1 = boxplot(spring_bias, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 
ylim([-100 500]); box on;
color1 = [100 149 237]/255;
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
end
title('(b) Spring (MAM)', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
grid on; box on;



subplot(2, 3, 3)
x1 = [1, 2, 3, 4, 5, 6, 7];
h1 = boxplot(summer_bias, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 
ylim([-100 500]); box on;
color1 = [100 149 237]/255;
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
end
title('(c) Summer (JJA)', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
grid on; box on;

subplot(2, 3, 4)
x1 = [1, 2, 3, 4, 5, 6, 7];
h1 = boxplot(fall_bias, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 
ylim([-100 500]); box on;
color1 = [100 149 237]/255;
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
end
title('(d) Fall (SON)', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
grid on; box on;

subplot(2, 3, 5)
x1 = [1, 2, 3, 4, 5, 6, 7];
h1 = boxplot(annual_bias, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 
ylim([-100 500]); box on;
color1 = [100 149 237]/255;
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
end
title('(e) Annual', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
grid on; box on;









%% output the plot

fig = gcf;
fig.PaperUnits = 'inches';
set(gcf, 'InvertHardCopy', 'on');

% fig.PaperPosition = [0 0 17.7 8];
fig.PaperPosition = [0 0 4 2];
print('ScreenSizeFigure', '-dpng', '-r300')





