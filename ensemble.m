%% load all data

clear all; clc;

US = load('./us_coor.txt');
SL = load('./sl_coor.txt');

label_size = 12; line_width = 1; tick_size = 11; legend_size = 12; box_width = 0.5;
title_size = 12; tick_size = 12; text_size = 12; scatter_size = 20; colorbar_size= 12;

%% load default data
default = readtable('./flow_metrics/default_daily_metrics.csv');
daily_KGE = default.Var7;
daily_NSE = default.Var6;



%% selecting the best-performance parameter
data = readtable('./flow_metrics/OUT_D_KGE.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_id = data.Var1;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;

[best_daily_KGE, par_index] = nanmax(ensemble,[], 2);

par_index_1300 = par_index;
par_index_1500 = nan(464, 1);

success_id = load('sucessful_par_id');

for i = 1:464
    par_index_1500(i,1) = success_id(par_index_1300(i,1));
end




%% 1) estimate the exceedance probability for each basin
data = readtable('./flow_metrics/OUT_D_NSE.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;

nBasin = 464;
out = nan(nBasin, 1); 

for i = 1:nBasin
    [f,x] = ecdf(ensemble(i,:));
    d_metric = daily_NSE(i,1);    
    
    if isnan(d_metric)
        out(i,1) = nan;
    else
    
        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = 1 - d_p;
    end
end



scatter_size = 40; label_size = 14; legend_size = 14; tick_size = 14; colorbar_size= 14;title_size = 14;

metric_daily = out;
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

c = colorbar; caxis([0 1]);  colormap(brewermap([],'*RdBu'));    
c.FontSize = colorbar_size;


% c=colorbar;
x1=get(gca,'position');
x=get(c,'Position');
x(3)=0.02;
set(c,'Position',x)
set(gca,'position',x1)


% d = cbarrow('down');



plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 


title('(a) Exceedance Probability of Default Performance in Daily KGE', 'FontSize', title_size);
box on; 

l = legend([h1, h2, h3, h4, h5, h6, h7], {'1', '2', '3', '4', '5', '6','7'});
set(l,'FontSize',legend_size, 'Location','southwest','Orientation','horizontal'); 
htitle = get(l,'Title');
set(htitle,'String','Cluster', 'FontSize', legend_size);
legend boxoff
htitle.NodeChildren.Position = [0.1 0.752577319650977 0] ;         

set(gca,'color',[240 240 240]/255)


%% barplot of the regional exceedance P for daily KGE

data = readtable('./flow_metrics/OUT_D_KGE.csv'); ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
data = readtable('./flow_metrics/default_daily_metrics.csv');lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4; 
default = data.Var7;
nBasin = 464; out = nan(nBasin, 1); 
for i = 1:nBasin
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));

        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = 1-d_p;
    end
end
metric_daily = out;
median_metric = nan(7, 1);

for cluster = 1:7
    cluster_value = metric_daily(cluster_ID==cluster);
    cluster_lat = lat(cluster_ID==cluster);
    cluster_lon = lon(cluster_ID==cluster);
    cluster_id = basin_id(cluster_ID==cluster); 
    median_metric(cluster,1) = median(cluster_value);
end




scatter_size = 40; label_size = 16; legend_size = 16; tick_size = 16; colorbar_size= 14;title_size = 16;



bar(median_metric, 0.5, 'FaceColor',[169 169 169]/255,'EdgeColor',[0 0 0],'LineWidth',1.5);

xlim([0.5,7.5]); ylim([0 1]);
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Median Exceedance P', 'FontSize', label_size);
set(gca,'FontSize',tick_size);
box on; grid on;

set(gca,'color',[240 240 240]/255)








%% regional median lines of the exceeding probability
data = readtable('./flow_metrics/OUT_D_KGE.csv'); ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
data = readtable('./flow_metrics/default_daily_metrics.csv');lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4; 
default = data.Var7;
nBasin = 464; out = nan(nBasin, 1); 
for i = 1:nBasin
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));

        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = 1-d_p;
    end
end
D_KGE = out;

data = readtable('./flow_metrics/OUT_D_NSE.csv'); ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
data = readtable('./flow_metrics/default_daily_metrics.csv');lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4; 
default = data.Var6;
nBasin = 464; out = nan(nBasin, 1); 
for i = 1:nBasin
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));

        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = 1-d_p;
    end
end
D_NSE = out;

data = readtable('./flow_metrics/OUT_D_RMSE.csv'); ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
data = readtable('./flow_metrics/default_daily_metrics.csv');lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4; 
default = data.Var5;
nBasin = 464; out = nan(nBasin, 1); 
for i = 1:nBasin
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));

        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end
D_RMSE = out;

data = readtable('./flow_metrics/OUT_D_MAE.csv'); ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
data = readtable('./flow_metrics/default_daily_metrics.csv');lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4; 
default = data.Var8;
nBasin = 464; out = nan(nBasin, 1); 
for i = 1:nBasin
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));

        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end
D_MAE = out;

