function varargout = ROBOT_IPAD(varargin)
% ROBOT_IPAD MATLAB code for ROBOT_IPAD.fig
%      ROBOT_IPAD, by itself, creates a new ROBOT_IPAD or raises the existing
%      singleton*.
%
%      H = ROBOT_IPAD returns the handle to a new ROBOT_IPAD or the handle to
%      the existing singleton*.
%
%      ROBOT_IPAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROBOT_IPAD.M with the given input arguments.
%
%      ROBOT_IPAD('Property','Value',...) creates a new ROBOT_IPAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ROBOT_IPAD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ROBOT_IPAD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ROBOT_IPAD

% Last Modified by GUIDE v2.5 25-Apr-2020 16:01:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ROBOT_IPAD_OpeningFcn, ...
                   'gui_OutputFcn',  @ROBOT_IPAD_OutputFcn, ...
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

% --- Executes just before ROBOT_IPAD is made visible.
function ROBOT_IPAD_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ROBOT_IPAD (see VARARGIN)

% Choose default command line output for ROBOT_IPAD
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ROBOT_IPAD wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%===============================================================%添加全局变量
global percent ModelName;
global strh X;

percent = 0.1;
ModelName = 'KUKA_LUNGU';
%===============================================================%
 
% --- Outputs from this function are returned to the command line.
function varargout = ROBOT_IPAD_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function Position_X_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_X = str2num(get(handles.Position_X,'String'));

X6 = Add_X;
% X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));
RZ = str2num(get(handles.Position_A,'String'));
RY = str2num(get(handles.Position_B,'String'));
RX = str2num(get(handles.Position_C,'String'));

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Subtration_X_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_X = str2num(get(handles.Position_X,'String')) - percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Position_X,'String',num2str(Add_X));

X6 = Add_X;
% X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));
RZ = str2num(get(handles.Position_A,'String'));
RY = str2num(get(handles.Position_B,'String'));
RX = str2num(get(handles.Position_C,'String'));

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Addition_X_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_X = str2num(get(handles.Position_X,'String')) + percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Position_X,'String',num2str(Add_X));

X6 = Add_X;
% X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));
RZ = str2num(get(handles.Position_A,'String'));
RY = str2num(get(handles.Position_B,'String'));
RX = str2num(get(handles.Position_C,'String'));

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Joint_Angle1_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A1 = str2num(get(handles.Joint_Angle1,'String'));

A1 = Add_A1;
% A1 = str2num(get(handles.Joint_Angle1,'String'));
A2 = str2num(get(handles.Joint_Angle2,'String'));
A3 = str2num(get(handles.Joint_Angle3,'String'));
A4 = str2num(get(handles.Joint_Angle4,'String'));
A5 = str2num(get(handles.Joint_Angle5,'String'));
A6 = str2num(get(handles.Joint_Angle6,'String'));

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Subtration_A1_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A1 = str2num(get(handles.Joint_Angle1,'String')) - 0.3*percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Joint_Angle1,'String',num2str(Add_A1));

A1 = Add_A1;
% A1 = str2num(get(handles.Joint_Angle1,'String'));
A2 = str2num(get(handles.Joint_Angle2,'String'));
A3 = str2num(get(handles.Joint_Angle3,'String'));
A4 = str2num(get(handles.Joint_Angle4,'String'));
A5 = str2num(get(handles.Joint_Angle5,'String'));
A6 = str2num(get(handles.Joint_Angle6,'String'));

if A1 <= -185
    A1 = -185;
    set(handles.Joint_Angle1,'String',num2str(A1));
end  

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Addition_A1_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A1 = str2num(get(handles.Joint_Angle1,'String')) + 0.3*percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Joint_Angle1,'String',num2str(Add_A1));

A1 = Add_A1;
% A1 = str2num(get(handles.Joint_Angle1,'String'));
A2 = str2num(get(handles.Joint_Angle2,'String'));
A3 = str2num(get(handles.Joint_Angle3,'String'));
A4 = str2num(get(handles.Joint_Angle4,'String'));
A5 = str2num(get(handles.Joint_Angle5,'String'));
A6 = str2num(get(handles.Joint_Angle6,'String'));

if A1 >= 185
    A1 = 185;
    set(handles.Joint_Angle1,'String',num2str(A1));
end  

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Position_Y_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_Y = str2num(get(handles.Position_Y,'String'));

Y6 = Add_Y;
X6 = str2num(get(handles.Position_X,'String'));
% Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));
RZ = str2num(get(handles.Position_A,'String'));
RY = str2num(get(handles.Position_B,'String'));
RX = str2num(get(handles.Position_C,'String'));

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

