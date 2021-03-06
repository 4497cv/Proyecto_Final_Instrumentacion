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
movegui(hObject, 'center');
global step_button_st vect_button_st

set(handles.pushbutton7,'Enable','off');
set(handles.sim_text,'Visible','off');
set(handles.sim_done_text,'Visible','off');

config_icon = imread(pwd+"\img\tuerca.jpg");
%set(handles.ui_iconpanel,'BackgroundColor',[1 1 1]);
imgaxes = axes('parent', handles.ui_iconpanel);
image(config_icon);
axis off;
axis image;
set(handles.uipanel_step,'visible','on');
set(handles.uipanel_vect,'visible','off')
set(handles.vect_button,'Value',0);
set(handles.step_button,'Value',1);
step_button_st = 1;
vect_button_st = 0;
set(handles.temp0_edit, 'String', '33');
set(handles.temp1_edit, 'String', '34');
set(handles.temp2_edit, 'String', '35');
set(handles.temp3_edit, 'String', '36');
set(handles.rh0_edit, 'String', '70');
set(handles.rh1_edit, 'String', '67');
set(handles.rh2_edit, 'String', '63');
set(handles.rh3_edit, 'String', '58');
set(handles.wf0_edit, 'String', '1.5');
set(handles.wf1_edit, 'String', '1.5');
set(handles.wf2_edit, 'String', '1.5');
set(handles.wf3_edit, 'String', '1.5');



textblocker1_Callback(@settings_OpeningFcn, eventdata, handles);
%temp_settings_Callback(@settings_OpeningFcn, eventdata, handles);
% rh_settings_Callback(@settings_OpeningFcn, eventdata, handles);
% wf_settings_Callback(@settings_OpeningFcn, eventdata, handles);
% tf_settings_Callback(@settings_OpeningFcn, eventdata, handles);

%set(handles.figure1,'Color',	[0 0 0]);
%set(handles.uipanel_step,'BackgroundColor',[0 0.4470 0.7410]);
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
global sim_vpd sim_temp sim_hum sim_wf
global temp_tstamp temp_values wf_tstamp wf_values rh_tstamp rh_values
global t_global temp_global hum_global wf_global vpd_global
global wf_final hum_final temp_final tfinal
global step_button_st vect_button_st

if(step_button_st == 1)
    temp_final = str2double(get(handles.temp_settings,'string'));
    hum_final = str2double(get(handles.rh_settings,'string'));
    wf_final =  str2double(get(handles.wf_settings,'string'));
    tfinal = str2double(get(handles.tf_settings,'string'));
    
    temp_tstamp = [0 2 4 6 8];
    temp_values = [0, temp_final, temp_final, temp_final, temp_final];

    wf_tstamp = [0 2 4 6 10];
    wf_values = [0, wf_final, wf_final, wf_final, wf_final];

    rh_tstamp = [0 2 4 6 10];
    rh_values = [0, hum_final, hum_final, hum_final, hum_final];
    
    set(handles.sim_text,'Visible','on');
    opt = simset('solver','ode8','srcWorkspace','Current');
    sim('PF_IE_1705', [0 tfinal], opt);
    
    t_global = t;
    temp_global = temp;
    hum_global = hum;
    wf_global = wf;
    vpd_global = vpd;
    sim_vpd = 1;

end

if(vect_button_st == 1)
    temp0 = str2double(get(handles.temp0_edit,'string'));
    temp1 = str2double(get(handles.temp1_edit,'string'));
    temp2 =  str2double(get(handles.temp2_edit,'string'));
    temp3 = str2double(get(handles.temp3_edit,'string'));
    
    rh0 = str2double(get(handles.rh0_edit,'string'));
    rh1 = str2double(get(handles.rh1_edit,'string'));
    rh2 =  str2double(get(handles.rh2_edit,'string'));
    rh3 = str2double(get(handles.rh3_edit,'string'));
    
    wf0 = str2double(get(handles.wf0_edit,'string'));
    wf1 = str2double(get(handles.wf1_edit,'string'));
    wf2 =  str2double(get(handles.wf2_edit,'string'));
    wf3 = str2double(get(handles.wf3_edit,'string'));

    temp_tstamp = [0 14 28 42 84];
    temp_values = [0, temp0, temp1, temp2, temp3];

    wf_tstamp = [0 14 28 42 84];
    wf_values = [1.33, rh0, rh1, rh2, rh3];

    rh_tstamp = [0 14 20 42 84];
    rh_values = [0, wf0, wf1, wf2, wf3];
    
    tfinal = str2double(get(handles.tf_total,'string'));
     
    set(handles.sim_text,'Visible','on');
    
    opt = simset('solver','ode4','srcWorkspace','Current');
   
    sim('PF_IE_1705', [0 tfinal*60], opt);
    
    t_global = t;
    temp_global = temp;
    hum_global = hum;
    wf_global = wf;
    vpd_global = vpd;
    sim_vpd = 1;
    sim_temp = 1;
    sim_hum = 1;
    sim_wf = 1;
