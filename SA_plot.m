%% load the n_normalized data
clear all; clc;

label_size = 11; line_width = 1; tick_size = 11; legend_size = 11;
title_size = 11; tick_size = 11; text_size = 12; scatter_size = 15; colorbar_size= 11;

%% plot the regional matric

subplot(2,4,1)

n_sa = load('./SA_metrics/n_delta_ET_OUT_annual_bias');
r_sa = sortrows(n_sa,4);
score = r_sa(:,5:end);

cluster_index = nan(7,2);
for i = 1:7
    index = find(r_sa(:,4)==i);
    cluster_index(i,1) = index(1);
    cluster_index(i,2) = index(end);
end

region_SA = nan(15, 7);
for i = 1:7
    score_cluster = score(cluster_index(i,1):cluster_index(i,2,:),:);
    sum_score_cluster = nansum(score_cluster,1);
    region_SA(:,i) = sum_score_cluster;
end

region_N_SA = nan(15,7);
for i = 1:7
    region_N_SA(:,i) = (region_SA(:,i) - min(region_SA(:,i))) / (max(region_SA(:,i)) - min(region_SA(:,i)));
end



imagesc(region_N_SA ); hold on; 
caxis([0 1]);  colormap(brewermap([],'*RdBu'));    
% c = colorbar; 
% c.FontSize = colorbar_size;
% ylabel(c, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')
ylabel('Parameter', 'FontSize', label_size); 
xlabel('Cluster', 'FontSize', label_size); 
title('(a) Daily RMSE', 'FontSize',title_size);

y=1:15; yticks(y)
x=1:7; xticks(x)
% xticklabels({'D-KGE','D-NSE','D-RMSE','D-MAE','D-TRMSE','M-KGE','M-NSE', 'M-RMSE', 'M-MAE', 'M-TRMSE'})

xlim([0.5, 7.5]);
ylim([0.5, 15.5]);

for i = 0.5:1:15.5
    line([0,7.5], [i i], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end
for i = 0.5:1:7.5
    line([i i], [0, 15.5], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end



subplot(2,4,2)

n_sa = load('./SA_metrics/n_delta_OUT_M_RMSE');
r_sa = sortrows(n_sa,4);
score = r_sa(:,5:end);

cluster_index = nan(7,2);
for i = 1:7
    index = find(r_sa(:,4)==i);
    cluster_index(i,1) = index(1);
    cluster_index(i,2) = index(end);
end

region_SA = nan(15, 7);
for i = 1:7
    score_cluster = score(cluster_index(i,1):cluster_index(i,2,:),:);
    sum_score_cluster = nansum(score_cluster,1);
    region_SA(:,i) = sum_score_cluster;
end

region_N_SA = nan(15,7);
for i = 1:7
    region_N_SA(:,i) = (region_SA(:,i) - min(region_SA(:,i))) / (max(region_SA(:,i)) - min(region_SA(:,i)));
end



imagesc(region_N_SA ); hold on; 
caxis([0 1]);  colormap(brewermap([],'*RdBu'));    
% c = colorbar; 
% c.FontSize = colorbar_size;
% ylabel(c, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')
% ylabel('Parameter', 'FontSize', label_size); 
xlabel('Cluster', 'FontSize', label_size); 
title('(b) Monthly RMSE', 'FontSize',title_size);

y=1:15; yticks(y)
x=1:7; xticks(x)
% xticklabels({'D-KGE','D-NSE','D-RMSE','D-MAE','D-TRMSE','M-KGE','M-NSE', 'M-RMSE', 'M-MAE', 'M-TRMSE'})

xlim([0.5, 7.5]);
ylim([0.5, 15.5]);

for i = 0.5:1:15.5
    line([0,7.5], [i i], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end
for i = 0.5:1:7.5
    line([i i], [0, 15.5], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end



subplot(2,4,3)
n_sa = load('./SA_metrics/n_delta_OUT_D_TRMSE');
r_sa = sortrows(n_sa,4);
score = r_sa(:,5:end);

cluster_index = nan(7,2);
for i = 1:7
    index = find(r_sa(:,4)==i);
    cluster_index(i,1) = index(1);
    cluster_index(i,2) = index(end);
end

region_SA = nan(15, 7);
for i = 1:7
    score_cluster = score(cluster_index(i,1):cluster_index(i,2,:),:);
    sum_score_cluster = nansum(score_cluster,1);
    region_SA(:,i) = sum_score_cluster;
end

region_N_SA = nan(15,7);
for i = 1:7
    region_N_SA(:,i) = (region_SA(:,i) - min(region_SA(:,i))) / (max(region_SA(:,i)) - min(region_SA(:,i)));
end



imagesc(region_N_SA ); hold on; 
caxis([0 1]);  colormap(brewermap([],'*RdBu'));    
% c = colorbar; 
% c.FontSize = colorbar_size;
% ylabel(c, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')
% ylabel('Parameter', 'FontSize', label_size); 
xlabel('Cluster', 'FontSize', label_size); 
title('(c) Daily TRMSE', 'FontSize',title_size);

y=1:15; yticks(y)
x=1:7; xticks(x)
% xticklabels({'D-KGE','D-NSE','D-RMSE','D-MAE','D-TRMSE','M-KGE','M-NSE', 'M-RMSE', 'M-MAE', 'M-TRMSE'})

xlim([0.5, 7.5]);
ylim([0.5, 15.5]);

for i = 0.5:1:15.5
    line([0,7.5], [i i], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end
for i = 0.5:1:7.5
    line([i i], [0, 15.5], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end


















%% plot the matrix plot for 1 metric
scatter_size = 40; label_size = 16; legend_size = 14; tick_size = 14; colorbar_size= 14;title_size = 14;

n_sa = load('./SA_metrics/n_delta_ET_OUT_annual_bias');

% rank by cluster
r_sa = sortrows(n_sa,4);

score = r_sa(:,5:end);

% find a threshold
% score(score(:)<0.4)=0;
% score(score(:)>=0.4)=1;

imagesc(score ); hold on; 
c = colorbar; caxis([0 1]);  colormap(brewermap([10],'*RdBu'));    
c.FontSize = colorbar_size;
ylabel(c, 'Normalized Sensitivity Score to Monthly RMSE', 'FontSize', label_size);
set(gca,'YDir','normal')
ylabel('Basins in Cluster', 'FontSize', label_size); 
xlabel('Parameters', 'FontSize', label_size); 
xticks(1:15);

set(gca,'FontSize',tick_size);
x1=get(gca,'position');
x=get(c,'Position');
x(3)=0.02;
set(c,'Position',x)
set(gca,'position',x1)




set(gca,'color',[240 240 240]/255)


% title('Monthly RMSE', 'FontSize',title_size);



% plot the cluster horizational line
lines_num = nan(7,2);
for i = 1:7
    index = find(r_sa(:,4)==i);
    lines_num(i,1) = index(end);
    lines_num(i,2) = index(round(length(index)/2));
end


y=1:464; yticks(lines_num(:,2)); yticklabels({'1-Northeast', '2-Pacific', '3-AZ/NM', '4-Rockies', '5-Great Plains', '6-Great Lakes', '7-Southeast'});
ytickangle(0)
x=1:15; xticks(y); xticklabels({'fff', 'N_{bf}', 'K_{bf}', 'S_y', 'B', 'ψ_{sat}', 'k_{sat}', 'Ɵ_{sat}', 'N_{melt}', 'k_{acc}',...
    'p_{sno}', 'p_{lip}', 'f_{wet}', 'd_{max}', 'Ɵ_{ini}'});





for i = 0.5:1:15.5
    line([i, i], [0 464], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

for i = 1:6
   line([0,16],[lines_num(i,1), lines_num(i,1)], 'color',[255 255 0]/255,  'Linewidth',line_width+1 ); hold on;
end

%% bar plot SA score for 1 basin and 1 metric

%6280300-> cluster 4, north WY; 14316700 -> cluster 2, OR cascades; 
%9497800-> cluster 3, AZ;       6332515 -> cluster 5, ND
%8150800-> cluster 5, TX; 
basin_id = 7060710;  %   9065500; 7060710 (cluster 1, AR)
figure
n_sa = load('./SA_metrics/n_delta_OUT_M_RMSE');
r_sa = sortrows(n_sa,4);
score = r_sa(r_sa(:,1)==basin_id,5:end);
bar(score, 'FaceColor',[100 149 237]/255);
ylabel('Normalized SA Score', 'FontSize', label_size); 
x = 1:15;
xticks(x)
xticklabels({'fff','n_baseflow','baseflow_scalar','aq_sp_yield_min','bsw_sf','sucsat_sf','hksat_sf',...
    'watsat_sf','n_melf_coef','accum_factor','snow_canopy_storage_scalar','liq_canopy_storage_scalar',...
    'maximum_leaf_wetted_fraction','d_max','frac_sat_soil_dsl_init'})
xtickangle(45)
set(gca,'TickLabelInterpreter','none')







%% plot 3d parameter space: daily vs monthly


para = load('./parameter_ensemble_LHS1500');
succ_id = load('./sucessful_par_id');
para_ensemble = nan(1307, 15);
for i = 1:1307
    para_ensemble(i,:) = para(succ_id(i),:);
end



subplot(2,2,1)

basin_id = 9065500;

n_sa = load('./SA_metrics/n_delta_OUT_D_KGE');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);
para_id_1 = find(basin_sa>0.7);
para_id_1_score = basin_sa(para_id_1);

data = readtable('../1500Ensemble/flow_metrics/OUT_D_KGE.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));
par3 = para_ensemble(:,para_id_1(3));

% quantile95 = quantile(abs(ensemble), 0.05);
quantile95 = quantile(ensemble, 0.95);



scatter3(par1, par2, par3, scatter_size-5,  'MarkerFaceColor',[220 220 220]/255, 'MarkerEdgeColor',[220 220 220]/255); hold on;
scatter3(par1((ensemble)>=quantile95), par2((ensemble)>=quantile95), par3((ensemble)>=quantile95), scatter_size-5,ensemble((ensemble)>=quantile95),...
    'MarkerFaceColor',[240 128 128]/255, 'MarkerEdgeColor',[0 0 0]/255);  
% h = colorbar;  

xlabel(sprintf('sucsat_sf (%4.2f)', para_id_1_score(1)), 'FontSize', label_size, 'Interpreter', 'none'); 
ylabel(sprintf('maximum_leaf_wetted_fraction (%4.2f)', para_id_1_score(2)), 'FontSize', label_size, 'Interpreter', 'none'); 
zlabel(sprintf('d_max (%4.2f)', para_id_1_score(3)), 'FontSize', label_size, 'Interpreter', 'none'); 
title('(a) Daily KGE: Basin 09065500 in CO', 'FontSize',title_size);




subplot(2,2,2)
% plot monthly
n_sa = load('./SA_metrics/n_delta_OUT_M_KGE');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);

para_id_2 = find(basin_sa>0.65);  para_id_2 = para_id_1;
para_id_2_score = basin_sa(para_id_2);

data = readtable('../1500Ensemble/flow_metrics/OUT_M_KGE.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_2(1));
par2 = para_ensemble(:,para_id_2(2));
par3 = para_ensemble(:,para_id_2(3));

quantile95 = quantile(ensemble, 0.95);

scatter3(par1, par2, par3, scatter_size-5,  'MarkerFaceColor',[220 220 220]/255, 'MarkerEdgeColor',[220 220 220]/255); hold on;
quantile95 = quantile(ensemble, 0.95);
scatter3(par1(ensemble>=quantile95), par2(ensemble>=quantile95), par3(ensemble>=quantile95), scatter_size-5,...
    'MarkerFaceColor',[100 149 237]/255, 'MarkerEdgeColor',[0 0 0]/255);  hold on;



xlabel(sprintf('sucsat_sf (%4.2f)', para_id_2_score(1)), 'FontSize', label_size, 'Interpreter', 'none'); 
ylabel(sprintf('maximum_leaf_wetted_fraction (%4.2f)', para_id_2_score(2)), 'FontSize', label_size, 'Interpreter', 'none'); 
zlabel(sprintf('d_max (%4.2f)', para_id_2_score(3)), 'FontSize', label_size, 'Interpreter', 'none'); 
title('(b) Monthly KGE: Basin 09065500 in CO', 'FontSize',title_size);





subplot(2,2,3)

basin_id = 2215100;

n_sa = load('./SA_metrics/n_delta_OUT_D_KGE');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);
para_id_1 = find(basin_sa>0.65);
para_id_1_score = basin_sa(para_id_1);

data = readtable('../1500Ensemble/flow_metrics/OUT_D_KGE.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));
par3 = para_ensemble(:,para_id_1(3));

quantile95 = quantile(ensemble, 0.95);


scatter3(par1, par2, par3, scatter_size-5,  'MarkerFaceColor',[220 220 220]/255, 'MarkerEdgeColor',[220 220 220]/255); hold on;
scatter3(par1(ensemble>=quantile95), par2(ensemble>=quantile95), par3(ensemble>=quantile95), scatter_size-5,ensemble(ensemble>=quantile95),...
    'MarkerFaceColor',[240 128 128]/255, 'MarkerEdgeColor',[0 0 0]/255);  
% h = colorbar;  

xlabel(sprintf('baseflow_scalar (%4.2f)', para_id_1_score(1)), 'FontSize', label_size, 'Interpreter', 'none'); 
ylabel(sprintf('sucsat_sf (%4.2f)', para_id_1_score(2)), 'FontSize', label_size, 'Interpreter', 'none'); 
zlabel(sprintf('frac_sat_soil_dsl_init (%4.2f)', para_id_1_score(3)), 'FontSize', label_size, 'Interpreter', 'none'); 
title('(c) Daily KGE: Basin 02215100 in GA', 'FontSize',title_size);




subplot(2,2,4)
% plot monthly
n_sa = load('./SA_metrics/n_delta_OUT_M_KGE');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);

para_id_2 = find(basin_sa>0.65);  para_id_2 = para_id_1;
para_id_2_score = basin_sa(para_id_2);

data = readtable('../1500Ensemble/flow_metrics/OUT_M_KGE.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_2(1));
par2 = para_ensemble(:,para_id_2(2));
par3 = para_ensemble(:,para_id_2(3));

quantile95 = quantile(ensemble, 0.95);

scatter3(par1, par2, par3, scatter_size-5,  'MarkerFaceColor',[220 220 220]/255, 'MarkerEdgeColor',[220 220 220]/255); hold on;
quantile95 = quantile(ensemble, 0.95);
scatter3(par1(ensemble>=quantile95), par2(ensemble>=quantile95), par3(ensemble>=quantile95), scatter_size-5,...
    'MarkerFaceColor',[100 149 237]/255, 'MarkerEdgeColor',[0 0 0]/255);  hold on;



xlabel(sprintf('baseflow_scalar (%4.2f)', para_id_2_score(1)), 'FontSize', label_size, 'Interpreter', 'none'); 
ylabel(sprintf('sucsat_sf (%4.2f)', para_id_2_score(2)), 'FontSize', label_size, 'Interpreter', 'none'); 
zlabel(sprintf('frac_sat_soil_dsl_init (%4.2f)', para_id_2_score(3)), 'FontSize', label_size, 'Interpreter', 'none'); 
title('(d) Monthly KGE: Basin 02215100 in GA', 'FontSize',title_size);



%% plot 3d parameter space


label_size = 12; line_width = 0.5; tick_size = 12; legend_size = 11;
title_size = 12; tick_size = 12; text_size = 12; scatter_size = 15; colorbar_size= 12;      
      

ax1 = subplot(2,2,1)
para = load('./parameter_ensemble_LHS1500');
succ_id = load('./sucessful_par_id');
para_ensemble = nan(1307, 15);
for i = 1:1307
    para_ensemble(i,:) = para(succ_id(i),:);
end


basin_id = 2011400;  % basin in VA (cluster 1)

n_sa = load('./SA_metrics/n_delta_OUT_daily_q0_10_volume_bias');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);
para_id_1 = find(basin_sa>0.3);
para_id_1_score = basin_sa(para_id_1);

data = readtable('../1500Ensemble/flow_metrics/OUT_daily_q0_10_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));

threshold = 50;
index = abs(ensemble)<=threshold;
metric = ensemble(index);
max(metric)
min(metric)



h11=scatter(par1, par2, scatter_size-5,  ensemble, 'filled'); hold on;
colormap(ax1, brewermap([],'*Spectral'));   c1 = colorbar; 

h12=scatter(par1(abs(ensemble)<=threshold), par2(abs(ensemble)<=threshold), scatter_size-5,ensemble(abs(ensemble)<=threshold),...
     'MarkerEdgeColor',[0 0 0]/255,'LineWidth',line_width+1);  hold on;

 

xlabel(sprintf('fff (%4.2f)', para_id_1_score(1)), 'FontSize', label_size, 'Interpreter', 'none'); 
ylabel(sprintf('p_{lip} (%4.2f)', para_id_1_score(2)), 'FontSize', label_size); 
% zlabel(sprintf('frac_sat_soil_dsl_init (%4.2f)', para_id_1_score(3)), 'FontSize', label_size, 'Interpreter', 'none'); 
title('(a) Abs. Q0-10% Flow Volume Bias ≤ 50% (2% Total)', 'FontSize',title_size);

box on; grid on;

set(gca,'color',[240 240 240]/255)


ax2 = subplot(2,2,2)
basin_id = 2011400;  % basin in VA (cluster 1)

n_sa = load('./SA_metrics/n_delta_OUT_M_RMSE');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);
para_id_1 = find(basin_sa>0.3);
para_id_1_score = basin_sa(para_id_1);

data = readtable('../1500Ensemble/flow_metrics/OUT_M_NSE.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));


threshold = 0.5;



index = ensemble>=threshold;
metric = ensemble(index);
max(metric)
min(metric)


h21=scatter(par1, par2, scatter_size-5,  ensemble, 'filled'); hold on;
colormap(ax2, brewermap([],'Spectral'));   c2 = colorbar; 

h22=scatter(par1((ensemble)>=threshold), par2((ensemble)>=threshold), scatter_size-5,ensemble((ensemble)>=threshold),...
    'MarkerEdgeColor',[0 0 0]/255,'LineWidth',line_width+1);  hold on;

xlabel(sprintf('fff (%4.2f)', para_id_1_score(1)), 'FontSize', label_size, 'Interpreter', 'none'); 
ylabel(sprintf('ψ_{sat} (%4.2f)', para_id_1_score(2)), 'FontSize', label_size); 
% zlabel(sprintf('frac_sat_soil_dsl_init (%4.2f)', para_id_1_score(3)), 'FontSize', label_size, 'Interpreter', 'none'); 
title('(b) Monthly Flow NSE ≥ 0.5 (2% Total)', 'FontSize',title_size);

box on; grid on;

set(gca,'color',[240 240 240]/255)



ax3 = subplot(2,2,3)
basin_id = 2011400;  % basin in VA (cluster 1)

n_sa = load('./SA_metrics/n_delta_OUT_D_KGE');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);
para_id_1 = find(basin_sa>0.50);
para_id_1_score = basin_sa(para_id_1);

data = readtable('../1500Ensemble/flow_metrics/OUT_D_KGE.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));
par3 = para_ensemble(:,para_id_1(3));

threshold = 0.3;



index = ensemble>=threshold;
metric = ensemble(index);
max(metric)
min(metric)




scatter3(par1, par2, par3, scatter_size-5,  ensemble, 'o','filled'); hold on;
colormap(ax3, brewermap([],'Spectral'));   c2 = colorbar;  
caxis([-0.5,0.5]);

scatter3(par1(ensemble>=threshold), par2(ensemble>=threshold), par3(ensemble>=threshold), scatter_size-5,ensemble(ensemble>=threshold),...
    'o',  'MarkerEdgeColor',[0 0 0]/255,'LineWidth',line_width+1); hold on;
% view(-30,10)
box on;
ax = gca;
ax.BoxStyle = 'full';

xlabel(sprintf('fff (%4.2f)', para_id_1_score(1)), 'FontSize', label_size, 'Interpreter', 'none'); 
ylabel(sprintf('ψ_{sat} (%4.2f)', para_id_1_score(2)), 'FontSize', label_size); 
zlabel(sprintf('Ɵ_{sat} (%4.2f)', para_id_1_score(3)), 'FontSize', label_size); 

% zlabel(sprintf('frac_sat_soil_dsl_init (%4.2f)', para_id_1_score(3)), 'FontSize', label_size, 'Interpreter', 'none'); 
title('(c) Daily Flow KGE ≥ 0.3 (2% Total)', 'FontSize',title_size);

box on; grid on;

set(gca,'color',[240 240 240]/255)




ax4 = subplot(2,2,4)
basin_id = 2011400;  % basin in VA (cluster 1)

n_sa = load('./SA_metrics/n_delta_OUT_daily_volume_bias');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);
para_id_1 = find(basin_sa>0.4);
para_id_1_score = basin_sa(para_id_1);

data = readtable('../1500Ensemble/flow_metrics/OUT_daily_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));
par3 = para_ensemble(:,para_id_1(3));

threshold = 10;



index = abs(ensemble)<=threshold;
metric = ensemble(index);
max(metric)
min(metric)


scatter3(par1, par2, par3, scatter_size-5,  ensemble, 'o','filled'); hold on;
colormap(ax4, brewermap([],'*Spectral'));  c2 = colorbar;


scatter3(par1(abs(ensemble)<=threshold), par2(abs(ensemble)<=threshold), par3(abs(ensemble)<=threshold), scatter_size-5,ensemble(abs(ensemble)<=threshold),...
     'MarkerEdgeColor',[0 0 0]/255,'LineWidth',line_width+1);  
% view(-30,10)
box on;
ax = gca;
ax.BoxStyle = 'full';

xlabel(sprintf('Ɵ_{sat} (%4.2f)', para_id_1_score(1)), 'FontSize', label_size); 
ylabel(sprintf('p_{lip} (%4.2f)', para_id_1_score(2)), 'FontSize', label_size); 
zlabel(sprintf('Ɵ_{ini} (%4.2f)', para_id_1_score(3)), 'FontSize', label_size); 

title('(d) Abs. Annual Flow Volume Bias ≤ 10% (28% Total)', 'FontSize',title_size);
set(gca,'color',[240 240 240]/255)


%% based on the parameter partition figure, plot the boxplot of the constrained error

label_size = 8; line_width = 0.5; tick_size = 8; legend_size = 8;
title_size = 8; tick_size = 8; text_size = 8; scatter_size = 15; colorbar_size= 8;      
 
para = load('./parameter_ensemble_LHS1500');
succ_id = load('./sucessful_par_id');
para_ensemble = nan(1307, 15);
for i = 1:1307
    para_ensemble(i,:) = para(succ_id(i),:);
end


basin_id = 2011400;  % basin in VA (cluster 1)


subplot(4, 4,1)
n_sa = load('./SA_metrics/n_delta_OUT_daily_q0_10_volume_bias');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);
para_id_1 = find(basin_sa>0.3);
para_id_1_score = basin_sa(para_id_1);

data = readtable('../1500Ensemble/flow_metrics/OUT_daily_q0_10_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));

quantile95 = 50;

index = abs(ensemble)<=quantile95;
metric = ensemble(index);
max(metric)
min(metric)

SixMPG = ensemble;
pdSix = fitdist(SixMPG','Kernel','Width',3);
x = min(SixMPG)-20:0.01:max(SixMPG)+20;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [255, 127, 80]/255;
h1 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h1, .5); hold on;
xlim([-120,0]);

SixMPG = metric;
pdSix = fitdist(SixMPG','Kernel','Width',3);
x = min(SixMPG)-20:0.01:max(SixMPG)+20;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [100 149 237]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;
xlim([-120,0]);
box on; grid on;
set(gca,'color',[240 240 240]/255)
ylabel('Density', 'FontSize', label_size);
xlabel('Bias (%)', 'FontSize', label_size);
title('(a) Abs. Q0-10% Flow Volume Bias ≤ 50%', 'FontSize', label_size);
l = legend('Prior', 'Behavioral');
set(l,'FontSize',legend_size, 'Location','northeast','Orientation','vertical'); 
legend boxoff; 





subplot(4, 4,2)
basin_id = 2011400;  % basin in VA (cluster 1)

n_sa = load('./SA_metrics/n_delta_OUT_M_RMSE');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);
para_id_1 = find(basin_sa>0.3);
para_id_1_score = basin_sa(para_id_1);

data = readtable('../1500Ensemble/flow_metrics/OUT_M_NSE.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));

quantile95 = 0.5;

index = ensemble>=quantile95;
metric = ensemble(index);

SixMPG = ensemble;
pdSix = fitdist(SixMPG','Kernel','Width',0.05);
x = min(SixMPG)-20:0.01:max(SixMPG)+20;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [255, 127, 80]/255;
h1 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h1, .5); hold on;
xlim([-1, 1]);

SixMPG = metric;
pdSix = fitdist(SixMPG','Kernel','Width',0.02);
x = min(SixMPG)-20:0.01:max(SixMPG)+20;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [100 149 237]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;
xlim([-1, 1]);
box on; grid on;
set(gca,'color',[240 240 240]/255)
ylabel('Density', 'FontSize', label_size);
xlabel('NSE', 'FontSize', label_size);
title('(b) Monthly Flow NSE ≥ 0.5', 'FontSize', label_size);



subplot(4,4,3)

basin_id = 2011400;  % basin in VA (cluster 1)

n_sa = load('./SA_metrics/n_delta_OUT_D_KGE');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);
para_id_1 = find(basin_sa>0.50);
para_id_1_score = basin_sa(para_id_1);

data = readtable('../1500Ensemble/flow_metrics/OUT_D_KGE.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));
par3 = para_ensemble(:,para_id_1(3));

quantile95 = 0.3;

index = ensemble>=quantile95;
metric = ensemble(index);

SixMPG = ensemble;
pdSix = fitdist(SixMPG','Kernel','Width',0.05);
x = min(SixMPG)-10:0.1:max(SixMPG)+10;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [255, 127, 80]/255;
h1 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h1, .5); hold on;
xlim([-1, 1]);

SixMPG = metric;
pdSix = fitdist(SixMPG','Kernel','Width',0.01);
x = min(SixMPG)-10:0.1:max(SixMPG)+10;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [100 149 237]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;
xlim([-1, 1]);
box on; grid on;
set(gca,'color',[240 240 240]/255)
ylabel('Density', 'FontSize', label_size);
xlabel('KGE', 'FontSize', label_size);
title('(c) Daily Flow KGE ≥ 0.3', 'FontSize', label_size);


subplot(4,4,4)
basin_id = 2011400;  % basin in VA (cluster 1)

n_sa = load('./SA_metrics/n_delta_OUT_daily_volume_bias');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);
para_id_1 = find(basin_sa>0.4);
para_id_1_score = basin_sa(para_id_1);

data = readtable('../1500Ensemble/flow_metrics/OUT_daily_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));
par3 = para_ensemble(:,para_id_1(3));

quantile95 = 10;

index = abs(ensemble)<=quantile95;
metric = ensemble(index);

SixMPG = ensemble;
pdSix = fitdist(SixMPG','Kernel','Width',3);
x = min(SixMPG)-10:0.1:max(SixMPG)+10;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [255, 127, 80]/255;
h1 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h1, .5); hold on;
xlim([-60, 30]);

SixMPG = metric;
pdSix = fitdist(SixMPG','Kernel','Width',2);
x = min(SixMPG)-20:0.1:max(SixMPG)+20;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [100 149 237]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;
xlim([-60, 30]);
box on; grid on;
set(gca,'color',[240 240 240]/255)
ylabel('Density', 'FontSize', label_size);
xlabel('Bias (%)', 'FontSize', label_size);
title('(d) Abs. Annual Flow Volume Bias ≤ 10%', 'FontSize', label_size);


subplot(4,4,5)
prior = load('parameter_ensemble_LHS1500');
prior = prior(:,12);
prior1 = prior;

succ_id = load('../gen_ensemble_par_LHS/sucessful_par_id');
prior = prior(succ_id);

data = readtable('../1500Ensemble/flow_metrics/OUT_daily_q0_10_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));

quantile95 = 50;

index = abs(ensemble)<=quantile95;
post = prior(index);

SixMPG = prior1;
pdSix = fitdist(SixMPG,'Kernel','Width',0.1);
x = min(SixMPG)-1:0.1:max(SixMPG)+1;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [255, 127, 80]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;

SixMPG = post;
pdSix = fitdist(SixMPG,'Kernel','Width',0.05);
x = min(SixMPG)-1:0.1:max(SixMPG)+2;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [100 149 237]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;


xlim([0, 2]);
box on; grid on;
set(gca,'color',[240 240 240]/255)
ylabel('Density', 'FontSize', label_size);
xlabel('Parameter Value', 'FontSize', label_size);
title('(e) P_{lip} (1.00)', 'FontSize', label_size);
% ylim([0, 1.5]);

subplot(4,4,6)
prior = load('parameter_ensemble_LHS1500');
prior = prior(:,1);
prior1 = prior;

succ_id = load('../gen_ensemble_par_LHS/sucessful_par_id');
prior = prior(succ_id);

data = readtable('../1500Ensemble/flow_metrics/OUT_M_NSE.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));

quantile95 = 0.5;

index = ensemble>=quantile95;

post = prior(index);

SixMPG = prior1;
pdSix = fitdist(SixMPG,'Kernel','Width',0.1);
x = min(SixMPG)-1:0.1:max(SixMPG)+1;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [255, 127, 80]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;

SixMPG = post;
pdSix = fitdist(SixMPG,'Kernel','Width',0.2);
x = min(SixMPG)-1:0.1:max(SixMPG)+2;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [100 149 237]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;


xlim([0, 5]);
box on; grid on;
set(gca,'color',[240 240 240]/255)
ylabel('Density', 'FontSize', label_size);
xlabel('Parameter Value', 'FontSize', label_size);
title('(f) fff (1.00)', 'FontSize', label_size);
ylim([0,0.8]);

subplot(4,4,7)
prior = load('parameter_ensemble_LHS1500');
prior = prior(:,8);
prior1 = prior;

succ_id = load('../gen_ensemble_par_LHS/sucessful_par_id');
prior = prior(succ_id);

data = readtable('../1500Ensemble/flow_metrics/OUT_D_KGE.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));
par3 = para_ensemble(:,para_id_1(3));

quantile95 = 0.3;

index = ensemble>=quantile95;

post = prior(index);

SixMPG = prior1;
pdSix = fitdist(SixMPG,'Kernel','Width',0.01);
x = min(SixMPG)-1:0.1:max(SixMPG)+1;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [255, 127, 80]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;

SixMPG = post;
pdSix = fitdist(SixMPG,'Kernel','Width',0.01);
x = min(SixMPG)-1:0.1:max(SixMPG)+2;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [100 149 237]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;


xlim([0.8, 1.2]);
% ylim([0, 1]);
box on; grid on;
set(gca,'color',[240 240 240]/255)
ylabel('Density', 'FontSize', label_size);
xlabel('Parameter Value', 'FontSize', label_size);
title('(g) Ɵ_{sat} (1.00)', 'FontSize', label_size);



subplot(4,4,8)
prior = load('parameter_ensemble_LHS1500');
prior = prior(:,12);
prior1 = prior;

succ_id = load('../gen_ensemble_par_LHS/sucessful_par_id');
prior = prior(succ_id);
data = readtable('../1500Ensemble/flow_metrics/OUT_daily_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));
par3 = para_ensemble(:,para_id_1(3));

quantile95 = 10;

index = abs(ensemble)<=quantile95;

post = prior(index);

SixMPG = prior1;
pdSix = fitdist(SixMPG,'Kernel','Width',0.1);
x = min(SixMPG)-1:0.1:max(SixMPG)+1;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [255, 127, 80]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;

SixMPG = post;
pdSix = fitdist(SixMPG,'Kernel','Width',0.1);
x = min(SixMPG)-1:0.1:max(SixMPG)+2;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [100 149 237]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;


xlim([0, 2]);
% ylim([0, 1]);
box on; grid on;
set(gca,'color',[240 240 240]/255)
ylabel('Density', 'FontSize', label_size);
xlabel('Parameter Value', 'FontSize', label_size);
title('(h) P_{lip} (1.00)', 'FontSize', label_size);



subplot(4,4,9)
prior = load('parameter_ensemble_LHS1500');
prior = prior(:,1);
prior1 = prior;

succ_id = load('../gen_ensemble_par_LHS/sucessful_par_id');
prior = prior(succ_id);

data = readtable('../1500Ensemble/flow_metrics/OUT_daily_q0_10_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));

quantile95 = 50;

index = abs(ensemble)<=quantile95;
post = prior(index);

SixMPG = prior1;
pdSix = fitdist(SixMPG,'Kernel','Width',0.1);
x = min(SixMPG)-1:0.1:max(SixMPG)+1;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [255, 127, 80]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;

SixMPG = post;
pdSix = fitdist(SixMPG,'Kernel','Width',0.2);
x = min(SixMPG)-1:0.1:max(SixMPG)+5;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [100 149 237]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;


xlim([0, 5]);
box on; grid on;
set(gca,'color',[240 240 240]/255)
ylabel('Density', 'FontSize', label_size);
xlabel('Parameter Value', 'FontSize', label_size);
title('(i) fff (0.57)', 'FontSize', label_size);
% ylim([0, 0.8]);




subplot(4,4,10)
prior = load('parameter_ensemble_LHS1500');
prior = prior(:,6);
prior1 = prior;

succ_id = load('../gen_ensemble_par_LHS/sucessful_par_id');
prior = prior(succ_id);

data = readtable('../1500Ensemble/flow_metrics/OUT_M_NSE.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));

quantile95 = 0.5;

index = ensemble>=quantile95;

post = prior(index);

SixMPG = prior1;
pdSix = fitdist(SixMPG,'Kernel','Width',0.1);
x = min(SixMPG)-1:0.1:max(SixMPG)+1;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [255, 127, 80]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;

SixMPG = post;
pdSix = fitdist(SixMPG,'Kernel','Width',0.4);
x = min(SixMPG)-1:0.1:max(SixMPG)+2;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [100 149 237]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;

xlim([0, 5]);
box on; grid on;
set(gca,'color',[240 240 240]/255)
ylabel('Density', 'FontSize', label_size);
xlabel('Parameter Value', 'FontSize', label_size);
title('(j) ψ_{sat} (0.54)', 'FontSize', label_size);



subplot(4,4,11)
prior = load('parameter_ensemble_LHS1500');
prior = prior(:,1);
prior1 = prior;

succ_id = load('../gen_ensemble_par_LHS/sucessful_par_id');
prior = prior(succ_id);

data = readtable('../1500Ensemble/flow_metrics/OUT_D_KGE.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));
par3 = para_ensemble(:,para_id_1(3));

quantile95 = 0.3;

index = ensemble>=quantile95;

post = prior(index);

SixMPG = prior1;
pdSix = fitdist(SixMPG,'Kernel','Width',0.1);
x = min(SixMPG)-1:0.1:max(SixMPG)+1;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [255, 127, 80]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;

SixMPG = post;
pdSix = fitdist(SixMPG,'Kernel','Width',0.3);
x = min(SixMPG)-1:0.1:max(SixMPG)+2;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [100 149 237]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;

xlim([0, 5]);
% ylim([0, 1]);
box on; grid on;
set(gca,'color',[240 240 240]/255)
ylabel('Density', 'FontSize', label_size);
xlabel('Parameter Value', 'FontSize', label_size);
title('(k) fff (0.83)', 'FontSize', label_size);



subplot(4,4,12)
prior = load('parameter_ensemble_LHS1500');
prior = prior(:,8);
prior1 = prior;

succ_id = load('../gen_ensemble_par_LHS/sucessful_par_id');
prior = prior(succ_id);
data = readtable('../1500Ensemble/flow_metrics/OUT_daily_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));
par3 = para_ensemble(:,para_id_1(3));

quantile95 = 10;

index = abs(ensemble)<=quantile95;

post = prior(index);

SixMPG = prior1;
pdSix = fitdist(SixMPG,'Kernel','Width',0.01);
x = min(SixMPG)-1:0.1:max(SixMPG)+1;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [255, 127, 80]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;

SixMPG = post;
pdSix = fitdist(SixMPG,'Kernel','Width',0.02);
x = min(SixMPG)-1:0.1:max(SixMPG)+2;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [100 149 237]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;


xlim([0.8, 1.2]);
% ylim([0, 1]);
box on; grid on;
set(gca,'color',[240 240 240]/255)
ylabel('Density', 'FontSize', label_size);
xlabel('Parameter Value', 'FontSize', label_size);
title('(l) Ɵ_{sat} (0.62)', 'FontSize', label_size);


% subplot(4,4,13)
% 
% subplot(4,4,13)




subplot(4,4,15)

prior = load('parameter_ensemble_LHS1500');
prior = prior(:,6);
prior1 = prior;

succ_id = load('../gen_ensemble_par_LHS/sucessful_par_id');
prior = prior(succ_id);

data = readtable('../1500Ensemble/flow_metrics/OUT_D_KGE.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));
par3 = para_ensemble(:,para_id_1(3));

quantile95 = 0.3;

index = ensemble>=quantile95;

post = prior(index);

SixMPG = prior1;
pdSix = fitdist(SixMPG,'Kernel','Width',0.1);
x = min(SixMPG)-1:0.1:max(SixMPG)+1;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [255, 127, 80]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;

SixMPG = post;
pdSix = fitdist(SixMPG,'Kernel','Width',0.3);
x = min(SixMPG)-1:0.1:max(SixMPG)+2;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [100 149 237]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;

xlim([0, 5]);
% ylim([0, 1]);
box on; grid on;
set(gca,'color',[240 240 240]/255)
ylabel('Density', 'FontSize', label_size);
xlabel('Parameter Value', 'FontSize', label_size);
title('(m) ψ_{sat} (0.51)', 'FontSize', label_size);





subplot(4,4,16)
prior = load('parameter_ensemble_LHS1500');
prior = prior(:,15);
prior1 = prior;

succ_id = load('../gen_ensemble_par_LHS/sucessful_par_id');
prior = prior(succ_id);
data = readtable('../1500Ensemble/flow_metrics/OUT_daily_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));
par3 = para_ensemble(:,para_id_1(3));

quantile95 = 10;

index = abs(ensemble)<=quantile95;

post = prior(index);

SixMPG = prior1;
pdSix = fitdist(SixMPG,'Kernel','Width',0.01);
x = min(SixMPG)-1:0.1:max(SixMPG)+1;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [255, 127, 80]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;

SixMPG = post;
pdSix = fitdist(SixMPG,'Kernel','Width',0.06);
x = min(SixMPG)-1:0.1:max(SixMPG)+2;  % must be 1xN
ySix = pdf(pdSix,x);
curve_high = ySix; % must be 1xN
curve_low  = zeros(1, length(curve_high));
x2 = [x, fliplr(x)]; 
inBetween = [curve_low , fliplr(curve_high)];  hold on; % must be 1x
c = [100 149 237]/255;
h2 = fill(x2, inBetween, c, 'LineStyle','none'); alpha(h2, .5); hold on;


xlim([0.5, 1]);
% ylim([0, 1]);
box on; grid on;
set(gca,'color',[240 240 240]/255)
ylabel('Density', 'FontSize', label_size);
xlabel('Parameter Value', 'FontSize', label_size);
title('(n) Ɵ_{ini} (0.48)', 'FontSize', label_size);




%% plot 3d parameter space: low flow vs high flow


para = load('./parameter_ensemble_LHS1500');
succ_id = load('./sucessful_par_id');
para_ensemble = nan(1307, 15);
for i = 1:1307
    para_ensemble(i,:) = para(succ_id(i),:);
end



subplot(2,2,1)

basin_id = 9065500;

n_sa = load('./SA_metrics/n_delta_OUT_daily_q0_10_volume_bias');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);
para_id_1 = find(basin_sa>0.5);
para_id_1_score = basin_sa(para_id_1);

data = readtable('../1500Ensemble/flow_metrics/OUT_daily_q0_10_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));
par3 = para_ensemble(:,para_id_1(3));

% quantile95 = quantile(abs(ensemble), 0.05);
quantile95 = quantile(abs(ensemble), 0.05);



scatter3(par1, par2, par3, scatter_size-5,  'MarkerFaceColor',[220 220 220]/255, 'MarkerEdgeColor',[220 220 220]/255); hold on;
scatter3(par1(abs(ensemble)<=quantile95), par2(abs(ensemble)<=quantile95), par3(abs(ensemble)<=quantile95), scatter_size-5,ensemble(abs(ensemble)<=quantile95),...
    'MarkerFaceColor',[240 128 128]/255, 'MarkerEdgeColor',[0 0 0]/255);  
% h = colorbar;  

xlabel(sprintf('sucsat_sf (%4.2f)', para_id_1_score(1)), 'FontSize', label_size, 'Interpreter', 'none'); 
ylabel(sprintf('hksat_sf (%4.2f)', para_id_1_score(2)), 'FontSize', label_size, 'Interpreter', 'none'); 
zlabel(sprintf('d_max (%4.2f)', para_id_1_score(3)), 'FontSize', label_size, 'Interpreter', 'none'); 
title('(a) Flow Volume Bias Quantiles 0-10%: Basin 09065500 in CO', 'FontSize',title_size);




subplot(2,2,2)
% plot monthly
n_sa = load('./SA_metrics/n_delta_OUT_daily_q90_100_volume_bias');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);

para_id_2 = find(basin_sa>0.65);  para_id_2 = para_id_1;
para_id_2_score = basin_sa(para_id_2);

data = readtable('../1500Ensemble/flow_metrics/OUT_daily_q90_100_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_2(1));
par2 = para_ensemble(:,para_id_2(2));
par3 = para_ensemble(:,para_id_2(3));

quantile95 = quantile(abs(ensemble), 0.05);

scatter3(par1, par2, par3, scatter_size-5,  'MarkerFaceColor',[220 220 220]/255, 'MarkerEdgeColor',[220 220 220]/255); hold on;
scatter3(par1(abs(ensemble)<=quantile95), par2(abs(ensemble)<=quantile95), par3(abs(ensemble)<=quantile95), scatter_size-5,ensemble(abs(ensemble)<=quantile95),...
    'MarkerFaceColor',[100 149 237]/255, 'MarkerEdgeColor',[0 0 0]/255);  hold on;


xlabel(sprintf('sucsat_sf (%4.2f)', para_id_2_score(1)), 'FontSize', label_size, 'Interpreter', 'none'); 
ylabel(sprintf('hksat_sf (%4.2f)', para_id_2_score(2)), 'FontSize', label_size, 'Interpreter', 'none'); 
zlabel(sprintf('d_max (%4.2f)', para_id_2_score(3)), 'FontSize', label_size, 'Interpreter', 'none'); 
title('(b) Flow Volume Bias Quantiles 90-100%: Basin 09065500 in CO', 'FontSize',title_size);




subplot(2,2,3)

basin_id = 2011400;

n_sa = load('./SA_metrics/n_delta_OUT_daily_q0_10_volume_bias');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);
para_id_1 = find(basin_sa>0.3);
para_id_1_score = basin_sa(para_id_1);

data = readtable('../1500Ensemble/flow_metrics/OUT_daily_q0_10_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_1(1));
par2 = para_ensemble(:,para_id_1(2));


quantile95 = quantile(abs(ensemble), 0.05);


scatter(par1, par2, scatter_size-5,  'MarkerFaceColor',[220 220 220]/255, 'MarkerEdgeColor',[220 220 220]/255); hold on;
scatter(par1(abs(ensemble)<=quantile95), par2(abs(ensemble)<=quantile95), scatter_size-5,ensemble(abs(ensemble)<=quantile95),...
    'MarkerFaceColor',[240 128 128]/255, 'MarkerEdgeColor',[0 0 0]/255);  
% h = colorbar;  

xlabel(sprintf('fff (%4.2f)', para_id_1_score(1)), 'FontSize', label_size, 'Interpreter', 'none'); 
ylabel(sprintf('p_{lip} (%4.2f)', para_id_1_score(2)), 'FontSize', label_size); 
% zlabel(sprintf('frac_sat_soil_dsl_init (%4.2f)', para_id_1_score(3)), 'FontSize', label_size, 'Interpreter', 'none'); 
title('(c) Flow Volume Bias Quantiles 0-10%: Basin 02011400 in VA', 'FontSize',title_size);




subplot(2,2,4)
% plot monthly
n_sa = load('./SA_metrics/n_delta_OUT_daily_q90_100_volume_bias');
basin_sa = n_sa(n_sa(:,1)==basin_id,5:19);

para_id_2 = find(basin_sa>0.65);  para_id_2 = para_id_1;
para_id_2_score = basin_sa(para_id_2);

data = readtable('../1500Ensemble/flow_metrics/OUT_daily_q90_100_volume_bias.csv');
lat = data.Var2; lon = data.Var3; cluster = data.Var4; basin_ID = data.Var1;
ensemble = data{:,5:end-1};
ensemble(ensemble(:)==-9999) = nan;
ensemble = ensemble(basin_ID==basin_id,:);

par1 = para_ensemble(:,para_id_2(1));
par2 = para_ensemble(:,para_id_2(2));
% par3 = para_ensemble(:,para_id_2(3));

quantile95 = quantile(abs(ensemble), 0.05);

scatter(par1, par2, scatter_size-5,  'MarkerFaceColor',[220 220 220]/255, 'MarkerEdgeColor',[220 220 220]/255); hold on;
scatter(par1(abs(ensemble)<=quantile95), par2(abs(ensemble)<=quantile95), scatter_size-5,ensemble(abs(ensemble)<=quantile95),...
    'MarkerFaceColor',[100 149 237]/255, 'MarkerEdgeColor',[0 0 0]/255);  hold on;



xlabel(sprintf('fff (%4.2f)', para_id_2_score(1)), 'FontSize', label_size, 'Interpreter', 'none'); 
ylabel(sprintf('liq_canopy_storage_scalar (%4.2f)', para_id_2_score(2)), 'FontSize', label_size, 'Interpreter', 'none'); 
% zlabel(sprintf('frac_sat_soil_dsl_init (%4.2f)', para_id_2_score(3)), 'FontSize', label_size, 'Interpreter', 'none'); 
title('(d) Flow Volume Bias Quantiles 90-100%: Basin 02011400 in VA', 'FontSize',title_size);



%% plot the matrix plot for multiple metric
subplot(2,3,1)
n_sa = load('./SA_metrics/n_delta_OUT_daily_q0_10_volume_bias');

% rank by cluster
r_sa = sortrows(n_sa,4);

score = r_sa(:,5:end);

% find a threshold
% score(score(:)<0.4)=0;
% score(score(:)>=0.4)=1;

imagesc(score ); hold on; 
h = colorbar; 
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')
ylabel('Basin Number', 'FontSize', label_size); 
xlabel('Parameter Number', 'FontSize', label_size); 
xticks(1:15);

% plot the cluster horizational line
lines_num = nan(7,1);
for i = 1:7
    index = find(r_sa(:,4)==i);
    lines_num(i,1) = index(end);
end

for i = 1:6
   line([0,16],[lines_num(i,1), lines_num(i,1)], 'color',[255 0 0 ]/255,  'Linewidth',line_width+1 ); hold on;
end
title('(a) Flow Quantiles 0-10% Volume Bias', 'FontSize',title_size);


subplot(2,3,2)
n_sa = load('./SA_metrics/n_delta_OUT_daily_q10_25_volume_bias');

% rank by cluster
r_sa = sortrows(n_sa,4);

score = r_sa(:,5:end);

% find a threshold
% score(score(:)<0.4)=0;
% score(score(:)>=0.4)=1;

imagesc(score ); hold on; 
h = colorbar; 
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')
ylabel('Basin Number', 'FontSize', label_size); 
xlabel('Parameter Number', 'FontSize', label_size); 
xticks(1:15);

% plot the cluster horizational line
lines_num = nan(7,1);
for i = 1:7
    index = find(r_sa(:,4)==i);
    lines_num(i,1) = index(end);
end

for i = 1:6
   line([0,16],[lines_num(i,1), lines_num(i,1)], 'color',[255 0 0 ]/255,  'Linewidth',line_width+1 ); hold on;
end
title('(b) Flow Quantiles 10-25% Volume Bias', 'FontSize',title_size);



subplot(2,3,3)
n_sa = load('./SA_metrics/n_delta_OUT_daily_q25_50_volume_bias');

% rank by cluster
r_sa = sortrows(n_sa,4);

score = r_sa(:,5:end);

% find a threshold
% score(score(:)<0.4)=0;
% score(score(:)>=0.4)=1;

imagesc(score ); hold on; 
h = colorbar; 
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')
ylabel('Basin Number', 'FontSize', label_size); 
xlabel('Parameter Number', 'FontSize', label_size); 
xticks(1:15);

% plot the cluster horizational line
lines_num = nan(7,1);
for i = 1:7
    index = find(r_sa(:,4)==i);
    lines_num(i,1) = index(end);
end

for i = 1:6
   line([0,16],[lines_num(i,1), lines_num(i,1)], 'color',[255 0 0 ]/255,  'Linewidth',line_width+1 ); hold on;
end
title('(c) Flow Quantiles 25-50% Volume Bias', 'FontSize',title_size);





subplot(2,3,4)
n_sa = load('./SA_metrics/n_delta_OUT_daily_q50_75_volume_bias');

% rank by cluster
r_sa = sortrows(n_sa,4);

score = r_sa(:,5:end);

% find a threshold
% score(score(:)<0.4)=0;
% score(score(:)>=0.4)=1;

imagesc(score ); hold on; 
h = colorbar; 
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')
ylabel('Basin Number', 'FontSize', label_size); 
xlabel('Parameter Number', 'FontSize', label_size); 
xticks(1:15);

% plot the cluster horizational line
lines_num = nan(7,1);
for i = 1:7
    index = find(r_sa(:,4)==i);
    lines_num(i,1) = index(end);
end

for i = 1:6
   line([0,16],[lines_num(i,1), lines_num(i,1)], 'color',[255 0 0 ]/255,  'Linewidth',line_width+1 ); hold on;
end
title('(d) Flow Quantiles 50-75% Volume Bias', 'FontSize',title_size);



subplot(2,3,5)
n_sa = load('./SA_metrics/n_delta_OUT_daily_q75_90_volume_bias');

% rank by cluster
r_sa = sortrows(n_sa,4);

score = r_sa(:,5:end);

% find a threshold
% score(score(:)<0.4)=0;
% score(score(:)>=0.4)=1;

imagesc(score ); hold on; 
h = colorbar; 
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')
ylabel('Basin Number', 'FontSize', label_size); 
xlabel('Parameter Number', 'FontSize', label_size); 
xticks(1:15);

% plot the cluster horizational line
lines_num = nan(7,1);
for i = 1:7
    index = find(r_sa(:,4)==i);
    lines_num(i,1) = index(end);
end

for i = 1:6
   line([0,16],[lines_num(i,1), lines_num(i,1)], 'color',[255 0 0 ]/255,  'Linewidth',line_width+1 ); hold on;
end
title('(e) Flow Quantiles 75-90% Volume Bias', 'FontSize',title_size);


subplot(2,3,6)
n_sa = load('./SA_metrics/n_delta_OUT_daily_q90_100_volume_bias');

% rank by cluster
r_sa = sortrows(n_sa,4);

score = r_sa(:,5:end);

% find a threshold
% score(score(:)<0.4)=0;
% score(score(:)>=0.4)=1;

imagesc(score ); hold on; 
h = colorbar; 
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')
ylabel('Basin Number', 'FontSize', label_size); 
xlabel('Parameter Number', 'FontSize', label_size); 
xticks(1:15);

% plot the cluster horizational line
lines_num = nan(7,1);
for i = 1:7
    index = find(r_sa(:,4)==i);
    lines_num(i,1) = index(end);
end

for i = 1:6
   line([0,16],[lines_num(i,1), lines_num(i,1)], 'color',[255 0 0 ]/255,  'Linewidth',line_width+1 ); hold on;
end
title('(f) Flow Quantiles 90-100% Volume Bias', 'FontSize',title_size);



%% matrix for seasonal 

subplot(2,2,1)
n_sa = load('./SA_metrics/n_delta_OUT_daily_winter_volume_bias');

% rank by cluster
r_sa = sortrows(n_sa,4);

score = r_sa(:,5:end);

% find a threshold
% score(score(:)<0.4)=0;
% score(score(:)>=0.4)=1;

imagesc(score ); hold on; 
h = colorbar; 
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')
ylabel('Basin Number', 'FontSize', label_size); 
xlabel('Parameter Number', 'FontSize', label_size); 
xticks(1:15);

% plot the cluster horizational line
lines_num = nan(7,1);
for i = 1:7
    index = find(r_sa(:,4)==i);
    lines_num(i,1) = index(end);
end

for i = 1:6
   line([0,16],[lines_num(i,1), lines_num(i,1)], 'color',[255 0 0 ]/255,  'Linewidth',line_width+1 ); hold on;
end
title('(a) Winter Volume Bias', 'FontSize',title_size);






subplot(2,2,2)
n_sa = load('./SA_metrics/n_delta_OUT_daily_spring_volume_bias');

% rank by cluster
r_sa = sortrows(n_sa,4);

score = r_sa(:,5:end);

% find a threshold
% score(score(:)<0.4)=0;
% score(score(:)>=0.4)=1;

imagesc(score ); hold on; 
h = colorbar; 
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')
ylabel('Basin Number', 'FontSize', label_size); 
xlabel('Parameter Number', 'FontSize', label_size); 
xticks(1:15);

% plot the cluster horizational line
lines_num = nan(7,1);
for i = 1:7
    index = find(r_sa(:,4)==i);
    lines_num(i,1) = index(end);
end

for i = 1:6
   line([0,16],[lines_num(i,1), lines_num(i,1)], 'color',[255 0 0 ]/255,  'Linewidth',line_width+1 ); hold on;
end
title('(b) Spring Volume Bias', 'FontSize',title_size);




subplot(2,2,3)
n_sa = load('./SA_metrics/n_delta_OUT_daily_summer_volume_bias');

% rank by cluster
r_sa = sortrows(n_sa,4);

score = r_sa(:,5:end);

% find a threshold
% score(score(:)<0.4)=0;
% score(score(:)>=0.4)=1;

imagesc(score ); hold on; 
h = colorbar; 
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')
ylabel('Basin Number', 'FontSize', label_size); 
xlabel('Parameter Number', 'FontSize', label_size); 
xticks(1:15);

% plot the cluster horizational line
lines_num = nan(7,1);
for i = 1:7
    index = find(r_sa(:,4)==i);
    lines_num(i,1) = index(end);
end

for i = 1:6
   line([0,16],[lines_num(i,1), lines_num(i,1)], 'color',[255 0 0 ]/255,  'Linewidth',line_width+1 ); hold on;
end
title('(c) Summer Volume Bias', 'FontSize',title_size);





subplot(2,2,4)
n_sa = load('./SA_metrics/n_delta_OUT_daily_fall_volume_bias');

% rank by cluster
r_sa = sortrows(n_sa,4);

score = r_sa(:,5:end);

% find a threshold
% score(score(:)<0.4)=0;
% score(score(:)>=0.4)=1;

imagesc(score ); hold on; 
h = colorbar; 
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')
ylabel('Basin Number', 'FontSize', label_size); 
xlabel('Parameter Number', 'FontSize', label_size); 
xticks(1:15);

% plot the cluster horizational line
lines_num = nan(7,1);
for i = 1:7
    index = find(r_sa(:,4)==i);
    lines_num(i,1) = index(end);
end

for i = 1:6
   line([0,16],[lines_num(i,1), lines_num(i,1)], 'color',[255 0 0 ]/255,  'Linewidth',line_width+1 ); hold on;
end
title('(d) Fall Volume Bias', 'FontSize',title_size);




%% plot regional sum SA scores for 1 metric 
n_sa = load('./SA_metrics/n_delta_OUT_D_KGE');

% rank by cluster
r_sa = sortrows(n_sa,4);

score = r_sa(:,5:end);

subplot(3,3,1)
metric = r_sa(r_sa(:,4)==1,:);
sum_SA = nansum(metric(:,5:end),1);
n_sum_SA = sum_SA;
for i = 1:15
    n_sum_SA(i) = (sum_SA(i) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
end
sum_SA = n_sum_SA;

bar(sum_SA, 'FaceColor',[220 220 220]/255,'EdgeColor',[0 0 0]/255,'LineWidth',line_width);
xlabel('Parameter'); ylabel('Sensitivity Scores');
title('(a): Cluster 1', 'FontSize', title_size); xlim([0,16]);

subplot(3,3,2)
metric = r_sa(r_sa(:,4)==2,:);
sum_SA = nansum(metric(:,5:end),1);
n_sum_SA = sum_SA;
for i = 1:15
    n_sum_SA(i) = (sum_SA(i) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
end
sum_SA = n_sum_SA;

bar(sum_SA, 'FaceColor',[220 220 220]/255,'EdgeColor',[0 0 0]/255,'LineWidth',line_width);
xlabel('Parameter'); ylabel('Sensitivity Scores');
title('(b): Cluster 2', 'FontSize', title_size); xlim([0,16]);

subplot(3,3,3)
metric = r_sa(r_sa(:,4)==3,:);
sum_SA = nansum(metric(:,5:end),1);
n_sum_SA = sum_SA;
for i = 1:15
    n_sum_SA(i) = (sum_SA(i) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
end
sum_SA = n_sum_SA;

bar(sum_SA, 'FaceColor',[220 220 220]/255,'EdgeColor',[0 0 0]/255,'LineWidth',line_width);
xlabel('Parameter'); ylabel('Sensitivity Scores');
title('(c): Cluster 3', 'FontSize', title_size); xlim([0,16]);

subplot(3,3,4)
metric = r_sa(r_sa(:,4)==4,:);
sum_SA = nansum(metric(:,5:end),1);
n_sum_SA = sum_SA;
for i = 1:15
    n_sum_SA(i) = (sum_SA(i) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
end
sum_SA = n_sum_SA;

bar(sum_SA, 'FaceColor',[220 220 220]/255,'EdgeColor',[0 0 0]/255,'LineWidth',line_width);
xlabel('Parameter'); ylabel('Sensitivity Scores');
title('(d): Cluster 4', 'FontSize', title_size); xlim([0,16]);

subplot(3,3,5)
metric = r_sa(r_sa(:,4)==5,:);
sum_SA = nansum(metric(:,5:end),1);
n_sum_SA = sum_SA;
for i = 1:15
    n_sum_SA(i) = (sum_SA(i) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
end
sum_SA = n_sum_SA;

bar(sum_SA, 'FaceColor',[220 220 220]/255,'EdgeColor',[0 0 0]/255,'LineWidth',line_width);
xlabel('Parameter'); ylabel('Sensitivity Scores');
title('(e): Cluster 5', 'FontSize', title_size); xlim([0,16]);

subplot(3,3,6)
metric = r_sa(r_sa(:,4)==6,:);
sum_SA = nansum(metric(:,5:end),1);
n_sum_SA = sum_SA;
for i = 1:15
    n_sum_SA(i) = (sum_SA(i) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
end
sum_SA = n_sum_SA;

bar(sum_SA, 'FaceColor',[220 220 220]/255,'EdgeColor',[0 0 0]/255,'LineWidth',line_width);
xlabel('Parameter'); ylabel('Sensitivity Scores');
title('(f): Cluster 6', 'FontSize', title_size); xlim([0,16]);

subplot(3,3,7)
metric = r_sa(r_sa(:,4)==7,:);
sum_SA = nansum(metric(:,5:end),1);
n_sum_SA = sum_SA;
for i = 1:15
    n_sum_SA(i) = (sum_SA(i) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
end
sum_SA = n_sum_SA;

bar(sum_SA, 'FaceColor',[220 220 220]/255,'EdgeColor',[0 0 0]/255,'LineWidth',line_width);
xlabel('Parameter'); ylabel('Sensitivity Scores');
title('(g): Cluster 7', 'FontSize', title_size); 
xlim([0,16]);

subplot(3,3,8)
US = load('../1500Ensemble/us_coor.txt');
SL = load('../1500Ensemble/sl_coor.txt');
data = readtable('../1500Ensemble/flow_metrics/default_monthly_metrics.csv');
lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
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
metric = r_sa;
sum_SA = nansum(metric(:,5:end),1);
n_sum_SA = sum_SA;
for i = 1:15
    n_sum_SA(i) = (sum_SA(i) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
end
sum_SA = n_sum_SA;

bar(sum_SA, 'FaceColor',[220 220 220]/255,'EdgeColor',[0 0 0]/255,'LineWidth',line_width);
xlabel('Parameter'); ylabel('Sensitivity Scores');
title('(i): All Basin', 'FontSize', title_size); 
xlim([0,16]);



%% plot matrix: parameter vs metrics for different clusters
metric = {'D_KGE', 'D_MAE', 'D_NSE', 'D_RMSE', 'D_TRMSE', 'M_KGE', 'M_MAE', 'M_NSE', 'M_RMSE', 'M_TRMSE', 'daily_variance_bias', ...
          'monthly_variance_bias', 'daily_volume_bias', 'daily_q0_10_volume_bias', 'daily_q10_25_volume_bias', 'daily_q25_50_volume_bias',...
          'daily_q50_75_volume_bias', 'daily_q75_90_volume_bias', 'daily_q90_100_volume_bias', 'daily_winter_volume_bias', ...
          'daily_spring_volume_bias', 'daily_summer_volume_bias', 'daily_fall_volume_bias'};
      
      
      
label_size = 12; line_width = 1; tick_size = 12; legend_size = 11;
title_size = 12; tick_size = 12; text_size = 12; scatter_size = 15; colorbar_size= 12;      
      
      
      
subplot(3,3,1)
cluster = 1;
matrix = nan(15, length(metric));     
for i = 1:length(metric)
    n_sa = load(sprintf('./SA_metrics/n_delta_OUT_%s', metric{i}));
    % rank by cluster
    r_sa = sortrows(n_sa,4);
    score = r_sa(:,5:end);
    metric1 = r_sa(r_sa(:,4)==cluster,:);
    sum_SA = nansum(metric1(:,5:end),1);
    for j = 1:15
        matrix(j,i) = (sum_SA(j) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
    end 
end

h1 = imagesc(matrix); hold on; 
caxis([0 1]);  colormap(brewermap([10],'*RdBu'));    
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')

x=1:15;
y=1:15; yticks(x); yticklabels({'fff', 'N_{bf}', 'K_{bf}', 'S_y', 'B', 'ψ_{sat}', 'k_{sat}', 'Ɵ_{sat}', 'N_{melt}', 'k_{acc}',...
    'p_{sno}', 'p_{lip}', 'f_{wet}', 'd_{max}', 'Ɵ_{ini}'});




xlabel('Metric Number', 'FontSize', label_size); 
ylabel('Parameters', 'FontSize', label_size); 
xticks(1:23);
title(sprintf('(a) Cluster %d-Northeast', cluster), 'FontSize', title_size); 

for i = 0.5:1:23.5
    line([i, i], [0 25], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

for i = 0.5:1:23.5
   line([0,25], [i , i], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

set(gca,'FontSize',tick_size);








subplot(3,3,2)
cluster = 2;
matrix = nan(15, length(metric));     
for i = 1:length(metric)
    n_sa = load(sprintf('./SA_metrics/n_delta_OUT_%s', metric{i}));
    % rank by cluster
    r_sa = sortrows(n_sa,4);
    score = r_sa(:,5:end);
    metric1 = r_sa(r_sa(:,4)==cluster,:);
    sum_SA = nansum(metric1(:,5:end),1);
    for j = 1:15
        matrix(j,i) = (sum_SA(j) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
    end 
end

h2 = imagesc(matrix); hold on; 
caxis([0 1]);  colormap(brewermap([10],'*RdBu'));    
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')


y=1:15; yticks(x); yticklabels({'fff', 'N_{bf}', 'K_{bf}', 'S_y', 'B', 'ψ_{sat}', 'k_{sat}', 'Ɵ_{sat}', 'N_{melt}', 'k_{acc}',...
    'p_{sno}', 'p_{lip}', 'f_{wet}', 'd_{max}', 'Ɵ_{ini}'});

xlabel('Metric Number', 'FontSize', label_size); 
ylabel('Parameters', 'FontSize', label_size); 
xticks(1:23);
title(sprintf('(b) Cluster %d-Pacific', cluster), 'FontSize', title_size); 

for i = 0.5:1:23.5
    line([i, i], [0 25], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

for i = 0.5:1:23.5
   line([0,25], [i , i], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

set(gca,'FontSize',tick_size);








subplot(3,3,3)
cluster = 3;
matrix = nan(15, length(metric));     
for i = 1:length(metric)
    n_sa = load(sprintf('./SA_metrics/n_delta_OUT_%s', metric{i}));
    % rank by cluster
    r_sa = sortrows(n_sa,4);
    score = r_sa(:,5:end);
    metric1 = r_sa(r_sa(:,4)==cluster,:);
    sum_SA = nansum(metric1(:,5:end),1);
    for j = 1:15
        matrix(j,i) = (sum_SA(j) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
    end 
end

h3 = imagesc(matrix); hold on; 
caxis([0 1]);  colormap(brewermap([10],'*RdBu'));    
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')


y=1:15; yticks(x); yticklabels({'fff', 'N_{bf}', 'K_{bf}', 'S_y', 'B', 'ψ_{sat}', 'k_{sat}', 'Ɵ_{sat}', 'N_{melt}', 'k_{acc}',...
    'p_{sno}', 'p_{lip}', 'f_{wet}', 'd_{max}', 'Ɵ_{ini}'});

xlabel('Metric Number', 'FontSize', label_size); 
ylabel('Parameters', 'FontSize', label_size); 
xticks(1:23);
title(sprintf('(c) Cluster %d-AZ/NM', cluster), 'FontSize', title_size); 

for i = 0.5:1:23.5
    line([i, i], [0 25], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

for i = 0.5:1:23.5
   line([0,25], [i , i], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

set(gca,'FontSize',tick_size);



subplot(3,3,4)
cluster = 4;
matrix = nan(15, length(metric));     
for i = 1:length(metric)
    n_sa = load(sprintf('./SA_metrics/n_delta_OUT_%s', metric{i}));
    % rank by cluster
    r_sa = sortrows(n_sa,4);
    score = r_sa(:,5:end);
    metric1 = r_sa(r_sa(:,4)==cluster,:);
    sum_SA = nansum(metric1(:,5:end),1);
    for j = 1:15
        matrix(j,i) = (sum_SA(j) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
    end 
end

h4 = imagesc(matrix); hold on; 
caxis([0 1]);  colormap(brewermap([10],'*RdBu'));    
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')


y=1:15; yticks(x); yticklabels({'fff', 'N_{bf}', 'K_{bf}', 'S_y', 'B', 'ψ_{sat}', 'k_{sat}', 'Ɵ_{sat}', 'N_{melt}', 'k_{acc}',...
    'p_{sno}', 'p_{lip}', 'f_{wet}', 'd_{max}', 'Ɵ_{ini}'});

xlabel('Metric Number', 'FontSize', label_size); 
ylabel('Parameters', 'FontSize', label_size); 
xticks(1:23);
title(sprintf('(d) Cluster %d-Rockies', cluster), 'FontSize', title_size); 

for i = 0.5:1:23.5
    line([i, i], [0 25], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

for i = 0.5:1:23.5
   line([0,25], [i , i], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

set(gca,'FontSize',tick_size);



subplot(3,3,5)
cluster = 5;
matrix = nan(15, length(metric));     
for i = 1:length(metric)
    n_sa = load(sprintf('./SA_metrics/n_delta_OUT_%s', metric{i}));
    % rank by cluster
    r_sa = sortrows(n_sa,4);
    score = r_sa(:,5:end);
    metric1 = r_sa(r_sa(:,4)==cluster,:);
    sum_SA = nansum(metric1(:,5:end),1);
    for j = 1:15
        matrix(j,i) = (sum_SA(j) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
    end 
end

h5 = imagesc(matrix); hold on; 
caxis([0 1]);  colormap(brewermap([10],'*RdBu'));    
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')


y=1:15; yticks(x); yticklabels({'fff', 'N_{bf}', 'K_{bf}', 'S_y', 'B', 'ψ_{sat}', 'k_{sat}', 'Ɵ_{sat}', 'N_{melt}', 'k_{acc}',...
    'p_{sno}', 'p_{lip}', 'f_{wet}', 'd_{max}', 'Ɵ_{ini}'});

xlabel('Metric Number', 'FontSize', label_size); 
ylabel('Parameters', 'FontSize', label_size); 
xticks(1:23);
title(sprintf('(e) Cluster %d-Great Plains', cluster), 'FontSize', title_size); 

for i = 0.5:1:23.5
    line([i, i], [0 25], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

for i = 0.5:1:23.5
   line([0,25], [i , i], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

set(gca,'FontSize',tick_size);



subplot(3,3,6)
cluster = 6;
matrix = nan(15, length(metric));     
for i = 1:length(metric)
    n_sa = load(sprintf('./SA_metrics/n_delta_OUT_%s', metric{i}));
    % rank by cluster
    r_sa = sortrows(n_sa,4);
    score = r_sa(:,5:end);
    metric1 = r_sa(r_sa(:,4)==cluster,:);
    sum_SA = nansum(metric1(:,5:end),1);
    for j = 1:15
        matrix(j,i) = (sum_SA(j) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
    end 
end

h6 = imagesc(matrix); hold on; 
caxis([0 1]);  colormap(brewermap([10],'*RdBu'));    
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')


y=1:15; yticks(x); yticklabels({'fff', 'N_{bf}', 'K_{bf}', 'S_y', 'B', 'ψ_{sat}', 'k_{sat}', 'Ɵ_{sat}', 'N_{melt}', 'k_{acc}',...
    'p_{sno}', 'p_{lip}', 'f_{wet}', 'd_{max}', 'Ɵ_{ini}'});

xlabel('Metric Number', 'FontSize', label_size); 
ylabel('Parameters', 'FontSize', label_size); 
xticks(1:23);
title(sprintf('(f) Cluster %d-Great Lakes', cluster), 'FontSize', title_size); 

for i = 0.5:1:23.5
    line([i, i], [0 25], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

for i = 0.5:1:23.5
   line([0,25], [i , i], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

set(gca,'FontSize',tick_size);


subplot(3,3,7)
cluster = 7;
matrix = nan(15, length(metric));     
for i = 1:length(metric)
    n_sa = load(sprintf('./SA_metrics/n_delta_OUT_%s', metric{i}));
    % rank by cluster
    r_sa = sortrows(n_sa,4);
    score = r_sa(:,5:end);
    metric1 = r_sa(r_sa(:,4)==cluster,:);
    sum_SA = nansum(metric1(:,5:end),1);
    for j = 1:15
        matrix(j,i) = (sum_SA(j) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
    end 
end

h7 = imagesc(matrix); hold on; 
caxis([0 1]);  colormap(brewermap([10],'*RdBu'));    
%ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
set(gca,'YDir','normal')


y=1:15; yticks(x); yticklabels({'fff', 'N_{bf}', 'K_{bf}', 'S_y', 'B', 'ψ_{sat}', 'k_{sat}', 'Ɵ_{sat}', 'N_{melt}', 'k_{acc}',...
    'p_{sno}', 'p_{lip}', 'f_{wet}', 'd_{max}', 'Ɵ_{ini}'});

xlabel('Metric Number', 'FontSize', label_size); 
ylabel('Parameters', 'FontSize', label_size); 
xticks(1:23);
title(sprintf('(g) Cluster %d-Southeast', cluster), 'FontSize', title_size); 

for i = 0.5:1:23.5
    line([i, i], [0 25], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

for i = 0.5:1:23.5
   line([0,25], [i , i], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
end

set(gca,'FontSize',tick_size);
c=colorbar; 
colorbar('FontSize',colorbar_size)


% ax8 = subplot(3,3,8)
% US = load('../1500Ensemble/us_coor.txt');
% SL = load('../1500Ensemble/sl_coor.txt');
% data = readtable('../1500Ensemble/flow_metrics/default_monthly_metrics.csv');
% lat = data.Var2; lon = data.Var3; cluster_ID = data.Var4;
% h8 = scatter(lon, lat, 15, cluster_ID, 'filled'); hold on; 
% c=colorbar; 
% colormap(ax8, brewermap([7],'*Set2'));     colorbar('FontSize',colorbar_size)
% 
% 
% 
% xlim([-128 -64]); ylim([22 52]); box on;
% xlabel('Longitude', 'FontSize', label_size); 
% ylabel('Latitude', 'FontSize', label_size);
% title('(h): Cluster ID', 'FontSize', title_size); 
% box on;
% plot(US(:,1), US(:,2),'.','MarkerSize',2,'Color','black'); hold on; 
% plot(SL(:,1), SL(:,2),'.','MarkerSize',2,'Color','black');
% set(gca,'color',[240 240 240]/255)
% set(gca,'FontSize',tick_size);
% 
% 
% 
% subplot(3,3,9)
% matrix = nan(15, length(metric));     
% for i = 1:length(metric)
%     n_sa = load(sprintf('./SA_metrics/n_delta_OUT_%s', metric{i}));
%     % rank by cluster
%     r_sa = sortrows(n_sa,4);
%     score = r_sa(:,5:end);
%     metric1 = r_sa;
%     sum_SA = nansum(metric1(:,5:end),1);
%     for j = 1:15
%         matrix(j,i) = (sum_SA(j) - min(sum_SA)) / (max(sum_SA) - min(sum_SA));
%     end 
% end
% 
% h9 = imagesc(matrix); hold on; 
% caxis([0 1]);  colormap(brewermap([],'*RdBu'));    
% %ylabel(h, 'Normalized Sensitive Score', 'FontSize', label_size);
% set(gca,'YDir','normal')
% 
% 
% y=1:15; yticks(x); yticklabels({'fff', 'N_{bf}', 'K_{bf}', 'S_y', 'B', '?_{sat}', 'k_{sat}', '?_{sat}', 'N_{melt}', 'k_{acc}',...
%     'p_{sno}', 'p_{lip}', 'f_{wet}', 'd_{max}', '?_{ini}'});
% 
% xlabel('Metric Number', 'FontSize', label_size); 
% ylabel('Parameters', 'FontSize', label_size); 
% xticks(1:23);
% title('(i) CONUS', 'FontSize', title_size); 
% 
% for i = 0.5:1:23.5
%     line([i, i], [0 25], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
% end
% 
% for i = 0.5:1:23.5
%    line([0,25], [i , i], 'color',[0 0 0]/255,  'Linewidth', line_width, 'LineStyle','-' ); hold on;  
% end
% 
% set(gca,'FontSize',tick_size);







%% output the plot

fig = gcf;
fig.PaperUnits = 'inches';
set(gcf, 'InvertHardCopy', 'off');

% fig.PaperPosition = [0 0 18 7];
fig.PaperPosition = [0 0 15 8];
print('ScreenSizeFigure', '-dpng', '-r300')