% --- Executes on button press in Subtration_Y.
function Subtration_Y_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_Y = str2num(get(handles.Position_Y,'String')) - percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Position_Y,'String',num2str(Add_Y));

Y6 = Add_Y;
X6 = str2num(get(handles.Position_X,'String'));
% Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));
RZ = str2num(get(handles.Position_A,'String'));
RY = str2num(get(handles.Position_B,'String'));
RX = str2num(get(handles.Position_C,'String'));

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Addition_Y_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_Y = str2num(get(handles.Position_Y,'String')) + percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Position_Y,'String',num2str(Add_Y));

Y6 = Add_Y;
X6 = str2num(get(handles.Position_X,'String'));
% Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));
RZ = str2num(get(handles.Position_A,'String'));
RY = str2num(get(handles.Position_B,'String'));
RX = str2num(get(handles.Position_C,'String'));

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Joint_Angle2_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A2 = str2num(get(handles.Joint_Angle2,'String'));

A2 = Add_A2;
A1 = str2num(get(handles.Joint_Angle1,'String'));
% A2 = str2num(get(handles.Joint_Angle2,'String'));
A3 = str2num(get(handles.Joint_Angle3,'String'));
A4 = str2num(get(handles.Joint_Angle4,'String'));
A5 = str2num(get(handles.Joint_Angle5,'String'));
A6 = str2num(get(handles.Joint_Angle6,'String'));

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Subtration_A2_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A2 = str2num(get(handles.Joint_Angle2,'String')) - 0.3*percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Joint_Angle2,'String',num2str(Add_A2));

A2 = Add_A2;
A1 = str2num(get(handles.Joint_Angle1,'String'));
% A2 = str2num(get(handles.Joint_Angle2,'String'));
A3 = str2num(get(handles.Joint_Angle3,'String'));
A4 = str2num(get(handles.Joint_Angle4,'String'));
A5 = str2num(get(handles.Joint_Angle5,'String'));
A6 = str2num(get(handles.Joint_Angle6,'String'));

if A2 <= -155
    A2 = -155;
    set(handles.Joint_Angle2,'String',num2str(A2));
end  

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Addition_A2_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A2 = str2num(get(handles.Joint_Angle2,'String')) + 0.3*percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Joint_Angle2,'String',num2str(Add_A2));

A2 = Add_A2;
A1 = str2num(get(handles.Joint_Angle1,'String'));
% A2 = str2num(get(handles.Joint_Angle2,'String'));
A3 = str2num(get(handles.Joint_Angle3,'String'));
A4 = str2num(get(handles.Joint_Angle4,'String'));
A5 = str2num(get(handles.Joint_Angle5,'String'));
A6 = str2num(get(handles.Joint_Angle6,'String'));

if A2 >= 35
    A2 = 35;
    set(handles.Joint_Angle2,'String',num2str(A2));
end  

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Position_Z_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_Z = str2num(get(handles.Position_Z,'String'));

Z6 = Add_Z;
X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
% Z6 = str2num(get(handles.Position_Z,'String'));
RZ = str2num(get(handles.Position_A,'String'));
RY = str2num(get(handles.Position_B,'String'));
RX = str2num(get(handles.Position_C,'String'));

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

% --- Executes on button press in Subtration_Z.
function Subtration_Z_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_Z = str2num(get(handles.Position_Z,'String')) - percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Position_Z,'String',num2str(Add_Z));

Z6 = Add_Z;
X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
% Z6 = str2num(get(handles.Position_Z,'String'));
RZ = str2num(get(handles.Position_A,'String'));
RY = str2num(get(handles.Position_B,'String'));
RX = str2num(get(handles.Position_C,'String'));

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Addition_Z_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_Z = str2num(get(handles.Position_Z,'String')) + percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Position_Z,'String',num2str(Add_Z));

Z6 = Add_Z;
X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
% Z6 = str2num(get(handles.Position_Z,'String'));
RZ = str2num(get(handles.Position_A,'String'));
RY = str2num(get(handles.Position_B,'String'));
RX = str2num(get(handles.Position_C,'String'));

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Joint_Angle3_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A3 = str2num(get(handles.Joint_Angle3,'String'));

A3 = Add_A3;
A1 = str2num(get(handles.Joint_Angle1,'String'));
A2 = str2num(get(handles.Joint_Angle2,'String'));
% A3 = str2num(get(handles.Joint_Angle3,'String'));
A4 = str2num(get(handles.Joint_Angle4,'String'));
A5 = str2num(get(handles.Joint_Angle5,'String'));
A6 = str2num(get(handles.Joint_Angle6,'String'));

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

% --- Executes on button press in Subtration_A3.
function Subtration_A3_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A3 = str2num(get(handles.Joint_Angle3,'String')) - 0.3*percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Joint_Angle3,'String',num2str(Add_A3));

