function varargout = Main_Screen(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_Screen_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_Screen_OutputFcn, ...
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


% --- Executes just before Main_Screen is made visible.
function Main_Screen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main_Screen (see VARARGIN)

% Choose default command line output for Main_Screen
global sim_temp sim_hum sim_wf sim_vpd

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

movegui(hObject, 'center');

set(handles.figure1,'Color', [1 1 1]);
set(handles.text2,'BackgroundColor',[1 1 1]);
set(handles.uibuttongroup2,'BackgroundColor',[1 1 1]);

tomato_icon = imread(pwd+"\img\tomate.jpg");
set(handles.uipanellogo,'BackgroundColor',[1 1 1]);
imgaxes = axes('parent', handles.uipanellogo);
load mandrill;
image(tomato_icon);
axis off;

format shortg;
[c tf] = clock;

cdate = c(3)+"/"+c(2)+"/"+c(1);

set(handles.text4,'String', cdate);
set(handles.text4,'BackgroundColor', [1 1 1]);

%set(handles.uibuttongroup2,'ShadowColor',[0 0.4470 0.7410]);
if(sim_temp == 1)
    set(handles.pushbutton1,'Enable','on');
else 
    set(handles.pushbutton1,'Enable','off');
end

if(sim_hum == 1)
    set(handles.pushbutton2,'Enable','on');
else 
    set(handles.pushbutton2,'Enable','off');
end

if(sim_wf == 1)
    set(handles.pushbutton3,'Enable','on');
else 
    set(handles.pushbutton3,'Enable','off');
end

if(sim_vpd == 1)
    set(handles.pushbutton13,'Enable','on');
else 
    set(handles.pushbutton13,'Enable','off');
end
% UIWAIT makes Main_Screen wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_Screen_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(Main_Screen,'visible','off');
Temperature;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(Main_Screen,'visible','off');
Humidity;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(Main_Screen,'visible','off');
WaterFlow;

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%close(Main_Screen);
%set(Main_Screen,'visible','off');
close(Main_Screen);
settings;

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

% --- Executes during object creathide()ion, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white'); 
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(Main_Screen,'visible','off');
VPD;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
clear all;
