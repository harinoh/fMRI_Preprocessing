clear all
clc

for i=1:70
    nameFormat = '/Volume/CCNC/harin_oh/1_thalamocortical/SCZOHC/QC/2_MotionCorrect/NOR%d_Morr_bef';
    FDRMS_file = sprintf(nameFormat,i);
    output_name = '/Volume/CCNC/harin_oh/1_thalamocortical/SCZOHC/QC/2_MotionCorrect/NOR%d';
    output_dir_name = sprintf(output_name,i);
    
    % Read in file and construct FDRMS vectors
    fd = dlmread(FDRMS_file); 
    
    % Check input variables
    if size(fd,2) > 1   
        error('Input argument ''FDRMS_file'' should list values in columns');
    end
    
    % Detect outliers with FDRMS threhold
    FD_th = 0.5;
    %FD_th = str2num(FD_th);
    % 1 means the frame below the threshold is kept, 0 means the frame above the threshold is removed
    FD_vect = (fd <= FD_th); 
    
    % Continue removing one frame before and two frames after
    FD_censor = (FD_vect & [FD_vect(2:end,1); 1] & [1; FD_vect(1:end-1)] & [1;1; FD_vect(1:end-2)]);  
    
    % Plot FD w/ threshold line
    pos_set = [0.08 0.55 0.89 0.4; ...     
        0.08 0.06 0.89 0.4];
    figure; 
    set(gcf,'Visible','off');
    set(gcf, 'Position', [0,0,960,800]);
    g = subplot(2,1,1);
    set(g, 'Position', pos_set(1,:));
    hold on
    plot(fd, 'LineWidth', 2);
    ti = title('FDRMS (in mm)');
    set(ti, 'FontSize', 18);
    ylabel('FD (mm)', 'FontSize', 18);
    xlim = get(gca, 'XLim');
    ylim = get(gca, 'YLim');
    MinorTicks = 0:floor(length(fd)/50):(length(fd));
    plot(repmat(MinorTicks, 2, 1), repmat([ylim(1); (ylim(2)-ylim(1))/100 + ylim(1)], 1, length(MinorTicks)), 'k');
    line([xlim(1) xlim(2)], [FD_th FD_th], 'color', 'r', 'LineWidth', 1.5);
    set(gca, 'XTick', [0: floor(length(fd)/10):length(fd)])
    set(gca, 'FontSize', 18)
    hold off
    set(gcf, 'PaperPositionMode', 'auto')
    print(gcf, [output_dir_name '_FDRMS' num2str(FD_th) '_rest_BEFORE.png'], '-dpng');
    clear xlim
    close(gcf);
    clear xlim
    
    % Combine DVARS and FDRMS so that a frame is either above FD_th or DV_th, it will be removed
    %FD_censor = [FD_censor];  
    
    %save output life
    outfilename_index = fopen([output_dir_name '_FDRMS' num2str(FD_th) '_rest_BEFORE_motion_outliers.txt'], 'w+');
    fprintf(outfilename_index, '%d\n', FD_censor);
end
