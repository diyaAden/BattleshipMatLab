clc
clear
close all

%%SET-UP 

%GUI

warning('off','all');

% Initialize scene
my_scene = simpleGameEngine('Battleship.png',84,84);

% Set up variables to name the various sprites
blank_sprite = 1;
water_sprite = 2;
left_ship_sprite = 3;
horiz_ship_sprite = 4;
right_ship_sprite = 5;
top_ship_sprite = 6;
vert_ship_sprite = 7;
bot_ship_sprite = 8;
hit_sprite = 9;
miss_sprite = 10;

% Display empty board   
board_display = water_sprite * ones(10,21);
board_display(:,11) = blank_sprite;
drawScene(my_scene,board_display)

% % PLACE SHIP 1
%Place the left pointing end of the ship at position (2,3)
board_display(2,3) = left_ship_sprite;
% % Place the middle sections of the ship at positions (2,4-6)
 board_display(2,4) = horiz_ship_sprite;
board_display(2,5) = horiz_ship_sprite;
board_display(2,6) = horiz_ship_sprite;
% % Place the right pointing end of the ship at position (2,3)
board_display(2,7) = right_ship_sprite;

% Place the left pointing end of the ship at position (2,3)
board_display(2,3) = left_ship_sprite;
% Place the middle sections of the ship at positions (2,4-6)
board_display(2,4) = horiz_ship_sprite;
board_display(2,5) = horiz_ship_sprite;
board_display(2,6) = horiz_ship_sprite;
% Place the right pointing end of the ship at position (2,7)
board_display(2,7) = right_ship_sprite;
 
% Place the top pointing end of the ship at position (4,2)
board_display(4,2) = top_ship_sprite;
% Place the middle sections of the ship at positions (5,2)
board_display(5,2) = vert_ship_sprite;
% Place the bottom pointing end of the ship at position (6,2)
board_display(6,2) = bot_ship_sprite;
 
% Place the top pointing end of the ship at position (6,9)
board_display(6,9) = top_ship_sprite;
% Place the middle sections of the ship at positions (7-8, 9)
board_display(7,9) = vert_ship_sprite;
board_display(8,9) = vert_ship_sprite;
% Place the bottom pointing end of the ship at position (9,9)
board_display(9,9) = bot_ship_sprite;
 
% Place the left pointing end of the ship at position (8,4)
board_display(8,4) = left_ship_sprite;
% Place the middle section of the ship at postion (8,5)
board_display(8,5) = horiz_ship_sprite;
% Place the middle section of the ship at postion (8,6)
board_display(8,6) = right_ship_sprite;
 
%%%%END


drawScene(my_scene,board_display)

% Set up hits and misses layer
hitmiss_display = blank_sprite * ones(10,21);

% Display miss for players shot at (5,5), note the +11 to shift the
% coordinates onto the right hand board


drawScene(my_scene,board_display,hitmiss_display)



%Initialize Player Board Hit/Miss Matrix (10x10)

for xVal = 1:10
%Initializes yValue counter
    for yVal  = 1:10
        playerHM(xVal, yVal) = 0;
end
end



%Initialize AI Board Hit/Miss Matrix (10x10)

for xVal = 1:10
%Initializes yValue counter
    for yVal  = 1:10
        aiHM(xVal, yVal) = 0;
end
end


%HARDCODE FOR SHIP POS
pShipTotal = 4;
pShip1 = 3;
pShip2 = 5;
pShip3 = 4;
pShip4 = 3;

%PLAYER
%Ship 1
aiHM(4,2) = 2;
aiHM(4,3) = 2;
aiHM(4,4) = 2;

%Ship 2
aiHM(2,3) = 3;
aiHM(2,4) = 3;
aiHM(2,5) = 3;
aiHM(2,6) = 3;
aiHM(2,7) = 3;

%Ship 3
aiHM(6,9) = 4;
aiHM(7,9) = 4;
aiHM(8,9) = 4;
aiHM(9,9) = 4;

%Ship 4
aiHM(8,4) = 5;
aiHM(8,5) = 5;
aiHM(8,6) = 5;

%AI SHIPS

aiShip1 = 3;
aiShip2 = 5;
aiShip3 = 4;
aiShip4 = 3;

%Ship 1
playerHM(3,7) = 2;
playerHM(3,8) = 2;
playerHM(3,9) = 2;
 
%Ship 2
playerHM(10,2) = 3;
playerHM(10,3) = 3;
playerHM(10,4) = 3;
playerHM(10,5) = 3;
playerHM(10,6) = 3;
 