A3 = Add_A3;
A1 = str2num(get(handles.Joint_Angle1,'String'));
A2 = str2num(get(handles.Joint_Angle2,'String'));
% A3 = str2num(get(handles.Joint_Angle3,'String'));
A4 = str2num(get(handles.Joint_Angle4,'String'));
A5 = str2num(get(handles.Joint_Angle5,'String'));
A6 = str2num(get(handles.Joint_Angle6,'String'));

if A3 <= -130
    A3 = -130;
    set(handles.Joint_Angle3,'String',num2str(A3));
end  

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Addition_A3_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A3 = str2num(get(handles.Joint_Angle3,'String')) + 0.3*percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Joint_Angle3,'String',num2str(Add_A3));

A3 = Add_A3;
A1 = str2num(get(handles.Joint_Angle1,'String'));
A2 = str2num(get(handles.Joint_Angle2,'String'));
% A3 = str2num(get(handles.Joint_Angle3,'String'));
A4 = str2num(get(handles.Joint_Angle4,'String'));
A5 = str2num(get(handles.Joint_Angle5,'String'));
A6 = str2num(get(handles.Joint_Angle6,'String'));

if A3 >= 154
    A3 = 154;
    set(handles.Joint_Angle3,'String',num2str(A3));
end  

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Position_A_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_RZ = str2num(get(handles.Position_A,'String'));

RZ = Add_RZ;
X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));
% RZ = str2num(get(handles.Position_A,'String'));
RY = str2num(get(handles.Position_B,'String'));
RX = str2num(get(handles.Position_C,'String'));
assignin('base','RZ',RZ);
assignin('base','RY',RY);
assignin('base','RX',RX);


R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];
assignin('base','R_abc',R_abc);
ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

% [ X6_1,Y6_1,Z6_1,ax_1,by_1,cz_1,RX,RY,RZ ] = Joint2pos( theta1,theta2,theta3,theta4,theta5,theta6 );
% set(handles.Position_A,'String',num2str(RZ));
% set(handles.Position_B,'String',num2str(RY));
% set(handles.Position_C,'String',num2str(RX));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Subtration_A_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_RZ = str2num(get(handles.Position_A,'String')) - 0.3 * percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Position_A,'String',num2str(Add_RZ));

RZ = Add_RZ;
X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));
% RZ = str2num(get(handles.Position_A,'String'));
RY = str2num(get(handles.Position_B,'String'));
RX = str2num(get(handles.Position_C,'String'));

if RZ < -180
    RZ = RZ + 360;
    set(handles.Position_A,'String',num2str(RZ));
end    

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

% [ X6_1,Y6_1,Z6_1,ax_1,by_1,cz_1,RX,RY,RZ ] = Joint2pos( theta1,theta2,theta3,theta4,theta5,theta6 );
% set(handles.Position_A,'String',num2str(RZ));
% set(handles.Position_B,'String',num2str(RY));
% set(handles.Position_C,'String',num2str(RX));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Addition_A_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_RZ = str2num(get(handles.Position_A,'String')) + 0.3 * percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Position_A,'String',num2str(Add_RZ));

RZ = Add_RZ;
X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));
% RZ = str2num(get(handles.Position_A,'String'));
RY = str2num(get(handles.Position_B,'String'));
RX = str2num(get(handles.Position_C,'String'));

if RZ > 180
    RZ = RZ - 360;
    set(handles.Position_A,'String',num2str(RZ));
end    

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

% [ X6_1,Y6_1,Z6_1,ax_1,by_1,cz_1,RX,RY,RZ ] = Joint2pos( theta1,theta2,theta3,theta4,theta5,theta6 );
% set(handles.Position_A,'String',num2str(RZ));
% set(handles.Position_B,'String',num2str(RY));
% set(handles.Position_C,'String',num2str(RX));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Joint_Angle4_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A4 = str2num(get(handles.Joint_Angle4,'String'));

A4 = Add_A4;
A1 = str2num(get(handles.Joint_Angle1,'String'));
A2 = str2num(get(handles.Joint_Angle2,'String'));
A3 = str2num(get(handles.Joint_Angle3,'String'));
% A4 = str2num(get(handles.Joint_Angle4,'String'));
A5 = str2num(get(handles.Joint_Angle5,'String'));
A6 = str2num(get(handles.Joint_Angle6,'String'));

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Subtration_A4_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A4 = str2num(get(handles.Joint_Angle4,'String')) - 0.3*percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Joint_Angle4,'String',num2str(Add_A4));