data = readtable('./flow_metrics/OUT_D_TRMSE.csv'); ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
data = readtable('./flow_metrics/default_daily_metrics.csv');lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4; 
default = data.Var9;
nBasin = 464; out = nan(nBasin, 1); 
for i = 1:nBasin
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));

        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end
D_TRMSE = out;




data = readtable('./flow_metrics/OUT_M_KGE.csv'); ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
data = readtable('./flow_metrics/default_monthly_metrics.csv');lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4; 
default = data.Var7;
nBasin = 464; out = nan(nBasin, 1); 
for i = 1:nBasin
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));

        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = 1-d_p;
    end
end
M_KGE = out;

data = readtable('./flow_metrics/OUT_M_NSE.csv'); ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
data = readtable('./flow_metrics/default_monthly_metrics.csv');lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4; 
default = data.Var6;
nBasin = 464; out = nan(nBasin, 1); 
for i = 1:nBasin
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));

        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = 1-d_p;
    end
end
M_NSE = out;

data = readtable('./flow_metrics/OUT_M_RMSE.csv'); ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
data = readtable('./flow_metrics/default_monthly_metrics.csv');lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4; 
default = data.Var5;
nBasin = 464; out = nan(nBasin, 1); 
for i = 1:nBasin
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));

        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end
M_RMSE = out;

data = readtable('./flow_metrics/OUT_M_MAE.csv'); ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
data = readtable('./flow_metrics/default_monthly_metrics.csv');lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4; 
default = data.Var8;
nBasin = 464; out = nan(nBasin, 1); 
for i = 1:nBasin
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));

        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end
M_MAE = out;

data = readtable('./flow_metrics/OUT_M_TRMSE.csv'); ensemble = data{:,5:end-1}; ensemble(ensemble(:)==-9999) = nan;
data = readtable('./flow_metrics/default_monthly_metrics.csv');lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4; 
default = data.Var9;
nBasin = 464; out = nan(nBasin, 1); 
for i = 1:nBasin
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));

        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end
M_TRMSE = out;


scatter_size = 40; label_size = 14; legend_size = 14; tick_size = 14; colorbar_size= 14;title_size = 14;
 marker_size = 10;
x = 1:10;
cluster= 1; 
p_metric =  [D_KGE(cluster_ID==cluster), D_NSE(cluster_ID==cluster), D_RMSE(cluster_ID==cluster),...
               D_MAE(cluster_ID==cluster), D_TRMSE(cluster_ID==cluster), M_KGE(cluster_ID==cluster),...
               M_NSE(cluster_ID==cluster), M_RMSE(cluster_ID==cluster), M_MAE(cluster_ID==cluster),...
               M_TRMSE(cluster_ID==cluster)];
h1 = plot(x, nanmedian(p_metric,1), '-s', 'MarkerSize',marker_size, 'MarkerFaceColor',[230 159 0]/255,'Color', [230 159 0]/255, 'linewidth', line_width+2); hold on; 

cluster= 2; 
p_metric =  [D_KGE(cluster_ID==cluster), D_NSE(cluster_ID==cluster), D_RMSE(cluster_ID==cluster),...
               D_MAE(cluster_ID==cluster), D_TRMSE(cluster_ID==cluster), M_KGE(cluster_ID==cluster),...
               M_NSE(cluster_ID==cluster), M_RMSE(cluster_ID==cluster), M_MAE(cluster_ID==cluster),...
               M_TRMSE(cluster_ID==cluster)];
h2 = plot(x, nanmedian(p_metric,1), '-s', 'MarkerSize',marker_size, 'MarkerFaceColor',[86 180 233]/255,'Color', [86 180 233]/255, 'linewidth', line_width+2); hold on; 

cluster= 3; 
p_metric =  [D_KGE(cluster_ID==cluster), D_NSE(cluster_ID==cluster), D_RMSE(cluster_ID==cluster),...
               D_MAE(cluster_ID==cluster), D_TRMSE(cluster_ID==cluster), M_KGE(cluster_ID==cluster),...
               M_NSE(cluster_ID==cluster), M_RMSE(cluster_ID==cluster), M_MAE(cluster_ID==cluster),...
               M_TRMSE(cluster_ID==cluster)];
h3 = plot(x, nanmedian(p_metric,1), '-s', 'MarkerSize',marker_size, 'MarkerFaceColor',[0 158 115]/255,'Color', [0 158 115]/255, 'linewidth', line_width+2); hold on; 

cluster= 4; 
p_metric =  [D_KGE(cluster_ID==cluster), D_NSE(cluster_ID==cluster), D_RMSE(cluster_ID==cluster),...
               D_MAE(cluster_ID==cluster), D_TRMSE(cluster_ID==cluster), M_KGE(cluster_ID==cluster),...
               M_NSE(cluster_ID==cluster), M_RMSE(cluster_ID==cluster), M_MAE(cluster_ID==cluster),...
               M_TRMSE(cluster_ID==cluster)];
