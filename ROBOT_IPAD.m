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
%===============================================================%���ȫ�ֱ���
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
% ���� assignin�������ٹ������а��ű��������С�base���ǻ��������ռ�Ĵ��ţ���theta������workspace����ʾ�ı�������
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

[Fnameh,Pnameh]=uigetfile('*.txt');%Fnameh��ʾ���ļ����ƣ�Pnameh��ʾ���ļ�·��

strh = [Pnameh,Fnameh];%�洢�ļ���·��������

set(handles.filepatch,'String',strh);%��strh��ֵ���ݸ���̬�ı� 

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

hs = msgbox({'����ָ����ʾ��ģʽ��ÿ�����ӻ���ٵ�ֵ';'������X Y Z A B C A1 A2 A3 A4 A5 A6��';...
    'λ����Position������X Y Z��,��λ��mm';'�Ƕ���Joint������A B C A1 A2 A3 A4 A5 A6��,��λ����';...
    '������10% ��Ӧ Position��1mm��Joint��0.3��';'������100% ��Ӧ Position��10mm��Joint��3��';...
    '������1000% ��Ӧ Position��100mm��Joint��30��'},'��������');

ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 330 160]);

function text15_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'�ٶ�ָ���ǵ����׹��ʱ���ɵ�����ʱ��';'�ٶ�ֵԽ�����������׹���ʱ��Խ��';...
    '�ٶ�ֵԽС�����������׹���ʱ��Խ��';'�ٶȣ�40% ��Ӧ���ǻ������׹�ʱ�����������ٶ�';...
    'Ϊ�ӿ�����ٶȣ����Խ��ٶ�ֵ��Ϊ��120%'},'�ٶȽ���');

ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 290 120]);

% --------------------------------------------------------------------
function uipanel2_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'A1 A2 A3 A4 A5 A6Ϊ�����˵�6���ؽڽ�';...
    'A1Ϊ�����˵�һ�ؽڵĹؽڽǣ��ؽڽǿɵ��ڷ�ΧΪ��-185~185��';...
    'A2Ϊ�����˵ڶ��ؽڵĹؽڽǣ��ؽڽǿɵ��ڷ�ΧΪ��-155~35��';...
    'A3Ϊ�����˵����ؽڵĹؽڽǣ��ؽڽǿɵ��ڷ�ΧΪ��-130~154��';...
    'A4Ϊ�����˵��ĹؽڵĹؽڽǣ��ؽڽǿɵ��ڷ�ΧΪ��-350~350��';...
    'A5Ϊ�����˵���ؽڵĹؽڽǣ��ؽڽǿɵ��ڷ�ΧΪ��-130~130��';...
    'A6Ϊ�����˵����ؽڵĹؽڽǣ��ؽڽǿɵ��ڷ�ΧΪ��-350~350��';...
    ' ';'�Ӽ�ʹ�ùؽڽǳ����ɵ��ڷ�Χ�󣬹ؽڽǲ��ٱ仯';'�벻Ҫ�������������ɵ��ڷ�Χ֮���ֵ'},'�ؽڽǽ���');

ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
% set(hs, 'Resize', 'on'); % �ֶ��ı䣬������
set(hs, 'Position', [520 320 380 205]);

% --------------------------------------------------------------------
function uipanel1_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'X Y ZΪǰ��װ����ĩ������λ����ָ������ϵ�µ�ֵ';...
    '����������ϵ�£�X������Ϊ������ǰ����Y������Ϊ�������󷽣�Z������Ϊ�������Ϸ�';...
    '������ֵ������ⷶΧ�ڣ����йؽڽǵ�ֵ���Ϊ0��';...
    '������ֵ���������˿ɴ﹤���ռ䣬���йؽڽǵ�ֵ���Ϊ1��'},'����λ�ý���');

ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 490 105]);

% --------------------------------------------------------------------
function uipanel7_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'A B CΪǰ��װ����ָ������ϵ�µ���̬�ǣ�Ҳ��Ϊŷ����';...
    '����ŷ���ǿ�����ñ任���󣬱任���������Ϊǰ��װ�õķ�ʸ��';...
    'AΪ��Z��������ת��BΪ�Ƶ�ǰY����ת��CΪ�Ƶ�ǰX����ת';...
    'ŷ���Ǵ������Ž⣬Ϊ�����˽�������˶���ʽ�����ｫ���Ž����������'},'��̬�ǽ���');

ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 420 105]);

function uipanel6_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'a b cΪǰ��װ�õķ�ʸ����ҲΪǰ��װ�õ�������';...
    '��ʸ���ķ��������ָ������ϵ�ķ���a��Ӧx��b��Ӧy��c��Ӧz';...
    '��ʸ��ҲΪ�����ؽڱ任����Z������꣬���Կ��Ը��ݱ任�������';...
    'AΪ��Z��������ת��BΪ�Ƶ�ǰY����ת��CΪ�Ƶ�ǰX����ת'},'��ʸ������');

ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 380 105]);

function Teaching_ButtonDownFcn(hObject, eventdata, handles)
hs = msgbox({'ʾ��ģʽָ���û�����ͨ���ٿ����ʹ�û����˰����Լ�������·���˶�';...
    'ʾ��ģʽ�£������˲��������˶���ֻ����ת��ָ��λ��';...
    '�����¡�ʾ�̡���ťʱ������λ�ü��ǶȲ����������˸�λ����'},'ʾ��ģʽ����');
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

hs = msgbox({'��ͼָ����ʾ�̻����߱��ģʽ�£�matlab���Ƴ��������ڴ��˶��ڼ����߹���·��';...
    '�����¡���ͼ����ťʱ��simulink��ͣ���У������ٴ����У���������������ť'},'��ͼ����');
ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 460 65]);


function Pause_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'��ͣ����ʱֹͣsimulink����';...
    '��������ͣ���������simulink';'ֹͣ����������simulink'},'���а�ť����');
ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 180 85]);


function Import_pointdata_ButtonDownFcn(hObject, eventdata, handles)

hs = msgbox({'���߱��ָ��matlab�������滮�õ��˶�·����simulink���ж�Ӧ���˶�����';...
    '�����׹�������ٶ�ֵ��С������simulink����ʶ����˶�·�����ٵ������ʼ����ť';...
    '����˫����ǰ�ļ��������˶�·����mat�ļ����ٵ������ʼ����ť';...
    '����mat�ļ��еĹ켣�滮�������Թ滮�����ӵĹ켣����ԭ��͵����׹�㺯����ԭ��һ��'},'���߱�̽���');
ht = findobj(hs, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(hs, 'Position', [520 320 520 105]);
