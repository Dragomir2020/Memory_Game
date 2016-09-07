clear;clc;
load CardDeck;

%Create Board of red cards face down
for r = 1:4
    for c = 1:13
        MemoryBoard{r,c} = BlueDeck{55};
    end
end

%Randomize Card values for index purposes
ShuffledDeck = randperm(52);
ShuffledDeck = reshape(ShuffledDeck,[4,13]);
title('Memory');

%Get user input for player names
Player_Name{1} = input('Player One Name: ','s');
Player_Name{2} = input('Player Two Name: ','s');

%Show board
title('Memory');
imshow([MemoryBoard{1,:};MemoryBoard{2,:};MemoryBoard{3,:};MemoryBoard{4,:}])

%Initialize Point array and Matches array
Points = zeros(2,1);
Matches = zeros(52,1);

%end game when Points1 + Points 2 = 26
while Points(1) + Points(2) ~= 26
    for Player = 1:2
    fprintf('%s Go!!!\n',Player_Name{Player});
    %Pick first card and verify
    [x,y] = ginput(1);
    row1 = floor(y/96) + 1;
    col1 = floor(x/72) + 1;
    while sum(Matches(:,1) == ShuffledDeck(row1,col1)) == 1
        [x,y] = ginput(1);
        row1 = floor(y/96) + 1;
        col1 = floor(x/72) + 1;
    end
    %Once verified Flip over card
    MemoryBoard{row1,col1} = BlueDeck{ShuffledDeck(row1,col1)};
    title('Memory');
    imshow([MemoryBoard{1,:};MemoryBoard{2,:};MemoryBoard{3,:};MemoryBoard{4,:}]);
    %Pick second card and verify
    [x,y] = ginput(1);
    row2 = floor(y/96) + 1;
    col2 = floor(x/72) + 1;
    while sum(Matches(:,1) == ShuffledDeck(row2,col2)) == 1
        [x,y] = ginput(1);
        row2 = floor(y/96) + 1;
        col2 = floor(x/72) + 1;
    end
    %Once Werified flip over card
    MemoryBoard{row2,col2} = BlueDeck{ShuffledDeck(row2,col2)};
    title('Memory');
    imshow([MemoryBoard{1,:};MemoryBoard{2,:};MemoryBoard{3,:};MemoryBoard{4,:}])
    %Check if the two cards match
    if floor((ShuffledDeck(row1,col1)-1)/4) == floor((ShuffledDeck(row2,col2)-1)/4)
        Points(Player) = Points(Player) + 1;
        Matches((Points(1)+Points(2))*2-1)=(ShuffledDeck(row1,col1));
        Matches((Points(1)+Points(2))*2)=(ShuffledDeck(row2,col2));
        fprintf('%s receives a point!\n',Player_Name{Player})
        MemoryBoard{row1,col1} = Blank;
        MemoryBoard{row2,col2} = Blank;
    else
        MemoryBoard{row1,col1} = BlueDeck{55};
        MemoryBoard{row2,col2} = BlueDeck{55};
    end
    end
end

%Display Who Wins
if Points(1) > Points(2)
    fprintf('%s wins\n',PlayerOne);
elseif Points(2) > Points(1)
    fprintf('%s wins\n',PlayerTwo);
else
    display('Its a tie');
end
