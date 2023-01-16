clc; clear;
disp('Welcome to Group 3 MATLAB Chess!');
disp('*********************************');
disp('            ');
disp('INSTRUCTIONS:');
disp('  The Pawn can move forward 1 or 2 squares on first move, and only 1 square after.');
disp('  The Pawn can only attack diagonally 1 square.');
disp('  The Knight moves 2 squares foward and 1 square to the side.');
disp('  The Bishop can move diagonally.');
disp('  The Rook can move on straight paths.');
disp('  The Queen can move diagonally and on straight paths.');
disp('  The King can move one sqaure in any direction.');
disp('  You lose when your king is checkmated, both attacked and unable to escape.')
disp('  Your king is captured!');
disp('             ');
disp('MORE RULES:');
disp('  Pawn Promotion: When your pawn reaches the opposite rank, it can promote to a Queen, Rook, Bishop, or Knight.');
disp('    it will only change functionality');
disp('  Castling: If the king and a rook have not moved and they arent obstructed, the king can move 2 spaces and put the rook on the passed space.');
disp('  En Passant: Pawns can attack a pawn that moved 2 spaces to avoid capture as if it only moved 1 space. Only legal on next move.');
disp('  NOTE: There is no Stalemate.');
disp('             ');
disp('MOVEMENT RULES:');
disp('  First type the square of the piece you wish to move.');
disp('  Next type the square you wish to move it to.')
disp('  The entry should be one line (for example: e2e4).');
disp('              ');
disp('Press the Enter key to start! White moves first!');
input('             ');

board = uint8(zeros(1000,1000,3));
%Making the Chess Board
for ii = 2:1:9
    for jj = 2:1:9
        if mod(ii+jj,2) == 0
            board(100*(ii-1)+1:100*ii, 100*(jj-1)+1:100*jj, 1) = 255; %Light Squares
            board(100*(ii-1)+1:100*ii, 100*(jj-1)+1:100*jj, 2) = 220;
            board(100*(ii-1)+1:100*ii, 100*(jj-1)+1:100*jj, 3) = 130;
        else
            board(100*(ii-1)+1:100*ii, 100*(jj-1)+1:100*jj, 1) = 110; %Dark Squares
            board(100*(ii-1)+1:100*ii, 100*(jj-1)+1:100*jj, 2) = 85;
            board(100*(ii-1)+1:100*ii, 100*(jj-1)+1:100*jj, 3) = 15;
        end
    end
end
%Making the border white
board(1:95,:,:) = 255;
board(906:1000,:,:) = 255;
board(:,1:95,:) = 255;
board(:,906:1000,:) = 255;

%Insertion of text
position = zeros(16,2);
text = ['a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' '8' '7' '6' '5' '4' '3' '2' '1'];
%Letters
for ii = 1:8
    position(ii) = (ii*100)+20;
    position(ii+16) = 910;
end
%Numbers
for ii = 1:8
    position(ii+8) = 20;
    position(ii+24) = (ii*100)+15;
end

for ii = 1:16
    temptext = text(ii);
    tempposition = [position(ii,1) position(ii,2)];
    board = insertText(board,tempposition,temptext,'FontSize',50,'BoxColor',...
        'white','BoxOpacity',1.0,'TextColor','black');
end


