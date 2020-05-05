function varargout = Instrument_1(varargin)
% INTRUMENT_1 MATLAB code for Intrument_1.fig
%      INTRUMENT_1, by itself, creates a new INTRUMENT_1 or raises the existing
%      singleton*.
%
%      H = INTRUMENT_1 returns the handle to a new INTRUMENT_1 or the handle to
%      the existing singleton*.
%
%      INTRUMENT_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTRUMENT_1.M with the given input arguments.
%
%      INTRUMENT_1('Property','Value',...) creates a new INTRUMENT_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Intrument_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Intrument_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Intrument_1

% Last Modified by GUIDE v2.5 11-Jan-2017 17:29:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Instrument_1_OpeningFcn, ...
                   'gui_OutputFcn',  @Instrument_1_OutputFcn, ...
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


% --- Executes just before Intrument_1 is made visible.
function Instrument_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Intrument_1 (see VARARGIN)
global count t x
count = 1;
handles.timer = timer(...
    'ExecutionMode', 'fixedRate', ...       % Run timer repeatedly
    'Period', 1, ...                        % Initial period is 1 sec.
    'TimerFcn', {@update_display,hObject}); % Specify callback function
% Initialize slider and its readout text field
set(handles.periodo_slider,'Min',0.01,'Max',2)
set(handles.periodo_slider,'Value',get(handles.timer,'Period'))
set(handles.valor_slider,'String',...
    num2str(get(handles.periodo_slider,'Value')))

%CREAMOS LOS DATOS A GRAFICAR
t = (0:0.1:20);
x = 4*tanh(t/2);
handles.plot = plot(handles.axes1,t(1,count),x(1,count));
axis(handles.axes1,[0 20 -4 4]);
%CREAMOS EL DISPLAY DE BARRA
axes(handles.axes2);
axis([0 2 -4 4]);
set(handles.axes2,'XTick',[]);
set(handles.axes2,'XColor','w');
box on;
handles.plot2 = rectangle('Position',[0 0 2 x(1,count)],'FaceColor',[1 0 0]);
%CREAMOS EL DISPLAY CIRCULAR
axes(handles.axes3);
axis([0 4 0 4]);
set(handles.axes3,'Visible','Off');
hold on;
rectangle('Position',[0 0 4 4],'FaceColor',[1 1 1],'Curvature',1);

offset = [0.01 0.02;0.01 0.08;0.03 0.14;0.07 0.15 ;0.12 0.16;0.17 0.16;0.17 0.14;0.2 0.03;0.2 0.02];
for i=0:8
    plot([2+2*sin(pi*i/8-pi/2) 2+1.8*sin(pi*i/8-pi/2)],[2+2*cos(pi*i/8-pi/2) 2+1.8*cos(pi*i/8-pi/2)],'k','LineWidth', 1);
    text(2+2.2*sin(pi*i/8-pi/2)+offset(i+1,1),2+2.2*cos(pi*i/8-pi/2)+offset(i+1,2),num2str(i-4),'HorizontalAlignment','right');
end

handles.plot3 = plot([2 2+2*sin(pi*x(1,count)/8)],[2 2+2*cos(pi*x(1,count)/8)],'r','LineWidth', 2);
hold off;

handles.lim = size(t,2);

% Choose default command line output for Intrument_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Intrument_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Instrument_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start_button.
function start_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(handles.timer, 'Running'), 'off')
    start(handles.timer);
end

% --- Executes on button press in pause_button.
function pause_button_Callback( hObject, eventdata, handles)
% hObject    handle to pause_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if strcmp(get(handles.timer, 'Running'), 'on')
    stop(handles.timer);
end
set(handles.mensajes_text,'String','PAUSED SIMULATION');


% --- Executes on slider movement.
function periodo_slider_Callback(hObject, eventdata, handles)
% hObject    handle to periodo_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% START USER CODE
% Read the slider value
period = get(handles.periodo_slider,'Value');
% Timers need the precision of periods to be greater than about
% 1 millisecond, so truncate the value returned by the slider
period = period - mod(period,.01);
% Set slider readout to show its value
set(handles.valor_slider,'String',num2str(period))
% If timer is on, stop it, reset the period, and start it again.
if strcmp(get(handles.timer, 'Running'), 'on')
    stop(handles.timer);
    set(handles.timer,'Period',period)
    start(handles.timer)
else               % If timer is stopped, reset its period only.
    set(handles.timer,'Period',period)
end
% END USER CODE

% --- Executes during object creation, after setting all properties.
function periodo_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to periodo_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% START USER CODE
function update_display(hObject, eventdata, hfigure)
% Timer timer1 callback, called each time timer iterates.
% Gets surface Z data, adds noise, and writes it back to surface object.
global count t x
handles = guidata(hfigure);

if count <= handles.lim
    axis(handles.axes1,[0 20 -4 4]);
    t_ = t(1,1:count);
    x_ = x(1,1:count);
    set(handles.plot,'XData',t_,'YData',x_);
    
    if x(1,count) < 0
        set(handles.plot2,'Position',[0 x(1,count) 2 -x(1,count)],'FaceColor',[1 0 0]);
        set(handles.plot3,'XData',[2 2+2*sin(pi*x(1,count)/8)],'YData',[2 2+2*cos(pi*x(1,count)/8)],'Color','r');
    else
        set(handles.plot2,'Position',[0 0 2 x(1,count)],'FaceColor',[0 1 0.1]);
        set(handles.plot3,'XData',[2 2+2*sin(pi*x(1,count)/8)],'YData',[2 2+2*cos(pi*x(1,count)/8)],'Color','g');
    end
    
    count = count + 1;
    set(handles.mensajes_text,'String','PLOTTING :-)');
else
    set(handles.mensajes_text,'String','No more data...');
end
% END USER CODE

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% START USER CODE
% Necessary to provide this function to prevent timer callback
% from causing an error after GUI code stops executing.
% Before exiting, if the timer is running, stop it.
if strcmp(get(handles.timer, 'Running'), 'on')
    stop(handles.timer);
end
% Destroy timer
delete(handles.timer)
% END USER CODE

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count
count = 1;
set(handles.mensajes_text,'String','RESET SIMULATION :-|');