%Ship 3
playerHM(4,2) = 4;
playerHM(5,2) = 4;
playerHM(6,2) = 4;
playerHM(7,2) = 4;
 
%Ship 4
playerHM(10,8) = 5;
playerHM(10,9) = 5;
playerHM(10,10) = 5;


%Variables for total # of ships
pShipTotal = 4;
aiShipTotal = 4;


%%Switch b/w player and AI turns until someone wins

while pShipTotal ~=0 && aiShipTotal ~= 0
    
%PLAYERTURN

%Player clicks button and coordinates are recorded
[r,c] = getMouseInput(my_scene)
xPos = r;
yPos = c;

%Keep prompting until valid spot is chosen (open and within bounds)

while ( playerHM(xPos,yPos-11) == 1 || xPos > 10 || yPos < 10 )
   fprintf('Error: Select another coordinate')
    [r,c] = getMouseInput(my_scene);
    xPos = r;
    yPos = c;
end

%Evaluate chosen spot
current = playerHM(r,c-11)

%If a hit, check which ship 
if current > 0
    
    playerHM(r,c-11) == 1;
    %Update graphic
    hitmiss_display(r,c) = hit_sprite;  
else
    playerHM(r,c-11) == 1;
    %Update graphic
    hitmiss_display(r,c) = miss_sprite;
end

drawScene(my_scene,board_display,hitmiss_display)

if current == 2
    aiShip1 = aiShip1 - 1;
    if aiShip1 == 0
        aiShipTotal = aiShipTotal-1;
    end
elseif current == 3
    aiShip2 = aiShip2 - 1;
    if aiShip2 == 0
        aiShipTotal = aiShipTotal-1;
    end
elseif current == 4
    aiShip3 = aiShip3 - 1;
    if aiShip3 == 0
        aiShipTotal = aiShipTotal-1;
    end
else
    aiShip4 = aiShip4 - 1;
    if aiShip4 == 0
        aiShipTotal = aiShipTotal-1;
    end
end
    
%%AI TURN

%Variables




% AI initially selects a spot on the board at random

hitIndex = 0

%Keep prompting until chosen spot has not been chosen ('O')

%If no hits in index, prompt until unmarked spot is chosen
if hitIndex == 0
    xPos = randi([1,10],1)
    yPos = randi([1,10],1)
    
    while ( playerHM(xPos,yPos) == 1  )
        xPos = randi([1,10],1)
        yPos = randi([1,10],1)
    end
    
%AI's got a hit 
else
    %Ai picks one of open adjacent spots
    tempX = xPos;
    tempY = yPos;
    
    if aiHM(tempX + 1, tempY) == 1
        if aiHM(tempX, tempY + 1) == 1
            if aiHM(tempX-1,tempY) == 1
                if aiHM(tempX,tempY-1) == 1
                else
                    xPos = xPos;
                    yPos = yPos - 1;
                end
                end
            else
                xPos = xPos-1;
                yPos = yPos;
            end
        else
           xPos = xPos;
           yPos = yPos + 1;
        end
    
        xPos = xPos + 1
        yPos = yPos;    
  end



 
%Value at chosen spot
current = aiHM(xPos,yPos)

%Update board 
if current > 0
    
    aiHM(xPos,yPos) == 1;
    %Update graphic
    hitIndex = hitIndex + 1
    hitmiss_display(xPos,yPos) = hit_sprite;  
else
    aiHM(xPos,yPos) == 1;
    %Update graphic
    hitmiss_display(xPos,yPos) = miss_sprite;
end

drawScene(my_scene,board_display,hitmiss_display)

%Update shipCount
if current == 2
    pShip1 = pShip1 - 1;
    if pShip1 == 0
        pShipTotal = pShipTotal-1;
    end
elseif current == 3
    pShip2 = pShip2 - 1;
    if pShip2 == 0
        pShipTotal = pShipTotal-1;
    end
elseif current == 4
    pShip3 = pShip3 - 1;
    if pShip3 == 0
        pShipTotal = pShipTotal-1;
    end
else
    pShip4 = pShip4 - 1;
    if pShip4 == 0
        pShipTotal = pShipTotal-1;
    end
end

end

    
%end

if pShipTotal == 0
    close all
    fprintf('You lose. AI wins')
    %code to return to menu 
else
    close all
    fprintf('You win!')
    %prompt to return to menu
    
end