res = input('Type "yes" if you have uploaded the piece files, or type "no": ','s');
if strcmpi('yes',res) == 0
    
    %Creation of white pawn placement
    p_w = zeros(8,2);
    for ii = 1:8
        p_w(ii) = (ii*100)+1;
        p_w(ii+8) = 701;
    end
    for pp = 1:8
        for ii = 1:100
            for jj = 1:100
                if sqrt((ii-30)^2+(jj-49)^2) <= 18 %Circle
                    board(ii+p_w(pp,2),jj+p_w(pp,1),:) = 255;
                end
                if ii>=jj && jj>=-ii+100 && ii<85 %Triangle
                    board(ii+p_w(pp,2),jj+p_w(pp,1),:) = 255;
                end
            end
        end
        board(p_w(pp,2)+30:p_w(pp,2)+80, p_w(pp,1)+39:p_w(pp,1)+60, :) = 255; %Shaft
        board(p_w(pp,2)+48:p_w(pp,2)+53, p_w(pp,1)+29:p_w(pp,1)+70, :) = 255; %Neck
    end
    
    %Creation of black pawn placement
    p_b = zeros(8,2);
    for ii = 1:8
        p_b(ii) = (ii*100)+1;
        p_b(ii+8) = 201;
    end
    for pp = 1:8
        for ii = 1:100
            for jj = 1:100
                if sqrt((ii-30)^2+(jj-49)^2) <= 18 %Circle
                    board(ii+p_b(pp,2),jj+p_b(pp,1),:) = 0;
                end
                if ii>=jj && jj>=-ii+100 && ii<85 %Triangle
                    board(ii+p_b(pp,2),jj+p_b(pp,1),:) = 0;
                end
            end
        end
        board(p_b(pp,2)+30:p_b(pp,2)+80, p_b(pp,1)+39:p_b(pp,1)+60, :) = 0; %Shaft
        board(p_b(pp,2)+48:p_b(pp,2)+53, p_b(pp,1)+29:p_b(pp,1)+70, :) = 0; %Neck
    end
    
    %Creation of White Rooks
    r_w = [101 801; 801 801];
    for rr = 1:2
        board(r_w(rr,2)+30:r_w(rr,2)+85, r_w(rr,1)+29:r_w(rr,1)+70, :) = 255;
        board(r_w(rr,2)+70:r_w(rr,2)+85, r_w(rr,1)+19:r_w(rr,1)+80, :) = 255;
        board(r_w(rr,2)+15:r_w(rr,2)+35, r_w(rr,1)+24:r_w(rr,1)+35, :) = 255;
        board(r_w(rr,2)+15:r_w(rr,2)+35, r_w(rr,1)+44:r_w(rr,1)+55, :) = 255;
        board(r_w(rr,2)+15:r_w(rr,2)+35, r_w(rr,1)+64:r_w(rr,1)+75, :) = 255;
    end
    
    %Creation of Black Rooks
    r_b = [101 101; 801 101];
    for rr = 1:2
        board(r_b(rr,2)+30:r_b(rr,2)+85, r_b(rr,1)+29:r_b(rr,1)+70, :) = 0;
        board(r_b(rr,2)+70:r_b(rr,2)+85, r_b(rr,1)+19:r_b(rr,1)+80, :) = 0;
        board(r_b(rr,2)+15:r_b(rr,2)+35, r_b(rr,1)+24:r_b(rr,1)+35, :) = 0;
        board(r_b(rr,2)+15:r_b(rr,2)+35, r_b(rr,1)+44:r_b(rr,1)+55, :) = 0;
        board(r_b(rr,2)+15:r_b(rr,2)+35, r_b(rr,1)+64:r_b(rr,1)+75, :) = 0;
    end
    
    %Creation of White Knights
    n_w = [201 801; 701 801];
    for nn = 1:2
        for ii = 1:100
            for jj = 1:100
                if jj>-ii+100 && ii<85 && (sqrt((ii-50)^2+(jj-30)^2)<=40 || ii>jj)
                    board(ii+n_w(nn,2),jj+n_w(nn,1),:) = 255;
                end
                if sqrt((ii-50)^2+(jj-46)^2)<=26 && ii<50 && sqrt((ii-38)^2+(jj-35)^2)>4
                    board(ii+n_w(nn,2),jj+n_w(nn,1),:) = 255;
                end
                if sqrt((ii-48)^2+(jj-32)^2)<=12 && ii>=50
                    board(ii+n_w(nn,2),jj+n_w(nn,1),:) = 255;
                end
            end
        end
    end
    
    %Creation of Black Knights
    n_b = [201 101; 701 101];
    for nn = 1:2
        for ii = 1:100
            for jj = 1:100
                if jj>-ii+100 && ii<85 && (sqrt((ii-50)^2+(jj-30)^2)<=40 || ii>jj)
                    board(ii+n_b(nn,2),jj+n_b(nn,1),:) = 0;
                end
                if sqrt((ii-50)^2+(jj-46)^2)<=26 && ii<50 && sqrt((ii-38)^2+(jj-35)^2)>4
                    board(ii+n_b(nn,2),jj+n_b(nn,1),:) = 0;
                end
                if sqrt((ii-48)^2+(jj-32)^2)<=12 && ii>=50
                    board(ii+n_b(nn,2),jj+n_b(nn,1),:) = 0;
                end
            end
        end
    end
    
    %Creation of White Bishops
    b_w = [301 801; 601 801];
    for bb = 1:2
        for ii = 1:100
            for jj = 1:100
                if ii>=(2*jj)-74 && (2*jj)-25>=-ii+100 && ii<85 %Triangle
                    board(ii+b_w(bb,2),jj+b_w(bb,1),:) = 255;
                end
                if sqrt((ii-20)^2+(jj-49)^2) <= 10 %Circle
                    board(ii+b_w(bb,2),jj+b_w(bb,1),:) = 255;
                end
            end
        end
    end
    
    %Creation of Black Bishops
    b_w = [301 101; 601 101];
    for bb = 1:2
        for ii = 1:100
            for jj = 1:100
                if ii>=(2*jj)-74 && (2*jj)-25>=-ii+100 && ii<85 %Triangle
                    board(ii+b_w(bb,2),jj+b_w(bb,1),:) = 0;
                end
                if sqrt((ii-20)^2+(jj-49)^2) <= 10 %Circle
                    board(ii+b_w(bb,2),jj+b_w(bb,1),:) = 0;
                end
            end
        end
    end
    
    %Creation of White Queen
    text = 'Q';
    position = [401 801];
    position = position - [15,30];
    board = insertText(board,position,text,'FontSize',85,...
        'BoxColor','red','BoxOpacity',0,'TextColor','white');
    
    %Creation of Black Queen
    text = 'Q';
    position = [401 101];
    position = position - [15,30];
    board = insertText(board,position,text,'FontSize',85,...
        'BoxColor','red','BoxOpacity',0,'TextColor','black');
    
    %Creation of White King
    k_w = [501 801];
    board(k_w(2)+15:k_w(2)+85, k_w(1)+44:k_w(1)+55, :) = 255;
    board(k_w(2)+35:k_w(2)+45, k_w(1)+19:k_w(1)+80, :) = 255;
    
    %Creation of Black King
    k_b = [501 101];
    board(k_b(2)+15:k_b(2)+85, k_b(1)+44:k_b(1)+55, :) = 0;
    board(k_b(2)+35:k_b(2)+45, k_b(1)+19:k_b(1)+80, :) = 0;
    