A4 = Add_A4;
A1 = str2num(get(handles.Joint_Angle1,'String'));
A2 = str2num(get(handles.Joint_Angle2,'String'));
A3 = str2num(get(handles.Joint_Angle3,'String'));
% A4 = str2num(get(handles.Joint_Angle4,'String'));
A5 = str2num(get(handles.Joint_Angle5,'String'));
A6 = str2num(get(handles.Joint_Angle6,'String'));

if A4 <= -350
    A4 = -350;
    set(handles.Joint_Angle4,'String',num2str(A4));
end  

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Addition_A4_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A4 = str2num(get(handles.Joint_Angle4,'String')) + 0.3*percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Joint_Angle4,'String',num2str(Add_A4));

A4 = Add_A4;
A1 = str2num(get(handles.Joint_Angle1,'String'));
A2 = str2num(get(handles.Joint_Angle2,'String'));
A3 = str2num(get(handles.Joint_Angle3,'String'));
% A4 = str2num(get(handles.Joint_Angle4,'String'));
A5 = str2num(get(handles.Joint_Angle5,'String'));
A6 = str2num(get(handles.Joint_Angle6,'String'));

if A4 >= 350
    A4 = 350;
    set(handles.Joint_Angle4,'String',num2str(A4));
end  


[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Position_B_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_RY = str2num(get(handles.Position_B,'String'));

RY = Add_RY;
X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));
RZ = str2num(get(handles.Position_A,'String'));
% RY = str2num(get(handles.Position_B,'String'));
RX = str2num(get(handles.Position_C,'String'));

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

% [ X6_1,Y6_1,Z6_1,ax_1,by_1,cz_1,RX,RY,RZ ] = Joint2pos( theta1,theta2,theta3,theta4,theta5,theta6 );
% set(handles.Position_A,'String',num2str(RZ));
% set(handles.Position_B,'String',num2str(RY));
% set(handles.Position_C,'String',num2str(RX));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Subtration_B_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_RY = str2num(get(handles.Position_B,'String')) - 0.3 * percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Position_B,'String',num2str(Add_RY));

RY = Add_RY;
X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));
RZ = str2num(get(handles.Position_A,'String'));
% RY = str2num(get(handles.Position_B,'String'));
RX = str2num(get(handles.Position_C,'String'));

if RY < -180
    RY = RY + 360;
    set(handles.Position_B,'String',num2str(RY));
end  

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

% [ X6_1,Y6_1,Z6_1,ax_1,by_1,cz_1,RX,RY,RZ ] = Joint2pos( theta1,theta2,theta3,theta4,theta5,theta6 );
% set(handles.Position_A,'String',num2str(RZ));
% set(handles.Position_B,'String',num2str(RY));
% set(handles.Position_C,'String',num2str(RX));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Addition_B_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_RY = str2num(get(handles.Position_B,'String')) + 0.3 * percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Position_B,'String',num2str(Add_RY));

RY = Add_RY;
X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));
RZ = str2num(get(handles.Position_A,'String'));
% RY = str2num(get(handles.Position_B,'String'));
RX = str2num(get(handles.Position_C,'String'));

if RY > 180
    RY = RY - 360;
    set(handles.Position_B,'String',num2str(RY));
end  

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

% [ X6_1,Y6_1,Z6_1,ax_1,by_1,cz_1,RX,RY,RZ ] = Joint2pos( theta1,theta2,theta3,theta4,theta5,theta6 );
% set(handles.Position_A,'String',num2str(RZ));
% set(handles.Position_B,'String',num2str(RY));
% set(handles.Position_C,'String',num2str(RX));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Joint_Angle5_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A5 = str2num(get(handles.Joint_Angle5,'String'));

A5 = Add_A5;
A1 = str2num(get(handles.Joint_Angle1,'String'));
A2 = str2num(get(handles.Joint_Angle2,'String'));
A3 = str2num(get(handles.Joint_Angle3,'String'));
A4 = str2num(get(handles.Joint_Angle4,'String'));
% A5 = str2num(get(handles.Joint_Angle5,'String'));
A6 = str2num(get(handles.Joint_Angle6,'String'));

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Subtration_A5_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A5 = str2num(get(handles.Joint_Angle5,'String')) - 0.3*percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Joint_Angle5,'String',num2str(Add_A5));

A5 = Add_A5;
A1 = str2num(get(handles.Joint_Angle1,'String'));
A2 = str2num(get(handles.Joint_Angle2,'String'));
A3 = str2num(get(handles.Joint_Angle3,'String'));
A4 = str2num(get(handles.Joint_Angle4,'String'));
% A5 = str2num(get(handles.Joint_Angle5,'String'));
A6 = str2num(get(handles.Joint_Angle6,'String'));

if A5 <= -130
    A5 = -130;
    set(handles.Joint_Angle5,'String',num2str(A5));
