function varargout = Controller(varargin)
% CONTROLLER MATLAB code for Controller.fig
%      CONTROLLER, by itself, creates a new CONTROLLER or raises the existing
%      singleton*.
%
%      H = CONTROLLER returns the handle to a new CONTROLLER or the handle to
%      the existing singleton*.
%
%      CONTROLLER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTROLLER.M with the given input arguments.
%
%      CONTROLLER('Property','Value',...) creates a new CONTROLLER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Controller_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Controller_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Controller

% Last Modified by GUIDE v2.5 10-Apr-2015 12:23:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Controller_OpeningFcn, ...
                   'gui_OutputFcn',  @Controller_OutputFcn, ...
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


% --- Executes just before Controller is made visible.
function Controller_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

BuildRobot;
handles.L = L;
handles.Rob = Rob;
handles.qc=  [0 pi/2 pi 3*pi/4 2*pi 1];
handles.qd=  [0 pi/2 pi 3*pi/4 2*pi 1];
handles.qz = [0 0 0 0 0 0]; % zero angles, L shaped pose
handles.qr = [0 pi/2 pi/2 0 0 0]; % ready pose, arm up
handles.qs = [0 0 pi/2 0 0 0];
handles.qn=[0 pi/4 pi 0 pi/4  0];
axes(handles.Model)
Rob.plot(qc)
guidata(hObject, handles);

function varargout = Controller_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

function UpdateMotors(handles)
%qn = MoveArmJoints(handles.gc, handles.qd);
qn = handles.qd;
set(handles.V0, 'String', num2str(qn(1)/pi));
set(handles.V1, 'String', num2str(qn(2)/pi));
set(handles.V2, 'String', num2str(qn(3)/pi));
set(handles.V3, 'String', num2str(qn(4)/pi));
set(handles.V4, 'String', num2str(qn(5)/pi));
set(handles.V5, 'String', num2str(qn(6)/pi));
set(handles.S0, 'Value', qn(1)/pi/2);
set(handles.S1, 'Value', qn(2)/pi/2);
set(handles.S2, 'Value', qn(3)/pi/2);
set(handles.S3, 'Value', qn(4)/pi/2);
set(handles.S4, 'Value', qn(5)/pi/2);
set(handles.S5, 'Value', qn(6)/pi/2);
handles.qc = qn;
handles.qd = qn;
handles.Rob.plot(qn);


function S0_Callback(hObject, eventdata, handles)
v = get(handles.S0, 'Value');
handles.qd(1) = v*pi*2;
UpdateMotors(handles);
function S0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function S1_Callback(hObject, eventdata, handles)
v = get(handles.S1, 'Value');
handles.qd(2) = v*pi*2;
UpdateMotors(handles);
function S1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function S2_Callback(hObject, eventdata, handles)
v = get(handles.S2, 'Value');
handles.qd(3) = v*pi*2;
UpdateMotors(handles);
function S2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function S3_Callback(hObject, eventdata, handles)
v = get(handles.S3, 'Value');
handles.qd(4) = v*pi*2;
UpdateMotors(handles);
function S3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function S4_Callback(hObject, eventdata, handles)
v = get(handles.S4, 'Value');
handles.qd(5) = v*pi*2;
UpdateMotors(handles);
function S4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function S5_Callback(hObject, eventdata, handles)
v = get(handles.S5, 'Value');
handles.qd(6) = v*pi*2;
UpdateMotors(handles);
function S5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function V0_Callback(hObject, eventdata, handles)
v = str2double(get(handles.V1,'String'));
handles.qd(1) = v;
UpdateMotors(handles);
function V0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to V0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function V1_Callback(hObject, eventdata, handles)
% hObject    handle to V1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of V1 as text
%        str2double(get(hObject,'String')) returns contents of V1 as a double
v = str2double(get(handles.V2,'String'));
if v>2
    v = 2;
end
if v <=0
    v = 0;
end
handles.qd(2) = v;
UpdateMotors(handles);
function V1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to V1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function V2_Callback(hObject, eventdata, handles)
v = str2double(get(handles.V3,'String'));
if v > 2
    v = 2;
end
if v <=0
    v = 0;
end
handles.qd(3) = v;
UpdateMotors(handles);
function V2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to V2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function V3_Callback(hObject, eventdata, handles)
v = str2double(get(handles.V4,'String'));
if v>2
    v = 2;
end
if v <=0
    v = 0;
end
handles.qd(4) = v;
UpdateMotors(handles);
function V3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to V3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function V4_Callback(hObject, eventdata, handles)
v = str2double(get(handles.V5,'String'));
if v>2
    v = 2;
end
if v <=0
    v = 0;
end
handles.qd(5) = v;
UpdateMotors(handles);
function V4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function V5_Callback(hObject, eventdata, handles)
v = str2double(get(handles.V6,'String'));
handles.qd(6) = v;
UpdateMotors(handles);
function V5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GoToqz_Callback(hObject, eventdata, handles)
handles.qd = handles.qz;
UpdateMotors(handles);

function GoToqr_Callback(hObject, eventdata, handles)
handles.qd = handles.qr;
UpdateMotors(handles);

function GoToqs_Callback(hObject, eventdata, handles)
handles.qd = handles.qs;
UpdateMotors(handles);

function GoToqn_Callback(hObject, eventdata, handles)
handles.qd = handles.qn;
UpdateMotors(handles);



function edit8_Callback(hObject, eventdata, handles)
function edit8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit9_Callback(hObject, eventdata, handles)
function edit9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit10_Callback(hObject, eventdata, handles)
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