elseif strcmpi('yes',res)
    
    %White Pawn
    White_Pawn = imread('White_Pawn.png');
    p_w = zeros(8,2);
    for ii = 1:8
        p_w(ii,1) = (ii*100)+1;
        p_w(ii,2) = 701;
    end
    for ii = 1:8
        board(p_w(ii, 2):p_w(ii, 2)+99, p_w(ii, 1):p_w(ii, 1)+99, :) = White_Pawn;
    end
    
    %Black Pawn
    Black_Pawn = imread('Black_Pawn.png');
    p_b = zeros(8,2);
    for ii = 1:8
        p_b(ii,1) = (ii*100)+1;
        p_b(ii,2) = 201;
    end
    for ii = 1:8
        board(p_b(ii, 2):p_b(ii, 2)+99, p_b(ii, 1):p_b(ii, 1)+99, :) = Black_Pawn;
    end
    
    %White Rook
    White_Rook = imread('White_Rook.png');
    r_w = [101 801; 801 801];
    for ii = 1:2
        board(r_w(ii, 2):r_w(ii, 2)+99, r_w(ii, 1):r_w(ii, 1)+99, :) = White_Rook;
    end
    
    %Black Rook
    Black_Rook = imread('Black_Rook.png');
    r_b = [101 101; 801 101];
    for ii = 1:2
        board(r_b(ii, 2):r_b(ii, 2)+99, r_b(ii, 1):r_b(ii, 1)+99, :) = Black_Rook;
    end
    
    %White Knight
    White_Knight = imread('White_Knight.png');
    n_w = [201 801; 701 801];
    for ii = 1:2
        board(n_w(ii, 2):n_w(ii, 2)+99, n_w(ii, 1):n_w(ii, 1)+99, :) = White_Knight;
    end
    
    %Black Knight
    Black_Knight = imread('Black_Knight.png');
    n_b = [201 101; 701 101];
    for ii = 1:2
        board(n_b(ii, 2):n_b(ii, 2)+99, n_b(ii, 1):n_b(ii, 1)+99, :) = Black_Knight;
    end
    
    %White Bishop
    White_Bishop = imread('White_Bishop.png');
    b_w = [301 801; 601 801];
    for ii = 1:2
        board(b_w(ii, 2):b_w(ii, 2)+99, b_w(ii, 1):b_w(ii, 1)+99, :) = White_Bishop;
    end
    
    %Black Bishop
    Black_Bishop = imread('Black_Bishop.png');
    b_b = [301 101; 601 101];
    for ii = 1:2
        board(b_b(ii, 2):b_b(ii, 2)+99, b_b(ii, 1):b_b(ii, 1)+99, :) = Black_Bishop;
    end
    
    %White Queen
    White_Queen = imread('White_Queen.png');
    board(801:900, 401:500, :) = White_Queen;
    
    %Black Queen
    Black_Queen = imread('Black_Queen.png');
    board(101:200, 401:500, :) = Black_Queen;
    
    %White King
    White_King = imread('White_King.png');
    board(801:900, 501:600, :) = White_King;
    
    %Black King
    Black_King = imread('Black_King.png');
    board(101:200, 501:600, :) = Black_King;
