%main function
clear all;
clc;

time=zeros(18,3);
tmp=zeros(18,3);
icount=0;

%Synthetic_pure_rotation
%disp('Synthetic_pure_rotation**********************************************************
%
%load('Synthetic_pure_rotation2.mat')% the angle of rotation has been changed because last one simulate pure data in submited paper has been lossed.
%Update: ture: [angle | tranlation vector]: [10;-5;2| 0;0;0]
%[Rt,Rt_cq,tmp]=Universial_Relative_PoseV2s_test(K1,K2,Matches,0.001);
    
for j=1:10 %time iteration for 10 times (in order to avoid random error from machine) 
    clearvars -except time s icount;
    %synthetic 
    load('C:\Users\Administrator\Desktop\Relative_Pose_Estimations_Considering_Degeneracies_CV-master\Ready Dataset\Synthetic_Data.mat')
    %disp('synthetic data**********************************************************')
    for i=1:4
        [Rt,Rt_cq,tmp]=Universial_Relative_PoseV2s_test(K1,K2,Matches{i},0.001);
        time(i,:)=time(i,:)+tmp; 
        s(i,1)=size(Matches{i},2);
    end
%General struct
%disp('General data**********************************************************')
    clearvars -except time s icount;
    load('C:\Users\Administrator\Desktop\Relative_Pose_Estimations_Considering_Degeneracies_CV-master\Ready Dataset\General_Structure_Sequence_Data.mat')

    for i=1:5
        s(i+4,1)=size(Frame{i},2);   
        [Rt,Rt_cq,tmp]=Universial_Relative_PoseV2s_test(K1,K2,Frame{i},0.001);
           time(i+4,:)=time(i+4,:)+tmp;
           
    end
        
    
    
    clearvars -except time s icount;
%doodleWall
%disp('doodleWall data**********************************************************')
    load('C:\Users\Administrator\Desktop\Relative_Pose_Estimations_Considering_Degeneracies_CV-master\Ready Dataset\Doodle_Wall_Data.mat')
    i=1;    
    s(i+9,1)=size(matches,2);
    [Rt,Rt_cq,tmp]=Universial_Relative_PoseV2s_test(K,K,matches,0.001);
    time(i+9,:)=time(i+9,:)+tmp;    
    clearvars -except time s icount;
%Planar_struct
%disp('Planar_struct data**********************************************************')
    load('C:\Users\Administrator\Desktop\Relative_Pose_Estimations_Considering_Degeneracies_CV-master\Ready Dataset\Planar_Structure_Sequence_Data.mat')

    for i=1:4
        s(i+10,1)=size(Frame{i},2);
        [Rt,Rt_cq,tmp]=Universial_Relative_PoseV2s_test(K1,K2,Frame{i},0.001);
        time(i+10,:)=time(i+10,:)+tmp;
    end
    clearvars -except time s icount;
%pure_rotation
%disp('pure_rotation data**********************************************************')
    load('C:\Users\Administrator\Desktop\Relative_Pose_Estimations_Considering_Degeneracies_CV-master\Ready Dataset\Pure_Rotation_Sequence_Data.mat')

    for i=1:4
        s(i+14,1)=size(Frame{i},2);
        [Rt,Rt_cq,tmp]=Universial_Relative_PoseV2s_test(K1,K2,Frame{i},0.001);
        time(i+14,:)=time(i+14,:)+tmp;
    end
    icount=icount+1;
end

%mean time
time=time/icount;
%generate time cost/ratio figure
figure
hold on
[~,index]=sort(s);
tmp1=time(:,1);
tmp2=time(:,2);
tmp3=time(:,3);
plot(s(index),tmp1(index),'r')
plot(s(index),tmp2(index),'b')
plot(s(index),tmp3(index),'g')
grid on;
figure 
plot(s(index),tmp1(index)./tmp2(index),'.r')
hold on;
plot(s(index),tmp1(index)./tmp3(index),'.b')
grid on;




