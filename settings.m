function varargout = settings(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @settings_OpeningFcn, ...
                   'gui_OutputFcn',  @settings_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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


% --- Executes just before settings is made visible.
function settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to settings (see VARARGIN)

% Choose default command line output for settings
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
set(handles.pushbutton7,'Enable','off');
set(handles.sim_text,'Visible','off');
set(handles.sim_done_text,'Visible','off');

config_icon = imread('C:\GIT\Proyecto_Final_Instrumentacion\img\tuerca.jpg');
%set(handles.ui_iconpanel,'BackgroundColor',[1 1 1]);
imgaxes = axes('parent', handles.ui_iconpanel);
image(config_icon);
axis off;
axis image;

textblocker1_Callback(@settings_OpeningFcn, eventdata, handles);
%temp_settings_Callback(@settings_OpeningFcn, eventdata, handles);
% rh_settings_Callback(@settings_OpeningFcn, eventdata, handles);
% wf_settings_Callback(@settings_OpeningFcn, eventdata, handles);
% tf_settings_Callback(@settings_OpeningFcn, eventdata, handles);

%set(handles.figure1,'Color',	[0 0 0]);
%set(handles.uipanel4,'BackgroundColor',[0 0.4470 0.7410]);
% UIWAIT makes settings wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = settings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sim_vpd
global t_global temp_global hum_global wf_global vpd_global
global wf_final hum_final temp_final tfinal
temp_final = str2double(get(handles.temp_settings,'string'));
hum_final = str2double(get(handles.rh_settings,'string'));
wf_final =  str2double(get(handles.wf_settings,'string'));
tfinal = str2double(get(handles.tf_settings,'string'));

set(handles.sim_text,'Visible','on');
opt = simset('solver','ode4','srcWorkspace','Current');
sim('PF_IE', [0 tfinal], opt);
t_global = t;
temp_global = temp;
hum_global = hum;
wf_global = wf;
vpd_global = vpd;
sim_vpd = 1;
set(handles.pushbutton7,'Enable','off');
set(handles.sim_text,'Visible','off');
set(handles.sim_text,'ForegroundColor',[0 0.4470 0.7410]);
set(handles.sim_done_text,'Visible','on');
set(handles.sim_done_text,'ForegroundColor',[0.4660 0.6740 0.1880]);

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.sim_done_text,'Visible','off');
set(handles.sim_text,'Visible','off');
set(settings,'visible','off');
set(Main_Screen,'visible','on');

function temp_settings_Callback(hObject, eventdata, handles)
% hObject    handle to temp_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of temp_settings as text
%        str2double(get(hObject,'String')) returns contents of temp_settings as a double
global temp_final sim_temp
temp_final = str2double(get(handles.temp_settings,'string'));
if((temp_final >= 2) && (temp_final <= 150))
    sim_temp = 1;
    fprintf("valid temperature value: %i\n", temp_final);
    set(handles.temp_settings,'ForegroundColor',[0 0.4470 0.7410]);
    textblocker2_Callback(@temp_settings_Callback, eventdata, handles);
else
    sim_temp = 0;
    set(handles.temp_settings,'ForegroundColor',[0.6350 0.0780 0.1840]);
end

% --- Executes during object creation, after setting all properties.
function temp_settings_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rh_settings_Callback(hObject, eventdata, handles)
% hObject    handle to rh_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rh_settings as text
%        str2double(get(hObject,'String')) returns contents of rh_settings as a double
global sim_hum hum_final
hum_final = str2double(get(handles.rh_settings,'string'));
if((hum_final >= 0) && (hum_final <= 100))
    fprintf("valid rh value: %i\n", hum_final);
    sim_hum = 1;
    set(handles.rh_settings,'ForegroundColor',[0 0.4470 0.7410]);
    textblocker3_Callback(@rh_settings_Callback, eventdata, handles);
else
    sim_hum = 0;
    set(handles.rh_settings,'ForegroundColor',[0.6350 0.0780 0.1840]);
end


% --- Executes during object creation, after setting all properties.
function rh_settings_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rh_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function wf_settings_Callback(hObject, eventdata, handles)
% hObject    handle to wf_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wf_settings as text
%        str2double(get(hObject,'String')) returns contents of wf_settings as a double
global wf_final sim_wf
wf_final =  str2double(get(handles.wf_settings,'string'));
if((wf_final >= 1.3) && (wf_final <= 2))
    fprintf("valid wf value: %i\n", wf_final);
    sim_wf = 1;
    set(handles.wf_settings,'ForegroundColor',[0 0.4470 0.7410]);
    textblocker4_Callback(@wf_settings_Callback, eventdata, handles);
else
    sim_wf = 0;
    set(handles.wf_settings,'ForegroundColor',[0.6350 0.0780 0.1840]);
end

% --- Executes during object creation, after setting all properties.
function wf_settings_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wf_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function tf_settings_Callback(hObject, eventdata, handles)
% hObject    handle to tf_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tf_settings as text
%        str2double(get(hObject,'String')) returns contents of tf_settings as a double
global tfinal
tfinal = str2double(get(handles.tf_settings,'string'));
if((tfinal > 0) && (tfinal <= 5000))
    fprintf("valid time value: %i\n", tfinal);
    set(handles.pushbutton7,'Enable','on');
    set(handles.tf_settings,'ForegroundColor',[0 0.4470 0.7410]);
else
    set(handles.tf_settings,'ForegroundColor',[0.6350 0.0780 0.1840]);
end

% --- Executes during object creation, after setting all properties.
function tf_settings_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tf_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function textblocker1_Callback(hObject, eventdata, handles)
    set(handles.rh_settings,'Enable', 'Off');
    set(handles.wf_settings,'Enable', 'Off');
    set(handles.tf_settings,'Enable', 'Off');
 
 function textblocker2_Callback(hObject, eventdata, handles)
     set(handles.rh_settings,'Enable', 'On');
     set(handles.wf_settings,'Enable', 'Off');
     set(handles.tf_settings,'Enable', 'Off');
     
 function textblocker3_Callback(hObject, eventdata, handles)
     set(handles.rh_settings,'Enable', 'On');
     set(handles.wf_settings,'Enable', 'On');
     set(handles.tf_settings,'Enable', 'Off');
     
 function textblocker4_Callback(hObject, eventdata, handles)
     set(handles.rh_settings,'Enable', 'On');
     set(handles.wf_settings,'Enable', 'On');
     set(handles.tf_settings,'Enable', 'On');