end

mat = [10 9 8 11 12 8 9 10; 7 7 7 7 7 7 7 7 ; ...
    0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0;...
    1 1 1 1 1 1 1 1; 4 3 2 5 6 2 3 4];

wcastle1 = 0; wcastle2 = 0;
bcastle1 = 0; bcastle2 = 0;
cnt = 1;
x = 0;
ep = 0;
epf = 0;
movecnt = 0;

while true
    board_view = board;
    for ii = 101:1:900
        for jj = 101:1:900
            if abs(board(ii,jj,1) - board(ii,jj,3)) > 10
                if mod(floor((ii-1)/100)+floor((jj-1)/100),2) == 0
                    board_view(ii, jj, 1) = 255; %Light Squares
                    board_view(ii, jj, 2) = 220;
                    board_view(ii, jj, 3) = 130;
                    if movecnt>0
                        if ((ii>(rank1*100) && ii<=((rank1+1)*100)) && (jj>(file1*100) && jj<=((file1+1)*100))) || ...
                                ((ii>(rank2*100) && ii<=((rank2+1)*100)) && (jj>(file2*100) && jj<=((file2+1)*100)))
                            board_view(ii, jj, 2) = 160; %Light Orange
                            board_view(ii, jj, 3) = 80;
                        end
                    end
                else
                    board_view(ii, jj, 1) = 110; %Dark Squares
                    board_view(ii, jj, 2) = 85;
                    board_view(ii, jj, 3) = 15;
                    if movecnt>0
                        if ((ii>(rank1*100) && ii<=((rank1+1)*100)) && (jj>(file1*100) && jj<=((file1+1)*100))) || ...
                                ((ii>(rank2*100) && ii<=((rank2+1)*100)) && (jj>(file2*100) && jj<=((file2+1)*100)))
                            board_view(ii, jj, 1) = 200; %Dark Orange
                            board_view(ii, jj, 2) = 100;
                            board_view(ii, jj, 3) = 10;
                        end
                    end
                end
            end
        end
    end
    imshow(board_view);
    
    while true
        if cnt == 1
            move = input('White to move: ','s');
        else
            move = input('Black to move: ','s');
        end
        
        file1 = move(1)-96;
        file2 = move(3)-96;
        rank1 = 9-str2double(move(2));
        rank2 = 9-str2double(move(4));
        
        if length(move)~=4
            disp('Invalid Entry!');
            continue;
        end
        if (move(1:2:3)>='a' & move(1:2:3)<='h' & move(2:2:4)>='1' & move(2:2:4)<='8')
            if cnt==1 && mat(rank1,file1)>=1 && mat(rank1,file1)<=6 ...
                    && (mat(rank2,file2)==0 || mat(rank2,file2)>=7)
                
            elseif cnt==-1 && mat(rank1,file1)>=7 && mat(rank2,file2)<=6
                
            else
                disp('Invalid entry!');
                continue;
            end
        else
            disp('Invalid entry!');
            continue;
        end
        
        start = mat(rank1,file1);
        dest = mat(rank2,file2);
        
        %Space Verification
        space = true;
        if str2double(move(2))==str2double(move(4)) && abs(file1-file2)>1
            for ii = 1:abs(file1-file2)-1
                if file1>file2
                    if mat(rank1,file1-ii) ~= 0
                        space = false;
                        break;
                    end
                else
                    if mat(rank1,file1+ii) ~= 0
                        space = false;
                        break;
                    end
                end
            end
        elseif file1 == file2 && abs(str2double(move(2))-str2double(move(4)))>1
            for ii = 1:abs(str2double(move(2))-str2double(move(4)))-1
                if str2double(move(2))>str2double(move(4))
                    if mat(rank1+ii,file1) ~= 0
                        space = false;
                        break;
                    end
                else
                    if mat(rank1-ii,file1) ~= 0
                        space = false;
                        break;
                    end
                end
            end
        elseif str2double(move(2))-file1 == str2double(move(4))-file2 && abs(file2-file1)>1
            for ii = 1:abs(file2-file1)-1
                if file1>file2
                    if mat(rank1+ii,file1-ii) ~= 0
                        space = false;
                        break;
                    end
                else
                    if mat(rank1-ii,file1+ii) ~= 0
                        space = false;
                        break;
                    end
                end
            end
        elseif str2double(move(2))+file1 == str2double(move(4))+file2 && abs(file2-file1)>1
            for ii = 1:abs(file2-file1)-1
                if file1>file2
                    if mat(rank1-ii,file1-ii) ~= 0
                        space = false;
                        break;
                    end
                else
                    if mat(rank1+ii,file1+ii) ~= 0
                        space = false;
                        break;
                    end
                end
            end
        end
        
        if space == false
            disp('Invalid entry!');
            continue;
        end
        
        %Knight Verification
        if start == 3 || start == 9
            if abs(str2double(move(2))-str2double(move(4)))==2 && abs(file1-file2)==1 || ...
                    abs(str2double(move(2))-str2double(move(4)))==1 && abs(file1-file2)==2
            else
                disp('Invalid entry!');
                continue;
            end
            
            %Bishop Verification
        elseif start == 2 || start == 8
            if str2double(move(2))-file1 == str2double(move(4))-file2 || ...
                    str2double(move(2))+file1 == str2double(move(4))+file2
            else
                disp('Invalid entry!');
                continue;
            end
            
            %Rook Verification
        elseif start == 4 || start == 10
            if str2double(move(2))==str2double(move(4)) || file1==file2
            else
                disp('Invalid entry!');
                continue;
            end
            if start == 4 && file1==1
                wcastle1 = 1;
            elseif start == 4 && file1==8
                wcastle2 = 1;
            elseif start == 10 && file1==1
                bcastle1 = 1;
            elseif start == 10 && file1==8
                bcastle2 = 1;
            end
            
            %King Verification
        elseif start == 6 || start == 12
            %CASTLING
            if start == 6
                if str2double(move(2))==str2double(move(4)) && file1-file2==2 && wcastle1==0 && mat(8,2)==0
                    mat(8,4) = 4; mat(8,1) = 0;
                    board(801:900, 401:500, :) = board(801:900, 101:200, :);
                    for ii = 1:100
                        for jj = 1:100
                            board(800+ii, 100+jj, :) = board(801, 101, :);
                        end
                    end
                    wcastle1 = 1; wcastle2 = 1;
                    
                elseif str2double(move(2))==str2double(move(4)) && file1-file2==-2 && wcastle2==0
                    mat(8,6) = 4; mat(8,8) = 0;
                    board(801:900, 601:700, :) = board(801:900, 801:900, :);
                    for ii = 1:100
                        for jj = 1:100
                            board(800+ii, 800+jj, :) = board(801, 801, :);
                        end
                    end
                    wcastle1 = 1; wcastle2 = 1;
                elseif abs(str2double(move(2))-str2double(move(4)))>1 && abs(file1-file2)>1
                    disp('Invalid entry!');
                    continue;
                end
            elseif start == 12
                if str2double(move(2))==str2double(move(4)) && file1-file2==2 && bcastle1==0 && mat(1,2)==0
                    mat(1,4) = 4; mat(1,1) = 0;
                    board(101:200, 401:500, :) = board(101:200, 101:200, :);
                    for ii = 1:100
                        for jj = 1:100
                            board(100+ii, 100+jj, :) = board(101, 101, :);
                        end
                    end
                    bcastle1 = 1; bcastle2 = 1;
                elseif str2double(move(2))==str2double(move(4)) && file1-file2==-2 && bcastle2==0
                    mat(1,6) = 4; mat(1,8) = 0;
                    board(101:200, 601:700, :) = board(101:200, 801:900, :);
                    for ii = 1:100
                        for jj = 1:100
                            board(100+ii, 800+jj, :) = board(101, 801, :);
                        end
                    end
                    bcastle1 = 1; bcastle2 = 1;
                elseif abs(str2double(move(2))-str2double(move(4)))>1 && abs(file1-file2)>1
                    
                    disp('Invalid entry!');
                    continue;
                end
            end
            if start == 6
                wcastle1 = 1; wcastle2 = 1;
            else
                bcastle1 = 1; bcastle2 = 1;
            end
            
            %Queen Verification
        elseif start == 5 || start == 11
            if str2double(move(2))-file1 == str2double(move(4))-file2 || ...
                    str2double(move(2))+file1 == str2double(move(4))+file2 || ...
                    (str2double(move(2))==str2double(move(4)) || file1==file2)
            else
                disp('Invalid entry!');
                continue;
            end
            
            %White Pawn Verification
        elseif start == 1
            if file1==file2 && dest~=0
                disp('Invalid entry!');
                continue;
            end
            if rank1 == 7 && file1==file2
                if str2double(move(4))-str2double(move(2))==1 || str2double(move(4))-str2double(move(2))==2
                    ep = 2;
                    epf = file2;
                else
                    disp('Invalid entry!');
                    continue;
                end
            elseif file1==file2
                if str2double(move(4))-str2double(move(2))==1
                else
                    disp('Invalid entry!');
                    continue;
                end
            elseif str2double(move(4))-str2double(move(2))==1 && abs(file1-file2)==1 && dest~=0
            elseif str2double(move(4))-str2double(move(2))==1 && abs(file1-file2)==1 && dest==0 && ...
                    mat(rank2+1,file2)==7 && rank1==4 && ep==1 && epf == file2
                mat(rank2+1,file2) = 0;
                for ii = 1:100
                    for jj = 1:100
                        board(400+ii, (file2*100)+jj, :) = board(401, (file2*100)+1, :);
                    end
                end
            else
                disp('Invalid entry!');
                continue;
            end
            if str2double(move(4))==8
                while x~='Q' && x~='R' && x~='B' && x~='N'
                    x = input('Q, R, B, or N? ','s');
                    if x=='Q' || x=='R' || x=='B' || x=='N'
                        
                    else
                        disp('Invalid entry!');
                        continue;
                    end
                end
            end
            
            %Black Pawn Verification
        elseif start == 7
            if file1==file2 && dest~=0
                disp('Invalid entry!');
                continue;
            end
            if rank1 == 2 && file1==file2
                if str2double(move(4))-str2double(move(2))==-1 || str2double(move(4))-str2double(move(2))==-2
                    ep = 2;
                    epf = file2;
                else
                    disp('Invalid entry!');
                    continue;
                end
            elseif file1==file2
                if str2double(move(4))-str2double(move(2))==-1
                else
                    disp('Invalid entry!');
                    continue;
                end
            elseif str2double(move(4))-str2double(move(2))==-1 && abs(file1-file2)==1 && dest~=0
            elseif str2double(move(4))-str2double(move(2))==-1 && abs(file1-file2)==1 && dest==0 && ...
                    mat(rank2-1,file2)==1 && rank1==5 && ep==1 && epf == file2
                mat(rank2-1,file2) = 0;
                for ii = 1:100
                    for jj = 1:100
                        board(500+ii, (file2*100)+jj, :) = board(501, (file2*100)+1, :);
                    end
                end
            else
                disp('Invalid entry!');
                continue;
            end
            if str2double(move(4))==1
                while x~='Q' && x~='R' && x~='B' && x~='N'
                    x = input('Q, R, B, or N? ','s');
                    if x=='Q' || x=='R' || x=='B' || x=='N'
                        
                    else
                        disp('Invalid entry!');
                        continue;
                    end
                end
            end
        end
        break;
    end
    
    %Castle Prevention
    if dest == 4 && file1==1
        wcastle1 = 1;
    elseif dest == 4 && file1==8
        wcastle2 = 1;
    elseif dest == 10 && file1==1
        bcastle1 = 1;
    elseif dest == 10 && file1==8
        bcastle2 = 1;
    end
    
    %Check Verification(Not started - Too much work)
    
    cnt = cnt*(-1);
    ep = ep-1;
    movecnt = movecnt+1;
    
    mat(rank2,file2) = mat(rank1,file1);
    mat(rank1,file1) = 0;
    
    board((rank2)*100+1:(rank2+1)*100, (file2)*100+1:(file2+1)*100, :) = ...
        board((rank1)*100+1:(rank1+1)*100, (file1)*100+1:(file1+1)*100, :);
    
    for ii = 1:100
        for jj = 1:100
            board((rank1)*100+ii, (file1)*100+jj, :) = ...
                board((rank1)*100+1, (file1)*100+1, :);
        end
    end
    
    
    %Pawn Promotion
    if start == 1
        if x == 'Q'
            mat(1,file2) = 5;
        elseif x == 'R'
            mat(1,file2) = 4;
        elseif x == 'B'
            mat(1,file2) = 2;
        elseif x == 'N'
            mat(1,file2) = 3;
        end
        x = 0;
    elseif start == 7
        if x == 'Q'
            mat(8,file2) = 11;
        elseif x == 'R'
            mat(8,file2) = 10;
        elseif x == 'B'
            mat(8,file2) = 8;
        elseif x == 'N'
            mat(8,file2) = 9;
        end
        x = 0;
    end
    
    %Win Condition
    if dest==6 || dest==12
        break;
    end