h4 = plot(x, nanmedian(p_metric,1), '-s', 'MarkerSize',marker_size, 'MarkerFaceColor',[213 94 0]/255,'Color', [213 94 0]/255, 'linewidth', line_width+2); hold on; 

cluster= 5; 
p_metric =  [D_KGE(cluster_ID==cluster), D_NSE(cluster_ID==cluster), D_RMSE(cluster_ID==cluster),...
               D_MAE(cluster_ID==cluster), D_TRMSE(cluster_ID==cluster), M_KGE(cluster_ID==cluster),...
               M_NSE(cluster_ID==cluster), M_RMSE(cluster_ID==cluster), M_MAE(cluster_ID==cluster),...
               M_TRMSE(cluster_ID==cluster)];
h5 = plot(x, nanmedian(p_metric,1), '-s', 'MarkerSize',marker_size, 'MarkerFaceColor',[0 114 178]/255,'Color', [0 114 178]/255, 'linewidth', line_width+2); hold on; 

cluster= 6; 
p_metric =  [D_KGE(cluster_ID==cluster), D_NSE(cluster_ID==cluster), D_RMSE(cluster_ID==cluster),...
               D_MAE(cluster_ID==cluster), D_TRMSE(cluster_ID==cluster), M_KGE(cluster_ID==cluster),...
               M_NSE(cluster_ID==cluster), M_RMSE(cluster_ID==cluster), M_MAE(cluster_ID==cluster),...
               M_TRMSE(cluster_ID==cluster)];
h6 = plot(x, nanmedian(p_metric,1), '-s', 'MarkerSize',marker_size, 'MarkerFaceColor',[240 228 66]/255,'Color', [240 228 66]/255, 'linewidth', line_width+2); hold on; 

cluster= 7; 
p_metric =  [D_KGE(cluster_ID==cluster), D_NSE(cluster_ID==cluster), D_RMSE(cluster_ID==cluster),...
               D_MAE(cluster_ID==cluster), D_TRMSE(cluster_ID==cluster), M_KGE(cluster_ID==cluster),...
               M_NSE(cluster_ID==cluster), M_RMSE(cluster_ID==cluster), M_MAE(cluster_ID==cluster),...
               M_TRMSE(cluster_ID==cluster)];
h7 = plot(x, nanmedian(p_metric,1), '-s', 'MarkerSize',marker_size, 'MarkerFaceColor',[204 121 167]/255,'Color', [204 121 167]/255, 'linewidth', line_width+2); hold on; 


ylim([0, 1]);
ylabel('Exceedance Probability', 'FontSize', label_size); 
grid on;


l = legend([h1, h2, h3, h4, h5, h6, h7], {'Cluster 1-Northeast', 'Cluster 2-Pacific','Cluster 3-AZ/NM','Cluster 4-Rockies','Cluster 5-Great Plains',...
    'Cluster 6-Great Lakes','Cluster 7-Southeast'});
set(l,'FontSize',legend_size, 'Location','northwest','Orientation','vertical'); 
legend boxoff

xticks(x)
xticklabels({'D-KGE','D-NSE','D-RMSE','D-MAE','D-TRMSE','M-KGE','M-NSE', 'M-RMSE', 'M-MAE', 'M-TRMSE'})
set(gca,'FontSize',tick_size);
set(gca,'color',[240 240 240]/255)

title('Percent of Parameterizations that Exceed Default Parameters Performance', 'FontSize', title_size)























%%  plot 1 CDF for 1 basin