end  

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Addition_A5_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A5 = str2num(get(handles.Joint_Angle5,'String')) + 0.3*percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Joint_Angle5,'String',num2str(Add_A5));

A5 = Add_A5;
A1 = str2num(get(handles.Joint_Angle1,'String'));
A2 = str2num(get(handles.Joint_Angle2,'String'));
A3 = str2num(get(handles.Joint_Angle3,'String'));
A4 = str2num(get(handles.Joint_Angle4,'String'));
% A5 = str2num(get(handles.Joint_Angle5,'String'));
A6 = str2num(get(handles.Joint_Angle6,'String'));

if A5 >= 130
    A5 = 130;
    set(handles.Joint_Angle5,'String',num2str(A5));
end  


[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Position_C_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_RX = str2num(get(handles.Position_C,'String'));

RX = Add_RX;
X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));
RZ = str2num(get(handles.Position_A,'String'));
RY = str2num(get(handles.Position_B,'String'));
% RX = str2num(get(handles.Position_C,'String'));

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

% [ X6_1,Y6_1,Z6_1,ax_1,by_1,cz_1,RX,RY,RZ ] = Joint2pos( theta1,theta2,theta3,theta4,theta5,theta6 );
% set(handles.Position_A,'String',num2str(RZ));
% set(handles.Position_B,'String',num2str(RY));
% set(handles.Position_C,'String',num2str(RX));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Subtration_C_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_RX = str2num(get(handles.Position_C,'String')) - 0.3 * percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Position_C,'String',num2str(Add_RX));

RX = Add_RX;
X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));
RZ = str2num(get(handles.Position_A,'String'));
RY = str2num(get(handles.Position_B,'String'));
% RX = str2num(get(handles.Position_C,'String'));

if RX < -180
    RX = RX + 360;
    set(handles.Position_C,'String',num2str(RX));
end  

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

% [ X6_1,Y6_1,Z6_1,ax_1,by_1,cz_1,RX,RY,RZ ] = Joint2pos( theta1,theta2,theta3,theta4,theta5,theta6 );
% set(handles.Position_A,'String',num2str(RZ));
% set(handles.Position_B,'String',num2str(RY));
% set(handles.Position_C,'String',num2str(RX));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Addition_C_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_RX = str2num(get(handles.Position_C,'String')) + 0.3 * percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Position_C,'String',num2str(Add_RX));

RX = Add_RX;
X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));
RZ = str2num(get(handles.Position_A,'String'));
RY = str2num(get(handles.Position_B,'String'));
% RX = str2num(get(handles.Position_C,'String'));

if RX > 180
    RX = RX - 360;
    set(handles.Position_C,'String',num2str(RX));
end  

R_abc = [ cosd(RZ)*cosd(RY) -cosd(RZ)*sind(RY)*sind(RX) - sind(RZ)*cosd(RX) -cosd(RZ)*sind(RY)*cosd(RX) + sind(RZ)*sind(RX);
         sind(RZ)*cosd(RY) -sind(RZ)*sind(RY)*sind(RX) + cosd(RZ)*cosd(RX) -sind(RZ)*sind(RY)*cosd(RX) - cosd(RZ)*sind(RX);
            sind(RY)                          cosd(RY)*sind(RX)                    cosd(RY)*cosd(RX)];

ax = R_abc(1,3); by = R_abc(2,3) ; cz = R_abc(3,3);

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

% [ X6_1,Y6_1,Z6_1,ax_1,by_1,cz_1,RX,RY,RZ ] = Joint2pos( theta1,theta2,theta3,theta4,theta5,theta6 );
% set(handles.Position_A,'String',num2str(RZ));
% set(handles.Position_B,'String',num2str(RY));
% set(handles.Position_C,'String',num2str(RX));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Joint_Angle6_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A6 = str2num(get(handles.Joint_Angle6,'String'));

A6 = Add_A6;
A1 = str2num(get(handles.Joint_Angle1,'String'));
A2 = str2num(get(handles.Joint_Angle2,'String'));
A3 = str2num(get(handles.Joint_Angle3,'String'));
A4 = str2num(get(handles.Joint_Angle4,'String'));
A5 = str2num(get(handles.Joint_Angle5,'String'));
% A6 = str2num(get(handles.Joint_Angle6,'String'));

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Subtration_A6_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A6 = str2num(get(handles.Joint_Angle6,'String')) - 0.3*percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Joint_Angle6,'String',num2str(Add_A6));

A6 = Add_A6;
A1 = str2num(get(handles.Joint_Angle1,'String'));
A2 = str2num(get(handles.Joint_Angle2,'String'));
A3 = str2num(get(handles.Joint_Angle3,'String'));
A4 = str2num(get(handles.Joint_Angle4,'String'));
A5 = str2num(get(handles.Joint_Angle5,'String'));
% A6 = str2num(get(handles.Joint_Angle6,'String'));

