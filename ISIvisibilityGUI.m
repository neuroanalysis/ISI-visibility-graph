function varargout = ISIvisibilityGUI(varargin)
%ISIVISIBILITYGUI M-file for ISIvisibilityGUI.fig
%      ISIVISIBILITYGUI, by itself, creates a new ISIVISIBILITYGUI or raises the existing
%      singleton*.
%
%      H = ISIVISIBILITYGUI returns the handle to a new ISIVISIBILITYGUI or the handle to
%      the existing singleton*.
%
%      ISIVISIBILITYGUI('Property','Value',...) creates a new ISIVISIBILITYGUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to ISIvisibilityGUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      ISIVISIBILITYGUI('CALLBACK') and ISIVISIBILITYGUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in ISIVISIBILITYGUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ISIvisibilityGUI

% Last Modified by GUIDE v2.5 07-Dec-2016 20:27:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ISIvisibilityGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ISIvisibilityGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% Eliminated
% ISI_ANT_11 
% ISI_CTR_5_8_11_12 
% ISI_PRK_8_10


% --- Executes just before ISIvisibilityGUI is made visible.
function ISIvisibilityGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for ISIvisibilityGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
RefreshData(handles);

% UIWAIT makes ISIvisibilityGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function varargout = ISIvisibilityGUI_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

function lstData_Callback(hObject, eventdata, handles)

function lstData_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Functions
function RefreshData(handles)
DataStrings=evalin('base','who');
DataDefaults=[{'Regular tonic'};{'Regular bursting'};{'Random (uniformly)'};{...
    'Irregular (poisson)'};{'Irregular bursting (poisson x 2)'}];
set(handles.lstData,'String',[DataDefaults;DataStrings])

function ISI=GetISI(handles)
idx=get(handles.lstData,'value');

% for simulated data
total_time=200; 