data = readtable('./flow_metrics/OUT_D_KGE.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_id = data.Var1;
ensemble = data{:,5:end-1};


label_size = 14; line_width = 1; tick_size = 11; legend_size = 12; box_width = 0.5;
title_size = 14; tick_size = 14; text_size = 14; scatter_size = 20; colorbar_size= 12;


index = 293;  % b cluster 2 (399); c cluster 4 (283); d cluster 1 (293); e cluster 3 (83); f cluster 5 (13); g cluster 6 (260); h cluster 7 (97)
[f,x] = ecdf(ensemble(index,:));
h1 = plot(f,x, 'color',[70	130	180]/255,  'Linewidth',line_width+1 ); hold on;
xlim([0,1]);
ylim([min(x), max(x)]);
xlabel('Nonexceedance Probability', 'FontSize', label_size); 
ylabel('KGE: Daily Flow', 'FontSize', label_size);
title(sprintf('(c) Cluster 1: Basin %08d', basin_id(index)), 'FontSize',title_size);

% plot the obs. location
d_metric = daily_KGE(index,1);
% find the nonexceeding probability
for j = 1:length(x)
    if d_metric == x(j)
        d_p = f(j);
        break
    end

    if j>1 && d_metric>x(j-1) && d_metric<x(j)
        d_p = (f(j-1) + f(j))/2;
        break
    end
end

line([0,d_p],[d_metric, d_metric], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;
line([d_p,d_p],[min(x), d_metric], 'color',[178 34 34]/255,  'Linewidth',line_width ); hold on;

h2 = scatter(d_p, d_metric,  80, 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor',[178 34 34]/255, 'LineWidth',1); hold on;
l = legend([h1, h2], {'Ensemble CDF', 'Default Performance'});
set(l,'FontSize',legend_size, 'Location','southeast'); 
legend boxoff
grid on; box on;

text(0.3, 0.6, sprintf('KGE default = %4.2f', d_metric), 'FontSize',text_size, 'Units','Normalized');
text(0.3, 0.5, sprintf('KGE best = %4.2f', nanmax(ensemble(index,:))), 'FontSize',text_size, 'Units','Normalized');
text(0.3, 0.40, sprintf('Exceedance Probability = %4.2f', 1-d_p), 'FontSize',text_size, 'Units','Normalized');
set(gca,'FontSize',tick_size);
set(gca,'color',[240 240 240]/255)

%% spatial plot for default and best performance
subplot(2,3,1)
data = readtable('./flow_metrics/default_daily_metrics.csv');
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

title('(a) Daily Flow KGE: Default', 'FontSize', title_size);
box on; 

l = legend([h1, h2, h3, h4, h5, h6, h7], {'1', '2', '3', '4', '5', '6','7'});
set(l,'FontSize',legend_size, 'Location','southwest','Orientation','horizontal'); 
htitle = get(l,'Title');
set(htitle,'String','Cluster', 'FontSize', legend_size);
legend boxoff
htitle.NodeChildren.Position = [0.1 0.752577319650977 0] ;   
l.ItemTokenSize(1) = 18;

subplot(2,3,4)
label_size = 12; line_width = 1; tick_size = 11; legend_size = 12; box_width = 0.5;
title_size = 10; tick_size = 12; text_size = 12; scatter_size = 50; colorbar_size= 10;
data = readtable('./flow_metrics/OUT_D_KGE.csv');
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

c = colorbar; caxis([-1 0.8]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(a) Daily Flow KGE: Best', 'FontSize', title_size);
box on; 
l = legend([h1, h2, h3, h4, h5, h6, h7], {'1', '2', '3', '4', '5', '6','7'});
set(l,'FontSize',legend_size, 'Location','southwest','Orientation','horizontal'); 
htitle = get(l,'Title');
set(htitle,'String','Cluster', 'FontSize', legend_size);
legend boxoff
htitle.NodeChildren.Position = [0.1 0.752577319650977 0] ;   
l.ItemTokenSize(1) = 18;
 

subplot(2,3,2)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_daily = data.Var40;
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

c = colorbar; caxis([-200 200]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(c) Annual Flow Volume Bias (%): Default', 'FontSize', title_size);
box on; 


subplot(2,3,5)
data = readtable('./flow_metrics/OUT_daily_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end

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

c = colorbar; caxis([-200 200]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(d) Annual Flow Volume Bias (%): Best', 'FontSize', title_size);
box on; 



subplot(2,3,3)
data = readtable('./flow_metrics/default_daily_metrics.csv');
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

cluster=1;h1 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=2;h2 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=3;h3 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=4;h4 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=5;h5 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=6;h6 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;
cluster=7;h7 = scatter(80, 30, scatter_size, 1, fmt{cluster}, 'MarkerEdgeColor',[0 0 0]/255, 'LineWidth',line_width+0.5); hold on;

c = colorbar; caxis([-200 200]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(e) Daily Flow Variance Bias (%): Default', 'FontSize', title_size);
box on; 


subplot(2,3,6)
data = readtable('./flow_metrics/OUT_daily_variance_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end

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

c = colorbar; caxis([-200 200]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(f) Daily Flow Variance Bias (%): Best', 'FontSize', title_size);
box on; 


%% plot the best for flow regime bias

subplot(2,3,1)
data = readtable('./flow_metrics/OUT_daily_q0_10_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
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

c = colorbar; caxis([-100 100]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(a) Quantiles 0-10% Flow Volume Bias (%): Best', 'FontSize', title_size);
box on; 

l = legend([h1, h2, h3, h4, h5, h6, h7], {'1', '2', '3', '4', '5', '6','7'});
set(l,'FontSize',legend_size, 'Location','southwest','Orientation','horizontal'); 
htitle = get(l,'Title');
set(htitle,'String','Cluster', 'FontSize', legend_size);
legend boxoff
htitle.NodeChildren.Position = [0.1 0.752577319650977 0] ;   
l.ItemTokenSize(1) = 18;

subplot(2,3,2)
data = readtable('./flow_metrics/OUT_daily_q10_25_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
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

c = colorbar; caxis([-100 100]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(b) Quantiles 10-25% Flow Volume Bias (%): Best', 'FontSize', title_size);
box on; 



subplot(2,3,3)
data = readtable('./flow_metrics/OUT_daily_q25_50_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
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

c = colorbar; caxis([-100 100]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(c) Quantiles 25-50% Flow Volume Bias (%): Best', 'FontSize', title_size);
box on; 


subplot(2,3,4)
data = readtable('./flow_metrics/OUT_daily_q50_75_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end

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

c = colorbar; caxis([-100 100]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(d) Quantiles 50-75% Flow Volume Bias (%): Best', 'FontSize', title_size);
box on; 



subplot(2,3,5)
data = readtable('./flow_metrics/OUT_daily_q75_90_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end

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

c = colorbar; caxis([-100 100]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(e) Quantiles 75-90% Flow Volume Bias (%): Best', 'FontSize', title_size);
box on; 


subplot(2,3,6)
data = readtable('./flow_metrics/OUT_daily_q90_100_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end

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

c = colorbar; caxis([-100 100]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(f) Quantiles 90-100% Flow Volume Bias (%): Best', 'FontSize', title_size);
box on; 





%% plot seasonal the best performance 
subplot(2,2,1)
data = readtable('./flow_metrics/OUT_daily_winter_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
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

c = colorbar; caxis([-100 100]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(a) Winter (DJF) Flow Volume Bias (%): Best', 'FontSize', title_size);
box on; 

l = legend([h1, h2, h3, h4, h5, h6, h7], {'1', '2', '3', '4', '5', '6','7'});
set(l,'FontSize',legend_size, 'Location','southwest','Orientation','horizontal'); 
htitle = get(l,'Title');
set(htitle,'String','Cluster', 'FontSize', legend_size);
legend boxoff
htitle.NodeChildren.Position = [0.1 0.752577319650977 0] ;   
l.ItemTokenSize(1) = 18;



subplot(2,2,2)
data = readtable('./flow_metrics/OUT_daily_spring_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
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

c = colorbar; caxis([-100 100]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(b) Spring (MAM) Flow Volume Bias (%): Best', 'FontSize', title_size);
box on; 



subplot(2,2,3)
data = readtable('./flow_metrics/OUT_daily_summer_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
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

c = colorbar; caxis([-100 100]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(c) Summer (JJA) Flow Volume Bias (%): Best', 'FontSize', title_size);
box on; 




subplot(2,2,4)
data = readtable('./flow_metrics/OUT_daily_fall_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_daily = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_daily(i,1) = ensemble(i, I);
end
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

c = colorbar; caxis([-100 100]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

title('(d) Fall (SON) Flow Volume Bias (%): Best', 'FontSize', title_size);
box on; 



%% boxplot default vs best:  KGE, volume, variance, FDC slope
subplot(2,2,1)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_default = data.Var7;
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/OUT_D_KGE.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_best = nanmax(ensemble,[], 2);

h1 = boxplot(metric_default, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Daily KGE', 'FontSize', label_size); 
ylim([-5 1]); box on;

delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_best, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})

color1 = [100 149 237]/255;
color2 = [165 42 42]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end   
end
ylim([-5 1]); box on;
xlim([0,max(x2)+1]);

c = get(gca, 'Children');
[hh, hleg1] = legend([c(1) c(8)],   'Default', 'Best'); 
set(hh,'FontSize',legend_size, 'Location','southwest','Orientation','vertical');

grid on;
legend boxoff;
PatchInLegend = findobj(hleg1, 'type', 'patch');
set(PatchInLegend(1), 'FaceAlpha', 0.5);
set(PatchInLegend(2), 'FaceAlpha', 0.5);

xticks(x2-delta/2)
xticklabels({'1','2','3','4','5','6','7'})

title('(a)', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);





subplot(2,2,2)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_default = data.Var40;
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/OUT_daily_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_best = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_best(i,1) = ensemble(i, I);
end

h1 = boxplot(metric_default, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Annual Flow Volume Bias (%)', 'FontSize', label_size); 
ylim([-5 1]); box on;

delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_best, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})

color1 = [100 149 237]/255;
color2 = [165 42 42]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end   
end
ylim([-100 500]); box on;
xlim([0,max(x2)+1]);

xticks(x2-delta/2)
xticklabels({'1','2','3','4','5','6','7'})

title('(b)', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
grid on;


subplot(2,2,3)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_default = data.Var41;
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/OUT_daily_variance_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_best = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_best(i,1) = ensemble(i, I);
end

h1 = boxplot(metric_default, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Daily Flow Variance Bias (%)', 'FontSize', label_size); 
ylim([-200 1000]); box on;

delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_best, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})

color1 = [100 149 237]/255;
color2 = [165 42 42]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end   
end
ylim([-200 1000]); box on;
xlim([0,max(x2)+1]);

xticks(x2-delta/2)
xticklabels({'1','2','3','4','5','6','7'})

title('(c)', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);

grid on;




subplot(2,2,4)
data = readtable('./flow_metrics/default_monthly_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_default = data.Var54;
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/OUT_monthly_FDC_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_best = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_best(i,1) = ensemble(i, I);
end

h1 = boxplot(metric_default, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Monthly Flow FDC Slope Bias (%)', 'FontSize', label_size); 
ylim([-200 1000]); box on;

delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_best, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})

color1 = [100 149 237]/255;
color2 = [165 42 42]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end   
end
ylim([-200 1000]); box on;
xlim([0,max(x2)+1]);

xticks(x2-delta/2)
xticklabels({'1','2','3','4','5','6','7'})

title('(d)', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
grid on;




%% boxplot default vs best:  flow regimes
subplot(2,3,1)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_default = data.Var42;
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/OUT_daily_q0_10_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_best = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_best(i,1) = ensemble(i, I);
end

h1 = boxplot(metric_default, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 


delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_best, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})
ylim([-200 1000]); box on;
color1 = [100 149 237]/255;
color2 = [165 42 42]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end   
end

xlim([0,max(x2)+1]);

c = get(gca, 'Children');
[hh, hleg1] = legend([c(1) c(8)],   'Default', 'Best'); 
set(hh,'FontSize',legend_size, 'Location','northwest','Orientation','vertical');

grid on;
legend boxoff;
PatchInLegend = findobj(hleg1, 'type', 'patch');
set(PatchInLegend(1), 'FaceAlpha', 0.5);
set(PatchInLegend(2), 'FaceAlpha', 0.5);

xticks(x2-delta/2)
xticklabels({'1','2','3','4','5','6','7'})

title('(a) Quantiles 0-10%', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);






subplot(2,3,2)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_default = data.Var44;
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/OUT_daily_q10_25_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_best = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_best(i,1) = ensemble(i, I);
end

h1 = boxplot(metric_default, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 


delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_best, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})
ylim([-200 1000]); box on;
color1 = [100 149 237]/255;
color2 = [165 42 42]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end   
end

xlim([0,max(x2)+1]);

xticks(x2-delta/2)
xticklabels({'1','2','3','4','5','6','7'})

title('(b) Quantiles 10-25%', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
box on; grid on;



subplot(2,3,3)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_default = data.Var46;
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/OUT_daily_q25_50_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_best = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_best(i,1) = ensemble(i, I);
end

h1 = boxplot(metric_default, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 


delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_best, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})
ylim([-200 1000]); box on;
color1 = [100 149 237]/255;
color2 = [165 42 42]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end   
end

xlim([0,max(x2)+1]);

xticks(x2-delta/2)
xticklabels({'1','2','3','4','5','6','7'})

title('(c) Quantiles 25-50%', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
box on; grid on;




subplot(2,3,4)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_default = data.Var48;
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/OUT_daily_q50_75_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_best = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_best(i,1) = ensemble(i, I);
end

h1 = boxplot(metric_default, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 


delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_best, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})
ylim([-200 1000]); box on;
color1 = [100 149 237]/255;
color2 = [165 42 42]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end   
end

xlim([0,max(x2)+1]);

xticks(x2-delta/2)
xticklabels({'1','2','3','4','5','6','7'})

title('(d) Quantiles 50-75%', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
box on; grid on;





subplot(2,3,5)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_default = data.Var50;
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/OUT_daily_q75_90_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_best = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_best(i,1) = ensemble(i, I);
end

h1 = boxplot(metric_default, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 


delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_best, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})
ylim([-200 1000]); box on;
color1 = [100 149 237]/255;
color2 = [165 42 42]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end   
end

xlim([0,max(x2)+1]);

xticks(x2-delta/2)
xticklabels({'1','2','3','4','5','6','7'})

title('(e) Quantiles 75-90%', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
box on; grid on;




subplot(2,3,6)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_default = data.Var52;
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/OUT_daily_q90_100_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_best = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_best(i,1) = ensemble(i, I);
end

h1 = boxplot(metric_default, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 


delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_best, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})
ylim([-200 1000]); box on;
color1 = [100 149 237]/255;
color2 = [165 42 42]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end   
end

xlim([0,max(x2)+1]);

xticks(x2-delta/2)
xticklabels({'1','2','3','4','5','6','7'})

title('(f) Quantiles 90-100%', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);
box on; grid on;








%%  plot boxplot seasonal: default vs best
subplot(2,2,1)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_default = data.Var56;
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/OUT_daily_winter_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_best = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_best(i,1) = ensemble(i, I);
end

h1 = boxplot(metric_default, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 


delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_best, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})
ylim([-100 500]); box on;
color1 = [100 149 237]/255;
color2 = [165 42 42]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end   
end

xlim([0,max(x2)+1]);

c = get(gca, 'Children');
[hh, hleg1] = legend([c(1) c(8)],   'Default', 'Best'); 
set(hh,'FontSize',legend_size, 'Location','northwest','Orientation','vertical');

grid on;
legend boxoff;
PatchInLegend = findobj(hleg1, 'type', 'patch');
set(PatchInLegend(1), 'FaceAlpha', 0.5);
set(PatchInLegend(2), 'FaceAlpha', 0.5);

xticks(x2-delta/2)
xticklabels({'1','2','3','4','5','6','7'})

title('(a) Winter (DJF)', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);




subplot(2,2,2)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_default = data.Var57;
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/OUT_daily_spring_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_best = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_best(i,1) = ensemble(i, I);
end

h1 = boxplot(metric_default, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 


delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_best, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})
ylim([-100 500]); box on;
color1 = [100 149 237]/255;
color2 = [165 42 42]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end   
end

xlim([0,max(x2)+1]);
xticks(x2-delta/2)
xticklabels({'1','2','3','4','5','6','7'})

title('(b) Spring (MAM)', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);

grid on;




subplot(2,2,3)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_default = data.Var58;
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/OUT_daily_summer_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_best = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_best(i,1) = ensemble(i, I);
end

h1 = boxplot(metric_default, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 


delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_best, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})
ylim([-100 500]); box on;
color1 = [100 149 237]/255;
color2 = [165 42 42]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end   
end

xlim([0,max(x2)+1]);
xticks(x2-delta/2)
xticklabels({'1','2','3','4','5','6','7'})

title('(c) Summer (JJA)', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);

grid on;





subplot(2,2,4)
data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
metric_default = data.Var59;
x1 = [1, 5, 9, 13, 17, 21, 25];

data = readtable('./flow_metrics/OUT_daily_fall_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
metric_best = nan(464,1);
for i = 1:464
    [M,I] = nanmin(abs(ensemble(i,:)));
    metric_best(i,1) = ensemble(i, I);
end

h1 = boxplot(metric_default, cluster_ID, 'positions', x1, 'width', box_width); hold on;
xlim([0,max(x1)+1]);
% line([0,max(x1)+1], [0, 0], 'color',[0 0 0]/255,  'Linewidth', line_width ,'LineStyle','--'); hold on;        % horizontal line
set(h1,{'linew'},{line_width+1})
xlabel('Cluster', 'FontSize', label_size); 
ylabel('Flow Volume Bias (%)', 'FontSize', label_size); 


delta = 1;
x2 = x1 + delta;
h2=boxplot(metric_best, cluster_ID, 'positions', x2, 'width', box_width); hold on;
set(h2,{'linew'},{line_width+1})
ylim([-100 500]); box on;
color1 = [100 149 237]/255;
color2 = [165 42 42]/255;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    if j <=7
        patch(get(h(j),'XData'),get(h(j),'YData'),color1,'FaceAlpha',0.5);
    end
    if j>7 && j<=14
        patch(get(h(j),'XData'),get(h(j),'YData'),color2,'FaceAlpha',0.5);
    end   
end

xlim([0,max(x2)+1]);
xticks(x2-delta/2)
xticklabels({'1','2','3','4','5','6','7'})

title('(d) Fall (SON)', 'FontSize', title_size); 
set(gca,'FontSize',tick_size);

grid on;








%% ensemble exceedance probability for seasonal and annual volume, and daily variance

subplot(2,3,1)
data = readtable('./flow_metrics/OUT_daily_winter_volume_bias.csv');
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = abs(ensemble);

data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
default = abs(data.Var56);



nBasin = 464;
out = nan(nBasin, 1); 

for i = 1:nBasin
    
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));
        
    
    
        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end



metric_daily = out;
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

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

box on;

title('(a) Winter Flow Volume Bias', 'FontSize', title_size);
box on; 

l = legend([h1, h2, h3, h4, h5, h6, h7], {'1', '2', '3', '4', '5', '6','7'});
set(l,'FontSize',legend_size, 'Location','southwest','Orientation','horizontal'); 
htitle = get(l,'Title'); l.ItemTokenSize(1) = 18;
set(htitle,'String','Cluster', 'FontSize', legend_size);
legend boxoff
htitle.NodeChildren.Position = [0.1 0.752577319650977 0] ;






subplot(2,3,2)
data = readtable('./flow_metrics/OUT_daily_spring_volume_bias.csv');
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = abs(ensemble);


data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
default = abs(data.Var57);

nBasin = 464;
out = nan(nBasin, 1); 

for i = 1:nBasin
    
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));
        
    
    
        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end



metric_daily = out;
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

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

box on;

title('(b) Spring Flow Volume Bias', 'FontSize', title_size);
box on; 






subplot(2,3,3)
data = readtable('./flow_metrics/OUT_daily_summer_volume_bias.csv');
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = abs(ensemble);


data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
default = abs(data.Var58);

nBasin = 464;
out = nan(nBasin, 1); 

for i = 1:nBasin
    
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));
        
    
    
        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end



metric_daily = out;
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

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

box on;

title('(c) Summer Flow Volume Bias', 'FontSize', title_size);
box on; 





subplot(2,3,4)
data = readtable('./flow_metrics/OUT_daily_fall_volume_bias.csv');
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = abs(ensemble);


data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
default = abs(data.Var59);

nBasin = 464;
out = nan(nBasin, 1); 

for i = 1:nBasin
    
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));
        
    
    
        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end



metric_daily = out;
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

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

 box on;

title('(d) Fall Flow Volume Bias', 'FontSize', title_size);
box on; 



subplot(2,3,5)
data = readtable('./flow_metrics/OUT_daily_volume_bias.csv');
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = abs(ensemble);


data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
default = abs(data.Var40);

nBasin = 464;
out = nan(nBasin, 1); 

for i = 1:nBasin
    
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));
        
    
    
        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end



metric_daily = out;
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

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

 box on;

title('(e) Annual Flow Volume Bias', 'FontSize', title_size);
box on; 





subplot(2,3,6)
data = readtable('./flow_metrics/OUT_daily_variance_bias.csv');
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = abs(ensemble);


data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
default = abs(data.Var41);

nBasin = 464;
out = nan(nBasin, 1); 

for i = 1:nBasin
    
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));
        
    
    
        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end



metric_daily = out;
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

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

 box on;

title('(f) Daily Flow Variance Bias', 'FontSize', title_size);
box on; 





%% exceedance of different flow regimes
subplot(2,3,1)
data = readtable('./flow_metrics/OUT_daily_q0_10_volume_bias.csv');
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = abs(ensemble);

data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
default = abs(data.Var42);

nBasin = 464;
out = nan(nBasin, 1); 

for i = 1:nBasin
    
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));
        
    
    
        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end



metric_daily = out;
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

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

box on;

title('(a) Quantiles 0-10% Flow Volume Bias', 'FontSize', title_size);
box on; 

l = legend([h1, h2, h3, h4, h5, h6, h7], {'1', '2', '3', '4', '5', '6','7'});
set(l,'FontSize',legend_size, 'Location','southwest','Orientation','horizontal'); 
htitle = get(l,'Title'); l.ItemTokenSize(1) = 18;
set(htitle,'String','Cluster', 'FontSize', legend_size);
legend boxoff
htitle.NodeChildren.Position = [0.1 0.752577319650977 0] ;







subplot(2,3,2)
data = readtable('./flow_metrics/OUT_daily_q10_25_volume_bias.csv');
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = abs(ensemble);

data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
default = abs(data.Var44);

nBasin = 464;
out = nan(nBasin, 1); 

for i = 1:nBasin
    
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));
        
    
    
        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end



metric_daily = out;
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

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

box on;

title('(b) Quantiles 10-25% Flow Volume Bias', 'FontSize', title_size);
box on; 






subplot(2,3,3)
data = readtable('./flow_metrics/OUT_daily_q25_50_volume_bias.csv');
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = abs(ensemble);

data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
default = abs(data.Var46);

nBasin = 464;
out = nan(nBasin, 1); 

for i = 1:nBasin
    
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));
        
    
    
        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end



metric_daily = out;
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

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

box on;

title('(c) Quantiles 25-50% Flow Volume Bias', 'FontSize', title_size);
box on; 







subplot(2,3,4)
data = readtable('./flow_metrics/OUT_daily_q50_75_volume_bias.csv');
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = abs(ensemble);

data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
default = abs(data.Var48);

nBasin = 464;
out = nan(nBasin, 1); 

for i = 1:nBasin
    
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));
        
    
    
        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end



metric_daily = out;
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

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

box on;

title('(d) Quantiles 50-75% Flow Volume Bias', 'FontSize', title_size);
box on; 





subplot(2,3,5)
data = readtable('./flow_metrics/OUT_daily_q75_90_volume_bias.csv');
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = abs(ensemble);

data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
default = abs(data.Var50);

nBasin = 464;
out = nan(nBasin, 1); 

for i = 1:nBasin
    
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));
        
    
    
        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end



metric_daily = out;
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

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

box on;

title('(e) Quantiles 75-90% Flow Volume Bias', 'FontSize', title_size);
box on; 







subplot(2,3,6)
data = readtable('./flow_metrics/OUT_daily_q90_100_volume_bias.csv');
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = abs(ensemble);

data = readtable('./flow_metrics/default_daily_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
default = abs(data.Var52);

nBasin = 464;
out = nan(nBasin, 1); 

for i = 1:nBasin
    
    d_metric = default(i,1);     
    if isnan(d_metric)
        out(i,1) = nan;
    else
        [f,x] = ecdf(ensemble(i,:));
        
    
    
        for j = 1:length(x)
            if d_metric == x(j)
                d_p = f(j);
                break
            end

            if j>1 && d_metric>x(j-1) && d_metric<x(j)
                d_p = (f(j-1) + f(j))/2;
                break
            end
        end

        out(i,1) = d_p;
    end
end



metric_daily = out;
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

c = colorbar; caxis([0 1]);  colormap((jet(50)));  
c.FontSize = colorbar_size;

plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');

xlim([-128 -64]); ylim([22 52]); box on;
xlabel('Longitude', 'FontSize', label_size); 
ylabel('Latitude', 'FontSize', label_size); 

box on;

title('(f) Quantiles 90-100% Flow Volume Bias', 'FontSize', title_size);
box on; 





%% output the plot

fig = gcf;
fig.PaperUnits = 'inches';

% fig.PaperPosition = [0 0 8 5];
% fig.PaperPosition = [0 0 5 4];
fig.PaperPosition = [0 0 17.7 8];
% fig.PaperPosition = [0 0 13 8];
print('ScreenSizeFigure', '-dpng', '-r478')