if A6 <= -350
    A6 = -350;
    set(handles.Joint_Angle6,'String',num2str(A6));
end  

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Addition_A6_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;
Add_A6 = str2num(get(handles.Joint_Angle6,'String')) + 0.3*percent * str2num(get(handles.Incremental_Percent,'String'));
set(handles.Joint_Angle6,'String',num2str(Add_A6));

A6 = Add_A6;
A1 = str2num(get(handles.Joint_Angle1,'String'));
A2 = str2num(get(handles.Joint_Angle2,'String'));
A3 = str2num(get(handles.Joint_Angle3,'String'));
A4 = str2num(get(handles.Joint_Angle4,'String'));
A5 = str2num(get(handles.Joint_Angle5,'String'));
% A6 = str2num(get(handles.Joint_Angle6,'String'));

if A6 >= 350
    A6 = 350;
    set(handles.Joint_Angle6,'String',num2str(A6));
end  

[X6,Y6,Z6,ax,by,cz,rx,ry,rz] = Joint2pos(A1,A2,A3,A4,A5,A6);

set(handles.Position_X,'String',num2str(X6));
set(handles.Position_Y,'String',num2str(Y6));
set(handles.Position_Z,'String',num2str(Z6));
set(handles.Position_A,'String',num2str(rz));
set(handles.Position_B,'String',num2str(ry));
set(handles.Position_C,'String',num2str(rx));

set(handles.Pose_a,'String',num2str(ax));
set(handles.Pose_b,'String',num2str(by));
set(handles.Pose_c,'String',num2str(cz));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(A1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(A2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(A3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(A4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(A5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(A6));
%===============================================================%

function Speed_Slider_Callback(hObject, eventdata, handles)

set(handles.Speed_Percent,'String',num2str(get(handles.Speed_Slider,'Value')));


function Pause_Callback(hObject, eventdata, handles)

global ModelName;
set_param(ModelName,'SimulationCommand','pause')

function Start_Callback(hObject, eventdata, handles)

global ModelName;

set_param([ModelName '/Constant_swich'],'Value',num2str(1));
set_param(ModelName,'SimulationCommand','start')

function Continue_Callback(hObject, eventdata, handles)

global ModelName;
set_param(ModelName,'SimulationCommand','continue')

function Stop_Callback(hObject, eventdata, handles)

global ModelName;
set_param(ModelName,'SimulationCommand','stop');

function Teaching_Callback(hObject, eventdata, handles)

%===============================================================%
global ModelName;
theta = [0 0 0 0 0 0 0 0];
assignin('base','theta',theta); 
% Back_theta = [0 0 0 0 0 0 0 0 0];
% assignin('base','Back_theta',Back_theta); 
% 函数 assignin，可以再工作区中安排变量；其中‘base’是基本工作空间的代号，‘theta’是在workspace中显示的变量名。
set_param([ModelName '/Constant_swich'],'Value',num2str(2));

set_param(ModelName, 'StartTime', '0');
set_param(ModelName, 'StopTime', 'inf');
set_param(ModelName,'SimulationCommand','start');
    
% set(handles.Incremental_Percent,'String',10);
% set(handles.Speed_Percent,'String',10);

set(handles.Position_X,'String',930);
set(handles.Position_Y,'String',0);
set(handles.Position_Z,'String',890);
set(handles.Position_A,'String',0);
set(handles.Position_B,'String',0);
set(handles.Position_C,'String',0);
set(handles.Pose_a,'String',0);
set(handles.Pose_b,'String',0);
set(handles.Pose_c,'String',1);

set(handles.Joint_Angle1,'String',0);
set(handles.Joint_Angle2,'String',-90);
set(handles.Joint_Angle3,'String',90);
set(handles.Joint_Angle4,'String',0);
set(handles.Joint_Angle5,'String',0);
set(handles.Joint_Angle6,'String',0);

set_param([ModelName '/Slider Gain1'],'Gain',num2str(0));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(-90));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(90));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(0));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(0));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(0));
%===============================================================%

function Import_pointdata_Callback(hObject, eventdata, handles)

global strh ModelName;

dt = str2num(get(handles.Speed_Percent,'String'));

theta = [0 0 0 0 0 0 0 0 0];
Back_theta = [0 0 0 0 0 0 0 0 0];
assignin('base','theta',theta);
assignin('base','Back_theta',Back_theta); 

[Fnameh,Pnameh]=uigetfile('*.txt');%Fnameh显示的文件名称，Pnameh显示的文件路径

strh = [Pnameh,Fnameh];%存储文件的路径及名称