switch(idx)
    case 1 % Regular tonic
        isi=0.1;
        ISI = ISI_regular(isi,total_time)';
    case 2 % Regular bursting
        isi=0.1; ibi=3; burst_size=10;
        ISI = ISI_regular_burst(isi,ibi,burst_size,total_time)';
    case 3 % Random (uniformly)
        min_isi=0.01; max_isi=0.2;
        ISI = ISI_random(min_isi, max_isi, total_time);
    case 4 % Irregular (poisson)
        min_isi=0.01; mean_isi=0.1;
        ISI = ISI_poisson_1(min_isi, mean_isi, total_time);
    case 5 % Irregular bursting (poisson x 2)
        %min_isi_1=0.01;mean_isi_1=0.1;percentage_1=0.3;min_isi_2=0.1;mean_isi_2=0.5;
        min_isi_1=0.01;mean_isi_1=0.1;percentage_1=0.3;min_isi_2=0.1;mean_isi_2=3;
        ISI = ISI_poisson_2(min_isi_1,mean_isi_1,percentage_1,min_isi_2,mean_isi_2,total_time);
    otherwise
        DataStrings=get(handles.lstData,'String');
        DataName=DataStrings{idx};
        Data=evalin('base',['exist(''' DataName ''')']);
        if Data
            ISI=evalin('base',DataName);
        else
            ISI=[];
            RefreshData(handles);
        end
end

function ISI=Adequacy(handles)
ISI=GetISI(handles);
if ~isempty(ISI)
    % Length limit
    N=str2double(get(handles.txtN,'String'));
    type=get(handles.lstType,'value');
    if (type==1)
        type='spikes';
    else
        type='seconds';
    end
    ISI=ISI_limited_by(ISI,N,type);
    
    % Quantization
    if (get(handles.chkQuantization,'value'))
        bin=str2double(get(handles.txtBin,'String'));
        ISI=ISI_smooth_exp(ISI, bin, true);
    end
end

function XY=PlotVisibility(Name,A,ISI,XY)
if(nargin<4)
    XY=[];
end

% Graph properties
P=SmallWorld(['SmallWorld properties - ' Name],A);

% Plot 
h=Set_Figure(['Visibility graph - ' Name],[0 0 1200 800]);
figure(h)

% Get spikes from ISI
time=repmat(cumsum(ISI)',1,2);
spikes_1=zeros(length(ISI),1);
spikes_2=ones(length(ISI),1);
spikes=[spikes_1 spikes_2];
subplot(6,2,[1 2])
plot(time',spikes','k')
title(['Spikes = ' num2str(sum(spikes(:,2)))])
%xlabel('time [s]')
set(gca,'ytick',[])

% ISIs
subplot(6,2,[3 4])
plot(ISI,'.-k')
xlabel('# ISI')
ylabel('ISI [s]')
%ylim([0 5])

% Adjacency matrix
subplot(6,2,[5 7 9 11])
imagesc(A)

% Network
subplot(6,2,[6 8 10 12])
%Plot_Network_Multilevel(A,ISI)
XY=Plot_Network(A,XY);
set(gca,'xtick',[],'ytick',[]); box on
xlabel(['L=' num2str(P.L) '; E=' num2str(P.E) '; C=' num2str(P.C)...
    '; omega=' num2str(P.Omega) '; gamma=' num2str(P.slope)...
    '; rho=' num2str(P.Rho)])

%{
% Degree distribution
links=sum(A);
Set_Figure(['Distribution - ' Name],[0 0 500 600]);
subplot(2,1,1)
hist(links);
title('P(k) - Degree distribution')

% Hierarchical 
subplot(2,1,2)
links=sum(A);
plot(links,Clocal,'ok');
title('C(k) - Hierarchy')
%}

% Save
%
%frame=getframe(gcf);
%imwrite(frame.cdata,[Name '.png']);


%% Callbacks

function btnRefreshData_Callback(hObject, eventdata, handles)
RefreshData(handles);

function txtFilter_Callback(hObject, eventdata, handles)
user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
    set(hObject,'string',.1);
elseif(user_entry>100)
    set(hObject,'string',100);
elseif(user_entry<.0001)
    set(hObject,'string',.0001);
else
    set(hObject,'string',num2str(user_entry,'%.4f'));
end

function txtFilter_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtIBIregularBursting_Callback(hObject, eventdata, handles)

function txtIBIregularBursting_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtN_Callback(hObject, eventdata, handles)
user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
    set(hObject,'string',90);
elseif(user_entry>1000)
    set(hObject,'string',1000);
elseif(user_entry<10)
    set(hObject,'string',10);
else
    set(hObject,'string',num2str(user_entry,'%.0f'));
end


function txtN_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function chkQuantization_Callback(hObject, eventdata, handles)

function txtBin_Callback(hObject, eventdata, handles)
user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
    set(hObject,'string',.1);
elseif(user_entry>10)
    set(hObject,'string',10);
elseif(user_entry<.001)
    set(hObject,'string',.001);
else
    set(hObject,'string',num2str(user_entry,'%.3f'));
end

function txtBin_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lstType_Callback(hObject, eventdata, handles)

function lstType_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function btnNatural_Callback(hObject, eventdata, handles)
if(get(handles.chkAllAnalysis,'value'))
    DataNames=get(handles.lstData,'string');
    N=length(DataNames);
    Ls=[];
    Tags={};
    for i=6:N
        % Adequate ISI and get visibility graph
        set(handles.lstData,'value',i)
        ISI=Adequacy(handles); 
        A = Visibility_ISI(ISI);
        % Characteristic Path Length
        D=distance_bin(A);
        [L E]=charpath(D);
        Ls(i-5)=L;
        % Detect type of experiment
        Name=DataNames{i};
        if(~isempty(strfind(Name,'CTR')))
            Tags{i-5}='CTR';
        elseif(~isempty(strfind(Name,'ANT')))
            Tags{i-5}='ANT';
        elseif(~isempty(strfind(Name,'PRK')))
            Tags{i-5}='PRK';
        else
            Tags{i-5}='OTH';
        end
    end
    disp(Ls)
    disp(Tags)
    
    h=Set_Figure('Characteristic Path Length - Natural Visibility',[0 0 600 300]);
    figure(h)
    boxplot(Ls,Tags)
    title('Characteristic Path Length')
    xlabel('Condition')
    ylabel('L')
    
    % Statistics
    [p,tbl,stats] = kruskalwallis(Ls,Tags);
    figure();
    multcompare(stats);
else
    % Adequate ISI and get visibility graph
    ISI=Adequacy(handles); 
    A = Visibility_ISI(ISI); 
    % Get name of the ISI
    DataStrings=get(handles.lstData,'String'); 
    idx=get(handles.lstData,'value');
    Name=DataStrings{idx};
    % Plot visibility graph
    PlotVisibility(Name,A,ISI);    
end

function btnHorizontal_Callback(hObject, eventdata, handles)
if(get(handles.chkAllAnalysis,'value'))
    DataNames=get(handles.lstData,'string');
    N=length(DataNames);
    Ls=[];
    Tags={};
    for i=6:N
        % Adequate ISI and get visibility graph
        set(handles.lstData,'value',i)
        ISI=Adequacy(handles); 
        A = Visibility_ISI_Horizontal(ISI);
        % Characteristic Path Length
        D=distance_bin(A);
        [L E]=charpath(D);
        Ls(i-5)=L;
        % Detect type of experiment
        Name=DataNames{i};
        if(~isempty(strfind(Name,'CTR')))
            Tags{i-5}='CTR';
        elseif(~isempty(strfind(Name,'ANT')))
            Tags{i-5}='ANT';
        elseif(~isempty(strfind(Name,'PRK')))
            Tags{i-5}='PRK';
        else
            Tags{i-5}='OTH';
        end
    end
    
    h=Set_Figure('Characteristic Path Length - Horizontal Visibility',[0 0 600 300]);
    figure(h)
    boxplot(Ls,Tags)
    title('Characteristic Path Length')
    xlabel('Condition')
    ylabel('L')
    
    % Statistics
    [p,tbl,stats] = kruskalwallis(Ls,Tags);
    figure();
    multcompare(stats);
else

    % Adequate ISI and get visibility graph
    ISI=Adequacy(handles);
    A = Visibility_ISI_Horizontal(ISI);
    % Get name of the ISI
    DataStrings=get(handles.lstData,'String');
    idx=get(handles.lstData,'value');
    Name=DataStrings{idx};
    % Plot visibility graph
    PlotVisibility(Name,A,ISI);
end

function btnFilter_Callback(hObject, eventdata, handles)
% Adequate ISI and get visibility graph
ISI=Adequacy(handles);
filter_step=str2double(get(handles.txtFilter,'string'));
times=100;
% Plot
h=Set_Figure('Periodicity',[0 0 600 300]);
figure(h)
[f kmean] = Visibility_ISI_Horizontal_filter(ISI,filter_step,times);
mode_value=mode(kmean);
T=1/(2-mode_value/2);
title(['Periodicity - mode: ' num2str(mode_value) '; period: ' num2str(T)])
xlabel('f')
ylabel('<k>')

function btnParametric_Callback(hObject, eventdata, handles)

condition='PRK';

if(get(handles.chkAllAnalysis,'value'))
    DataNames=get(handles.lstData,'string');
    N=length(DataNames);
    As=[];
    Tags={};
    h=Set_Figure(['AUC - ' condition],[0 0 600 300]);
    figure(h);    
    sums=zeros(1,181);
    for i=6:N
        % Adequate ISI and get visibility graph
        set(handles.lstData,'value',i)
        ISI=Adequacy(handles); 
        %A = Visibility_ISI_Horizontal(ISI);
        A = Visibility_ISI(ISI);
        
        % Get areas
        [alphas components] = Parametric_Visibility_ISI(A,ISI);
        area=sum(components);
        As(i-5)=area;
        comps(:,i-5)=components;
        % Detect type of experiment
        Name=DataNames{i};
        if(~isempty(strfind(Name,'CTR')))
            Tags{i-5}='CTR';
        elseif(~isempty(strfind(Name,'ANT')))
            Tags{i-5}='ANT';
        elseif(~isempty(strfind(Name,'PRK')))
            Tags{i-5}='PRK';
        else
            Tags{i-5}='OTH';
        end
        switch(condition)
            case 'CTR'
                plot(alphas,components,'color',[0.8 0.8 1]); hold on; % Control (blue)
            case 'PRK'
                plot(alphas,components,'color',[1 0.8 1]); hold on; % 6-OHDA (purple)
            case 'ANT'
                plot(alphas,components,'color',[1 1 0.8]); hold on; % Antagonist (orange)
        end
    end
    median_comps=median(comps,2);
    
    switch(condition)
        case 'CTR'
            plot(alphas,median_comps,'color',[0 0 1]) % Control (blue)   
            plot(alphas,comps(:,5),'--k') % CTR_3 --> 5
        case 'PRK'
            plot(alphas, median_comps,'color',[1 0 1]) % 6-OHDA (purple)
            plot(alphas,comps(:,5),'--k') % PRK_5 --> 5
        case 'ANT'
            plot(alphas, median_comps,'color',[1 0.5 0]) % Antagonist (orange)
            plot(alphas,comps(:,7),'--k') % ANT_5 --> 7
    end 
    ylim([-0.1 1.1])
    
    assignin('base',[condition '_areas'],As);
    assignin('base',[condition '_comps'],comps);

    title(['Area - Parametric Visibility Graph - sum: ' num2str(sum(sum(comps)))])
    %
    h=Set_Figure('AUC',[0 0 600 300]);
    figure(h);
    boxplot(As,Tags,'notch','off');
    title('AUC')
    xlabel('Condition')
    ylabel('Area')
    
    
    % statistics
    [p,tbl,stats] = kruskalwallis(As,Tags);
    figure();
    %multcompare(stats);
    c=multcompare(stats,'CType','dunn-sidak')
    %}
else
    % Adequate ISI and get visibility graph
    ISI=Adequacy(handles);
    A = Visibility_ISI(ISI); 
    [alphas components] = Parametric_Visibility_ISI(A,ISI);
    area=sum(components);
    % Plot
    
    %h=Set_Figure('Parametric',[0 0 600 300]);
    %figure(h)
    figure(11)
    
    %plot(alphas,components,'color',[0 0 0]); hold on; 
    
    %plot(alphas,components,'color',[1 0 0]); hold on;
    %plot(alphas,components,'color',[1 0.8 0.8]); hold on;
    
    plot(alphas,components,'color',[0 1 0]); hold on;
    %plot(alphas,components,'color',[0.8 1 0.8]); hold on;
    
    %xticks(pi/4:pi/4:3*pi/4)
    %xticklabels({'\pi/4','\pi/2','3*\pi/4'})
    title(['Parametric - sum: ' num2str(area)])
    xlabel('angle')
    ylabel('Relative Clusters Quantity')
    ylim([-0.05 1.05])
end

function chkAllAnalysis_Callback(hObject, eventdata, handles)


function btnSingleParametric_Callback(hObject, eventdata, handles)

% Adequate ISI and get visibility graph
ISI=Adequacy(handles);
A = Visibility_ISI(ISI);
degree=str2double(get(handles.txtDegrees,'String'));
[A components] = SingleParametric_Visibility_ISI(A,ISI,degree);

% Plot
% Get name of the ISI
DataStrings=get(handles.lstData,'String'); 
idx=get(handles.lstData,'value');
Name=DataStrings{idx};
% Plot visibility graph
XY=evalin('base','exist(''XY'')');
if(XY)
    XY=evalin('base','XY');
else
    XY=[];
end
XY=PlotVisibility(Name,A,ISI,XY); 
assignin('base','XY',XY);

% save figure
%frame=getframe(gcf);
%imwrite(frame.cdata,[Name '_'  num2str(degree) 'deg.png']);



function txtDegrees_Callback(hObject, eventdata, handles)
user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
    set(hObject,'string',180);
elseif(user_entry>180)
    set(hObject,'string',180);
elseif(user_entry<0)
    set(hObject,'string',0);
else
    set(hObject,'string',num2str(user_entry,'%.0f'));
end

function txtDegrees_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
