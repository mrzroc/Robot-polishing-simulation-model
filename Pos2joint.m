function [ theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint( X6,Y6,Z6,ax,by,cz )
%UNTITLED2 此处显示有关此函数的摘要
%   此调用函数为库卡KR16机器人的运动学逆解，采用了平面几何的算法求机器人的关节角
Point_X6 = X6;Point_Y6 = Y6;Point_Z6 = Z6;

L1 = 260; %第一关节的长度
Z1 = 675; %第一关节的高度
L2 = 680;
L34 = sqrt(670^2 + 35^2);
L6 = 430; %第六关节和法兰的长度为158，其余长度为末端执行器的长度  默认值430

X4 = X6 + ax*L6/(sqrt(ax^2+by^2+cz^2)); %根据末端位姿和位置求第四关节末端位置
Y4 = Y6 + by*L6/(sqrt(ax^2+by^2+cz^2));
Z4 = Z6 + cz*L6/(sqrt(ax^2+by^2+cz^2));

if sqrt(X4^2+Y4^2) <= 260
    msgbox('所输入的点不在求解范围内!', '错误提示', 'error');%已经干涉
    theta1 = 0;theta2 = 0;theta3 = 0;theta4 = 0;theta5 = 0;theta6 = 0;%错误输出6个角度为0
else
    X44 = X4;
    if X4 == 0
        t1 = -Y4/abs(Y4)*pi/2;
    else
        X6 = X44/abs(X44)*X6; % 此处是为了让X4为正值
        ax = X44/abs(X44)*ax;
        X4 = X6 + ax*L6/(sqrt(ax^2+by^2+cz^2)); %根据末端位姿和位置求第四关节末端位置
        
        t1 = -atan(Y4/X4); %求第一关节的转动角
    end
    GZ65 = [ax,by,cz]; %第六关节的法向量，也为机器人的姿态
    
    X1 = L1*cos(t1);
    Y1 = -L1*sin(t1);
    
    % 圆1的半径为 L2,圆2的半径为 L34,求圆心距
    L14 = sqrt( (X4-X1)^2 + (Y4-Y1)^2 + (Z4-Z1)^2 );
    if L14 > L2 + L34
        msgbox('所输入的点超出机器人可达空间!', '错误提示', 'error');%  超出机械臂运动范围
        theta1 = 1;theta2 = 1;theta3 = 1;theta4 = 1;theta5 = 1;theta6 = 1;%错误输出6个角度为1
    else
        Angle214 = acos( (L2^2+L14^2-L34^2)/(2*L2*L14) );
        if Z4-Z1 == 0
            Angle014 = 0;
        else
            Angle014 = atan( (Z4-Z1) / sqrt((Y4-Y1)^2+(X4-X1)^2) );
        end
        
        t2 = -(Angle214 + Angle014);% 第二关节角度
        
        X2 = X1 + L2*cos(t2)*cos(t1);%求第二关节末端位置
        Y2 = Y1 - L2*cos(t2)*sin(t1);
        Z2 = Z1 - L2*sin(t2);
        
        GZ21 = [X2-L1*cos(t1),Y2+L1*sin(t1),Z2-Z1];%关节2的法向量
        GZ24 = [X2-X4,Y2-Y4,Z2-Z4];%关节2与4的法向量
        
        t23 = acos(dot(GZ21,GZ24)/(norm(GZ21)*norm(GZ24)));%关节2和3的夹角
        
        t34 = atan(35/670); %关节3与4的轴偏角
        
        t3 = t23 + t34;%关节3的实际转动角
        
        X23 = X2 - 35*sin(t2-t3+pi)*cos(t1);%求关节3的起始位置
        Y23 = Y2 + 35*sin(t2-t3+pi)*sin(t1);
        Z23 = Z2 - 35*cos(t2-t3+pi);
        
        GZ43 = [X23-X4,Y23-Y4,Z23-Z4];%关节3与4的法向量
        
        
        FACE_14 = cross([0 0 1],GZ43);%1和4的面法向量
        FACE_46 = cross(GZ65,GZ43);%4和6的面法向量
        
        if ax == 0 && by == 0
            t4 = 0;
        else
            t4 = acos(dot(FACE_14,FACE_46)/(norm(FACE_14)*norm(FACE_46))); % 两个面的夹角
        end
        % 求 t5
        if X4 == 0
            t5 = -pi/2 + acos(dot(GZ43,GZ65)/(norm(GZ65)*norm(GZ43)));
        else
            if X4 - X23 == 0
                if X6 > X4
                    t5 = -pi/2 - acos(dot(GZ43,GZ65)/(norm(GZ65)*norm(GZ43)));
                else
                    t5 = -pi/2 + acos(dot(GZ43,GZ65)/(norm(GZ65)*norm(GZ43)));
                end
            else
                if ((Z4-Z23)*(X6-X23)/(X4-X23)+Z23-Z6)*(X4-X23)>0
                    t5 = -pi/2 + acos(dot(GZ43,GZ65)/(norm(GZ65)*norm(GZ43)));
                else
                    t5 = -pi/2 - acos(dot(GZ43,GZ65)/(norm(GZ65)*norm(GZ43)));
                end
            end
        end
        
        t6 = 0;
        
        %求机器人实际转动角
        if X44 >= 0
            theta1 = 180/pi*t1;
            theta4 = -180/pi*t4;
            
        else
            theta1 = 180/pi*t1;
            theta1 = X44/norm(X44)*180 - theta1;
            theta4 = 180/pi*t4;
        end
        theta2 = 180/pi*t2;
        theta3 = -180/pi*t3+180;
        theta5 = 180/pi*t5;
        theta6 = 180/pi*t6;
    end
end


[ Check_PX6,Check_PY6,Check_PZ6] = CHECK_Joint2pos( theta1,theta2,theta3,theta4,theta5,theta6 );

if abs(Check_PX6 - Point_X6) >0.001 || abs(Check_PY6 - Point_Y6) >0.001 || abs(Check_PZ6 - Point_Z6) >0.001
    
    theta4_num(1) = theta4;
    theta4_num(2) = -theta4;
    theta4_num(3) = -180 - theta4;
    theta4_num(4) = 180 + theta4;
    
    theta5_num(1) = theta5;
    theta5_num(2) = -theta5;
    theta5_num(3) = -180 - theta5;
    theta5_num(4) = -180 + theta5;
    
    right_num = 0 ;
    for num_i = 1:1:4
        for num_j = 1:1:4
            [ Check_PX6,Check_PY6,Check_PZ6 ] = CHECK_Joint2pos( theta1,theta2,theta3,theta4_num(num_i),theta5_num(num_j),theta6 );
            if abs(Check_PX6 - Point_X6) < 0.001 && abs(Check_PY6 - Point_Y6) < 0.001 && abs(Check_PZ6 - Point_Z6) < 0.001
                right_num = right_num + 1;
                theta4 = theta4_num(num_i);
                theta5 = theta5_num(num_j);

            end
        end
    end
    if theta5 < -90
        theta5 = -180 - theta5;
        theta4 = 180 + theta4;
%     else if 
%             
     end
    if theta4 > 180
        theta4 = theta4 - 360;
    else
        if theta4 < -180
            theta4 = theta4 + 360;
        else
        end
    end
    
end

end

function [ CK_X6,CK_Y6,CK_Z6] = CHECK_Joint2pos( theta1,theta2,theta3,theta4,theta5,theta6 )

theta3 = theta3-90; % t3-pi/2

T1=[cosd(theta1) sind(theta1) 0 0; -sind(theta1) cosd(theta1) 0 0; 0 0 1 0.675; 0 0 0 1];

T2=[cosd(theta2) -sind(theta2) 0 0.260; 0 0 1 0; -sind(theta2) -cosd(theta2) 0 0; 0 0 0 1];

T3=[cosd(theta3) -sind(theta3) 0 0.680; sind(theta3) cosd(theta3) 0 0; 0 0 1 0; 0 0 0 1];

T4=[cosd(theta4) -sind(theta4) 0 -0.035; 0 0 1 0.670; -sind(theta4) -cosd(theta4) 0 0; 0 0 0 1];

T5=[cosd(theta5) -sind(theta5) 0 0; 0 0 -1 0; sind(theta5) cosd(theta5) 0 0; 0 0 0 1];

T6=[cosd(theta6) -sind(theta6) 0 -0.430; 0 0 1 0; -sind(theta6) -cosd(theta6) 0 0; 0 0 0 1];

T16 = 1000*T1*T2*T3*T4*T5*T6;

CK_X6 = T16(1,4);
CK_Y6 = T16(2,4); 
CK_Z6 = T16(3,4);

end
