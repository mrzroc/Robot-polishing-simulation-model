function [ theta1,theta2,theta3,theta4,theta5,theta6] = Pos2joint( X6,Y6,Z6,ax,by,cz )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˵��ú���Ϊ�⿨KR16�����˵��˶�ѧ��⣬������ƽ�漸�ε��㷨������˵Ĺؽڽ�
Point_X6 = X6;Point_Y6 = Y6;Point_Z6 = Z6;

L1 = 260; %��һ�ؽڵĳ���
Z1 = 675; %��һ�ؽڵĸ߶�
L2 = 680;
L34 = sqrt(670^2 + 35^2);
L6 = 430; %�����ؽںͷ����ĳ���Ϊ158�����೤��Ϊĩ��ִ�����ĳ���  Ĭ��ֵ430

X4 = X6 + ax*L6/(sqrt(ax^2+by^2+cz^2)); %����ĩ��λ�˺�λ������Ĺؽ�ĩ��λ��
Y4 = Y6 + by*L6/(sqrt(ax^2+by^2+cz^2));
Z4 = Z6 + cz*L6/(sqrt(ax^2+by^2+cz^2));

if sqrt(X4^2+Y4^2) <= 260
    msgbox('������ĵ㲻����ⷶΧ��!', '������ʾ', 'error');%�Ѿ�����
    theta1 = 0;theta2 = 0;theta3 = 0;theta4 = 0;theta5 = 0;theta6 = 0;%�������6���Ƕ�Ϊ0
else
    X44 = X4;
    if X4 == 0
        t1 = -Y4/abs(Y4)*pi/2;
    else
        X6 = X44/abs(X44)*X6; % �˴���Ϊ����X4Ϊ��ֵ
        ax = X44/abs(X44)*ax;
        X4 = X6 + ax*L6/(sqrt(ax^2+by^2+cz^2)); %����ĩ��λ�˺�λ������Ĺؽ�ĩ��λ��
        
        t1 = -atan(Y4/X4); %���һ�ؽڵ�ת����
    end
    GZ65 = [ax,by,cz]; %�����ؽڵķ�������ҲΪ�����˵���̬
    
    X1 = L1*cos(t1);
    Y1 = -L1*sin(t1);
    
    % Բ1�İ뾶Ϊ L2,Բ2�İ뾶Ϊ L34,��Բ�ľ�
    L14 = sqrt( (X4-X1)^2 + (Y4-Y1)^2 + (Z4-Z1)^2 );
    if L14 > L2 + L34
        msgbox('������ĵ㳬�������˿ɴ�ռ�!', '������ʾ', 'error');%  ������е���˶���Χ
        theta1 = 1;theta2 = 1;theta3 = 1;theta4 = 1;theta5 = 1;theta6 = 1;%�������6���Ƕ�Ϊ1
    else
        Angle214 = acos( (L2^2+L14^2-L34^2)/(2*L2*L14) );
        if Z4-Z1 == 0
            Angle014 = 0;
        else
            Angle014 = atan( (Z4-Z1) / sqrt((Y4-Y1)^2+(X4-X1)^2) );
        end
        
        t2 = -(Angle214 + Angle014);% �ڶ��ؽڽǶ�
        
        X2 = X1 + L2*cos(t2)*cos(t1);%��ڶ��ؽ�ĩ��λ��
        Y2 = Y1 - L2*cos(t2)*sin(t1);
        Z2 = Z1 - L2*sin(t2);
        
        GZ21 = [X2-L1*cos(t1),Y2+L1*sin(t1),Z2-Z1];%�ؽ�2�ķ�����
        GZ24 = [X2-X4,Y2-Y4,Z2-Z4];%�ؽ�2��4�ķ�����
        
        t23 = acos(dot(GZ21,GZ24)/(norm(GZ21)*norm(GZ24)));%�ؽ�2��3�ļн�
        
        t34 = atan(35/670); %�ؽ�3��4����ƫ��
        
        t3 = t23 + t34;%�ؽ�3��ʵ��ת����
        
        X23 = X2 - 35*sin(t2-t3+pi)*cos(t1);%��ؽ�3����ʼλ��
        Y23 = Y2 + 35*sin(t2-t3+pi)*sin(t1);
        Z23 = Z2 - 35*cos(t2-t3+pi);
        
        GZ43 = [X23-X4,Y23-Y4,Z23-Z4];%�ؽ�3��4�ķ�����
        
        
        FACE_14 = cross([0 0 1],GZ43);%1��4���淨����
        FACE_46 = cross(GZ65,GZ43);%4��6���淨����
        
        if ax == 0 && by == 0
            t4 = 0;
        else
            t4 = acos(dot(FACE_14,FACE_46)/(norm(FACE_14)*norm(FACE_46))); % ������ļн�
        end
        % �� t5
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
        
        %�������ʵ��ת����
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