set(handles.filepatch,'String',strh);%将strh的值传递给静态文本 

[X6,Y6,Z6,ax,by,cz] = textread(strh,'%f%f%f%f%f%f');

[ theta1,theta2,theta3,theta4,theta5,theta6,theta7,theta8,Length_d,t] = deal(zeros(length(X6),1));
for i = 1:1:length(X6)
    [theta1(i,1),theta2(i,1),theta3(i,1),theta4(i,1),theta5(i,1),theta6(i,1)] = Pos2joint(X6(i),Y6(i),Z6(i),ax(i),by(i),cz(i));
end

for i = 2:1:length(X6)
    Length_d(i,1) = sqrt( (X6(i)-X6(i-1))^2+(Y6(i)-Y6(i-1))^2+(Z6(i)-Z6(i-1))^2 );
end

for i = 2:1:length(X6)
    if Length_d(i,1) > 20
        t(i,1) = Length_d(i)/(3*dt);
    else
        t(i,1) = Length_d(i)/dt;
    end
    t(i,1) = t(i,1) + t(i-1,1);
end

theta = [t theta1 theta2 theta3 theta4 theta5 theta6 theta7 theta8 ];
pause_theta = theta(end,:);pause_theta(1)= theta(end,1)+1;
theta = [theta;pause_theta];

assignin('base','theta',theta);

% time = t(i,end);
% assignin('base','time',time);
% set_param(ModelName, 'StartTime', '0');
% set_param(ModelName, 'StopTime', 'time');

function Pose_a_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;

ax = str2num(get(handles.Pose_a,'String'));
by = str2num(get(handles.Pose_b,'String'));
cz = str2num(get(handles.Pose_c,'String'));

X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

[X6_1,Y6_1,Z6_1,ax_1,by_1,cz_1,RX,RY,RZ] = Joint2pos(theta1,theta2,theta3,theta4,theta5,theta6);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Position_A,'String',num2str(RZ));
set(handles.Position_B,'String',num2str(RY));
set(handles.Position_C,'String',num2str(RX));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Pose_b_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;

ax = str2num(get(handles.Pose_a,'String'));
by = str2num(get(handles.Pose_b,'String'));
cz = str2num(get(handles.Pose_c,'String'));

X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

[X6_1,Y6_1,Z6_1,ax_1,by_1,cz_1,RX,RY,RZ] = Joint2pos(theta1,theta2,theta3,theta4,theta5,theta6);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Position_A,'String',num2str(RZ));
set(handles.Position_B,'String',num2str(RY));
set(handles.Position_C,'String',num2str(RX));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function Pose_c_Callback(hObject, eventdata, handles)

%===============================================================%
global percent ModelName;

ax = str2num(get(handles.Pose_a,'String'));
by = str2num(get(handles.Pose_b,'String'));
cz = str2num(get(handles.Pose_c,'String'));

X6 = str2num(get(handles.Position_X,'String'));
Y6 = str2num(get(handles.Position_Y,'String'));
Z6 = str2num(get(handles.Position_Z,'String'));

[theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint(X6,Y6,Z6,ax,by,cz);

[X6_1,Y6_1,Z6_1,ax_1,by_1,cz_1,RX,RY,RZ] = Joint2pos(theta1,theta2,theta3,theta4,theta5,theta6);

set(handles.Joint_Angle1,'String',num2str(theta1));
set(handles.Joint_Angle2,'String',num2str(theta2));
set(handles.Joint_Angle3,'String',num2str(theta3));
set(handles.Joint_Angle4,'String',num2str(theta4));
set(handles.Joint_Angle5,'String',num2str(theta5));
set(handles.Joint_Angle6,'String',num2str(theta6));

set(handles.Position_A,'String',num2str(RZ));
set(handles.Position_B,'String',num2str(RY));
set(handles.Position_C,'String',num2str(RX));

set_param([ModelName '/Slider Gain1'],'Gain',num2str(theta1));
set_param([ModelName '/Slider Gain2'],'Gain',num2str(theta2));
set_param([ModelName '/Slider Gain3'],'Gain',num2str(theta3));
set_param([ModelName '/Slider Gain4'],'Gain',num2str(theta4));
set_param([ModelName '/Slider Gain5'],'Gain',num2str(theta5));
set_param([ModelName '/Slider Gain6'],'Gain',num2str(theta6));
%===============================================================%

function text14_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'增量指的是示教模式下每次增加或减少的值';'包括“X Y Z A B C A1 A2 A3 A4 A5 A6”';...
    '位置量Position包括“X Y Z”,单位：mm';'角度量Joint包括“A B C A1 A2 A3 A4 A5 A6”,单位：度';...
    '增量：10% 对应 Position：1mm，Joint：0.3度';'增量：100% 对应 Position：10mm，Joint：3度';...
    '增量：1000% 对应 Position：100mm，Joint：30度'},'增量介绍');

ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 330 160]);

