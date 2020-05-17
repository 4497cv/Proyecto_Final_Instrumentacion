function varargout = settings(varargin)
% SETTINGS MATLAB code for settings.fig
%      SETTINGS, by itself, creates a new SETTINGS or raises the existing
%      singleton*.
%
%      H = SETTINGS returns the handle to a new SETTINGS or the handle to
%      the existing singleton*.
%
%      SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETTINGS.M with the given input arguments.
%
%      SETTINGS('Property','Value',...) creates a new SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before settings_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help settings

% Last Modified by GUIDE v2.5 16-May-2020 23:23:41

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
set(handles.pushbutton7,'Enable','off')
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
global tfinal temp_final hum_final wf_final

tfinal = str2double(get(handles.tf_settings,'string'));
temp_final = str2double(get(handles.temp_settings,'string'));
hum_final = str2double(get(handles.rh_settings,'string'));
wf_final =  str2double(get(handles.wf_settings,'string'));
opt = simset('solver','ode4','srcWorkspace','Current');
sim('PF_IE', [0 tfinal], opt);
set(handles.pushbutton7,'Enable','off')

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(settings,'visible','off');
set(Main_Screen,'visible','on');


function temp_settings_Callback(hObject, eventdata, handles)
% hObject    handle to temp_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton7,'Enable','on')
% Hints: get(hObject,'String') returns contents of temp_settings as text
%        str2double(get(hObject,'String')) returns contents of temp_settings as a double


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
set(handles.pushbutton7,'Enable','on')

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
set(handles.pushbutton7,'Enable','on')

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
set(handles.pushbutton7,'Enable','on')

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