end 

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
if((tfinal > 0) && (tfinal <= 60*60))
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



function temp0_edit_Callback(hObject, eventdata, handles)
% hObject    handle to temp0_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp0_edit as text
%        str2double(get(hObject,'String')) returns contents of temp0_edit as a double


% --- Executes during object creation, after setting all properties.
function temp0_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp0_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function tf_total_Callback(hObject, eventdata, handles)
% hObject    handle to tf_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tf_total as text
%        str2double(get(hObject,'String')) returns contents of tf_total as a double
global tfinal
tfinal = str2double(get(handles.tf_total,'string'));

if((tfinal > 0) && (tfinal <= 60))
    fprintf("valid time value: %i\n", tfinal);
    set(handles.pushbutton7,'Enable','on');
    set(handles.tf_total,'ForegroundColor',[0 0.4470 0.7410]);
else
    set(handles.tf_total,'ForegroundColor',[0.6350 0.0780 0.1840]);
end
tfinal = tfinal*60; %segundos
tfinal

% --- Executes during object creation, after setting all properties.
function tf_total_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tf_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to temp1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp1_edit as text
%        str2double(get(hObject,'String')) returns contents of temp1_edit as a double


% --- Executes during object creation, after setting all properties.
function temp1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to temp2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp2_edit as text
%        str2double(get(hObject,'String')) returns contents of temp2_edit as a double


% --- Executes during object creation, after setting all properties.
function temp2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp3_edit_Callback(hObject, eventdata, handles)
% hObject    handle to temp3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp3_edit as text
%        str2double(get(hObject,'String')) returns contents of temp3_edit as a double


% --- Executes during object creation, after setting all properties.
function temp3_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in step_button.
function step_button_Callback(hObject, eventdata, handles)
% hObject    handle to step_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of step_button
global step_button_st vect_button_st
step_button_st = 1;
vect_button_st = 0;
set(handles.uipanel_step,'visible','on')
set(handles.uipanel_vect,'visible','off')
set(handles.vect_button,'Value',0);
set(handles.step_button,'Value',1);

% --- Executes on button press in vect_button.
function vect_button_Callback(hObject, eventdata, handles)
% hObject    handle to vect_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of vect_button
global step_button_st vect_button_st
step_button_st = 0;
vect_button_st = 1;
set(handles.uipanel_step,'visible','off')
set(handles.uipanel_vect,'visible','on')
set(handles.vect_button,'Value',1);
set(handles.step_button,'Value',0);



function rh0_edit_Callback(hObject, eventdata, handles)
% hObject    handle to rh0_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rh0_edit as text
%        str2double(get(hObject,'String')) returns contents of rh0_edit as a double


% --- Executes during object creation, after setting all properties.
function rh0_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rh0_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rh1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to rh1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rh1_edit as text
%        str2double(get(hObject,'String')) returns contents of rh1_edit as a double


% --- Executes during object creation, after setting all properties.
function rh1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rh1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rh2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to rh2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rh2_edit as text
%        str2double(get(hObject,'String')) returns contents of rh2_edit as a double


% --- Executes during object creation, after setting all properties.
function rh2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rh2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rh3_edit_Callback(hObject, eventdata, handles)
% hObject    handle to rh3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rh3_edit as text
%        str2double(get(hObject,'String')) returns contents of rh3_edit as a double


% --- Executes during object creation, after setting all properties.
function rh3_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rh3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wf0_edit_Callback(hObject, eventdata, handles)
% hObject    handle to wf0_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wf0_edit as text
%        str2double(get(hObject,'String')) returns contents of wf0_edit as a double


% --- Executes during object creation, after setting all properties.
function wf0_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wf0_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wf1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to wf1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wf1_edit as text
%        str2double(get(hObject,'String')) returns contents of wf1_edit as a double


% --- Executes during object creation, after setting all properties.
function wf1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wf1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wf2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to wf2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wf2_edit as text
%        str2double(get(hObject,'String')) returns contents of wf2_edit as a double


% --- Executes during object creation, after setting all properties.
function wf2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wf2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function wf3_edit_Callback(hObject, eventdata, handles)
% hObject    handle to wf3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wf3_edit as text
%        str2double(get(hObject,'String')) returns contents of wf3_edit as a double


% --- Executes during object creation, after setting all properties.
function wf3_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wf3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wf3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on tf_total and none of its controls.
function tf_total_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to tf_total (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