function text15_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'速度指的是导入抛光点时生成的运行时间';'速度值越大，走完所有抛光点的时间越短';...
    '速度值越小，走完所有抛光点的时间越长';'速度：40% 对应的是机器人抛光时的正常运行速度';...
    '为加快仿真速度，可以将速度值设为：120%'},'速度介绍');

ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 290 120]);

% --------------------------------------------------------------------
function uipanel2_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'A1 A2 A3 A4 A5 A6为机器人的6个关节角';...
    'A1为机器人第一关节的关节角，关节角可调节范围为：-185~185度';...
    'A2为机器人第二关节的关节角，关节角可调节范围为：-155~35度';...
    'A3为机器人第三关节的关节角，关节角可调节范围为：-130~154度';...
    'A4为机器人第四关节的关节角，关节角可调节范围为：-350~350度';...
    'A5为机器人第五关节的关节角，关节角可调节范围为：-130~130度';...
    'A6为机器人第六关节的关节角，关节角可调节范围为：-350~350度';...
    ' ';'加减使得关节角超过可调节范围后，关节角不再变化';'请不要在输入框中输入可调节范围之外的值'},'关节角介绍');

ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
% set(hs, 'Resize', 'on'); % 手动改变，或者用
set(hs, 'Position', [520 320 380 205]);

% --------------------------------------------------------------------
function uipanel1_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'X Y Z为前端装置最末端所在位置在指定坐标系下的值';...
    '在世界坐标系下，X轴正向为机器人前方，Y轴正向为机器人左方，Z轴正向为机器人上方';...
    '当坐标值不在求解范围内，所有关节角的值会变为0度';...
    '当坐标值超出机器人可达工作空间，所有关节角的值会变为1度'},'坐标位置介绍');

ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 490 105]);

% --------------------------------------------------------------------
function uipanel7_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'A B C为前端装置在指定坐标系下的姿态角，也称为欧拉角';...
    '根据欧拉角可以求得变换矩阵，变换矩阵第三列为前端装置的法矢量';...
    'A为绕Z轴坐标旋转，B为绕当前Y轴旋转，C为绕当前X轴旋转';...
    '欧拉角存在最优解，为更好了解机器人运动方式，这里将最优解进行了屏蔽'},'姿态角介绍');

ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 420 105]);

function uipanel6_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'a b c为前端装置的法矢量，也为前端装置的中心轴';...
    '法矢量的方向参照了指定坐标系的方向，a对应x，b对应y，c对应z';...
    '法矢量也为第六关节变换矩阵Z轴的坐标，所以可以根据变换矩阵求得';...
    'A为绕Z轴坐标旋转，B为绕当前Y轴旋转，C为绕当前X轴旋转'},'法矢量介绍');

ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 380 105]);

function Teaching_ButtonDownFcn(hObject, eventdata, handles)
hs = msgbox({'示教模式指：用户可以通过操控面板使得机器人按照自己期望的路径运动';...
    '示教模式下，机器人不能连续运动，只能跳转到指定位置';...
    '当按下“示教”按钮时，所有位置及角度参数都进行了复位操作'},'示教模式介绍');
ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 420 85]);

function Drawpath_Callback(hObject, eventdata, handles)

%===============================================================%
global ModelName;
set_param(ModelName,'SimulationCommand','pause')
pause(2);
LX = evalin('base','X.Data');
LY = evalin('base','Y.Data');
LZ = evalin('base','Z.Data');
figure;
axis equal;
xlabel('X');ylabel('Y');zlabel('Z');
line(LX,LY,LZ);
%===============================================================%


function Drawpath_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'绘图指：在示教或离线编程模式下，matlab绘制出机器人在此运动期间所走过的路径';...
    '当按下“绘图”按钮时，simulink暂停运行，如需再次运行，需点击“继续”按钮'},'绘图介绍');
ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 460 65]);


function Pause_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'暂停：暂时停止simulink运行';...
    '继续：暂停后继续运行simulink';'停止：结束运行simulink'},'运行按钮介绍');
ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 180 85]);


function Import_pointdata_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'离线编程指：matlab根据所规划好的运动路径，simulink进行对应的运动仿真';...
    '导入抛光点会调用速度值大小，生成simulink可以识别的运动路径，再点击“开始”按钮';...
    '或者双击当前文件夹所需运动路径的mat文件，再点击“开始”按钮';...
    '生成mat文件中的轨迹规划函数可以规划更复杂的轨迹，但原理和导入抛光点函数的原理一致'},'离线编程介绍');
ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 520 105]);