end

board_view = board;
for ii = 101:1:900
    for jj = 101:1:900
        if abs(board(ii,jj,1) - board(ii,jj,3)) > 10
            if mod(floor((ii-1)/100)+floor((jj-1)/100),2) == 0
                board_view(ii, jj, 1) = 255; %Light Squares
                board_view(ii, jj, 2) = 220;
                board_view(ii, jj, 3) = 130;
                if movecnt>0
                    if ((ii>(rank1*100) && ii<=((rank1+1)*100)) && (jj>(file1*100) && jj<=((file1+1)*100))) || ...
                            ((ii>(rank2*100) && ii<=((rank2+1)*100)) && (jj>(file2*100) && jj<=((file2+1)*100)))
                        board_view(ii, jj, 2) = 160; %Light Orange
                        board_view(ii, jj, 3) = 80;
                    end
                end
            else
                board_view(ii, jj, 1) = 110; %Dark Squares
                board_view(ii, jj, 2) = 85;
                board_view(ii, jj, 3) = 15;
                if movecnt>0
                    if ((ii>(rank1*100) && ii<=((rank1+1)*100)) && (jj>(file1*100) && jj<=((file1+1)*100))) || ...
                            ((ii>(rank2*100) && ii<=((rank2+1)*100)) && (jj>(file2*100) && jj<=((file2+1)*100)))
                        board_view(ii, jj, 1) = 200; %Dark Orange
                        board_view(ii, jj, 2) = 100;
                        board_view(ii, jj, 3) = 10;
                    end
                end
            end
        end
    end
end

if dest==12
    disp('White Wins!');
    text = 'White Wins!';
    position = [201 401];
    board_view = insertText(board_view,position,text,'FontSize',96,'BoxColor',...
        'red','BoxOpacity',0.4,'TextColor','white');
else
    disp('Black Wins!');
    text = 'Black Wins!';
    position = [201 401];
    board_view = insertText(board_view,position,text,'FontSize',99,'BoxColor',...
        'red','BoxOpacity',0.4,'TextColor','white');
end

imshow(board_view);
