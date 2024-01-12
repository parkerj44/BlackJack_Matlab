clc
clear
close all

%Display Game title
fprintf('Blackjack!\n')
fprintf('Are You Feeling Lucky?\n')
fprintf('-------------------------------------------------------\n')
%Rules
fprintf('Rules of Blackjack:\n')
fprintf('Ace is worth 11. All other face cards are worth 10.\n')
fprintf('Bets are taken twice. Before and After cards are recieved.\n')
fprintf('Have to get more than the dealer, A tie is a loss.\n')
fprintf('21 is the max amount.\n')
fprintf('--------------------------------------------------------\n')

%start play
play = 'y';

%Player Name
player1 = input('Enter Player One''s name: ', 's');


%Amount of chips players get in the beginning
players_chips = 500;

tie = 0;
win = 0;
loss = 0;

fprintf('Hello, %s you have %i chips available. Spend them wisely.\n', player1, players_chips)


%Make bet
%Ask how to 
while play == 'y' && players_chips > 0
    player_bet = input('How much would you like to bet? ');

while player_bet > players_chips && players_chips > 0 || player_bet <= 0 && players_chips > 0
    if player_bet > players_chips
    fprintf('You have %i chips that are available to bet.\n', players_chips)
    player_bet = input('How much would you like to bet? ');
    elseif player_bet <= 0
    fprintf('You cannot play if your bet is 0 or less.\n')
    player_bet = input('How much would you like to bet? ');
    end
end

players_chips = players_chips - player_bet; %Chips left to bet after

%Setting up the deck
scene = simpleGameEngine('retro_cards.png', 16, 16, 8, [25, 132, 23]);

playing_cards = 21:72;
background_sprite = 1;
background_sprite2 = ones(1 , 2); 

DeckValues = [11 2:10 10 10 10 11 2:10 10 10 10 11 2:10 10 10 10 11 2:10 10 10 10];

shuffle_deck = randperm(52);


%Dealer gets first and fourth card

dealerFirst = shuffle_deck(1);

card_numberDealers = playing_cards(dealerFirst);

drawScene(scene, background_sprite, card_numberDealers)

score_Dealer = sum(DeckValues(dealerFirst));

fprintf('The dealer has a total score of %i from the first card.\n', score_Dealer)

pause(7)

close all

%Players hand
fprintf('----------------------------------------------------\n')
playersHand = shuffle_deck(2 : 3);

card_numberPlayer = playing_cards(playersHand);

drawScene(scene, background_sprite2, card_numberPlayer)

score_Player = sum(DeckValues(playersHand));

fprintf('Your total score is %i.\n', score_Player)

pause(5)


    if score_Player == 21
        break
    end

close all

fprintf('-----------------------------------------------------------\n')

%Chance to bet more
new_bet = input('Would you like to make another bet? Press 1 if yes, 2 if no: ');

if new_bet == 1
    final_bet = input('How much would you like to bet?');
    while final_bet > players_chips && players_chips > 0 || final_bet <= 0 && players_chips >= 0
        if final_bet > players_chips
        fprintf('You have %i chips that are available to bet.\n', players_chips)
        final_bet = input('How much would you like to bet? ');
        elseif player_bet <= 0
        fprintf('You cannot play if your bet is 0 or less.\n')
        final_bet = input('How much would you like to bet? ');
        end
    end
elseif new_bet == 2
    final_bet = 0;
end



players_chips = players_chips - final_bet;
%Dealers second card is revealed
fprintf('-----------------------------------------------------\n')
dealersHand = shuffle_deck([1 4]);

card_numberDealer = playing_cards(dealersHand);

drawScene(scene, background_sprite2, card_numberDealer)

score_Dealer = sum(DeckValues(dealersHand));

fprintf('The dealer now has a total score of %i.\n', score_Dealer)

pause(7)

close all

 

%Would you like to hit or stay?
%While loop to play the game
fprintf('--------------------------------------------\n')
%Have to have counters for player, dealer, and cards
x_c = 5; %card numebr
x_p = 2; %counter for player
x_d = 2; %counter for dealer
A = DeckValues(playersHand);
B = DeckValues(dealersHand);



while score_Player < 21 && score_Dealer < 21
    fprintf('%s it is your turn!\n', player1)
    fprintf('----------------------------------------------\n')
    player_option = input('To hit press 1, to stay press 2: ');
    if player_option == 1
        
        x_p = x_p + 1;

        playersHand(x_p) = shuffle_deck(x_c);

        card_numberPlayer = playing_cards(playersHand);

        background_cards = ones(1, x_p);

        drawScene(scene, background_cards, card_numberPlayer)

        score_Player = sum(DeckValues(playersHand));

        fprintf('Your new card gives you a total of %i!\n', score_Player)

        pause(5)

        close all

            if score_Player == 21
                break
            end

            if score_Player > 21 && any(A(:) == 11) %If score is greater than 21 and has an ace
                Deck_Values = [1:10 10 10 10 1:10 10 10 10 1:10 10 10 10 1:10 10 10 10];

                score_Player = sum(Deck_Values(playersHand));

                fprintf('Your Ace has changed values, you were given another chance! Your score is %i\n', score_Player)

                pause(5)

            elseif score_Player > 21 && any(A(:) ~= 11) %If score is greater than 21 and no ace
                
                break
            end
    

           


        x_c = x_c + 1;

        %dealer must hit if they have a total of 16 or less, or if they
        %have less than the player


        if score_Dealer <= 16 || score_Dealer < score_Player
           
            x_d = x_d + 1;

            dealersHand(x_d) = shuffle_deck(x_c);

            card_numberDealer = playing_cards(dealersHand);

            background_cardDealer = ones(1 , x_d);

            drawScene(scene, background_cardDealer, card_numberDealer)

            score_Dealer = sum(DeckValues(dealersHand));

            fprintf('----------------------------------------------\n')
            fprintf('The dealer decided to hit. The dealer''s score is %i.\n', score_Dealer)

            pause(5)

            close all

            if score_Dealer == 21 
                break 
            end

            if score_Dealer > 21 && any(B(:) == 11)%Greater than 21 and have an ace
                Deck_Values = [1:10 10 10 10 1:10 10 10 10 1:10 10 10 10 1:10 10 10 10];

                score_Dealer = sum(Deck_Values(dealersHand));

                fprintf('The Dealer has chosen to use the Ace as a 1. The new score is %i.\n', score_Dealer)

                pause(5)

            elseif score_Dealer > 21 && any(B(:) ~= 11) %Greater than 21 and have no ace
                break
            end
        else
            fprintf('The Dealer will stay. \n')

            card_numberDealer = playing_cards(dealersHand);

            drawScene(scene, background_sprite2, card_numberDealer)

            score_Dealer = sum(DeckValues(dealersHand));

            fprintf('The Dealer''s final score is %i.\n', score_Dealer)

            pause(5)

            close all
        end


        x_c = x_c + 1;

        %player chooses to stay, gives same cards
       elseif player_option == 2

        fprintf('You have decided to stay.\n')
        

        card_numberPlayer = playing_cards(playersHand);

        background_cards = ones(1 , x_d);

        drawScene(scene, background_cards, card_numberPlayer)

        fprintf('This is your final score: %i.\n', score_Player)

        pause(5) 

        close all
        
        
            %Draws another card for dealer if score is less than player
            if score_Dealer < score_Player

                 x_d = x_d + 1;

            dealersHand(x_d) = shuffle_deck(x_c);

            card_numberDealer = playing_cards(dealersHand);

            background_cardDealer = ones(1 , x_d);

            drawScene(scene, background_cardDealer, card_numberDealer)

            score_Dealer = sum(DeckValues(dealersHand));

            fprintf('----------------------------------------------\n')
            fprintf('The dealer decided to hit. The dealer''s final score is %i.\n', score_Dealer)

            pause(5)

            close all

                if score_Dealer == 21
                    break 

                elseif score_Dealer > 21 && any(B(:) == 11)
                Deck_Values = [1:10 10 10 10 1:10 10 10 10 1:10 10 10 10 1:10 10 10 10];

                score_Dealer = sum(Deck_Values(dealersHand));

                fprintf('The Dealer has chosen to use the Ace as a 1. The new score is %i.\n', score_Dealer)

                pause(5)

            elseif score_Player > 21 && any(B(:) ~= 11)
                    break
                
                elseif score_Dealer < score_Player
                    %Dealer has to hit again if they have less than player

                    x_d = x_d + 1;

                    x_c = x_c + 1;

                    dealersHand(x_d) = shuffle_deck(x_c);

                    card_numberDealer = playing_cards(dealersHand);

                    background_cardDealer = ones(1 , x_d);

                    drawScene(scene, background_cardDealer, card_numberDealer)

                    score_Dealer = sum(DeckValues(dealersHand));

                    fprintf('----------------------------------------------\n')
                    fprintf('The dealer decided to hit again. The dealer''s score is %i.\n', score_Dealer)

                    pause(5)

                    close all

                end
            else

               %Dealer decides to stay because they have more points

               card_numberDealer = playing_cards(dealersHand);

               drawScene(scene, background_sprite2, card_numberDealer)

               fprintf('The dealer decided to stay, this the the final hand. The Dealer has a total score of %i .\n', score_Dealer)

               pause(5)

               close all
            end 
      
    end
end



%Take into account the score and see who wins and who loses $$$$$$$$

fprintf('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n')
Decision = check(score_Dealer, score_Player);

    if Decision == 1
        players_chips = (2 * (player_bet + final_bet)) + players_chips;
        fprintf('YOU HAVE WON! YOUR BET HAS BEEN DOUBLED! Your balance is %i. \n', players_chips)
        win = win + 1;
    elseif Decision == 2
        fprintf('You have lost:( Your balance is %i.\n', players_chips)
        loss = loss + 1;
    elseif Decision == 3
        fprintf('It is a tie. No money was won or lost. \n ')
        players_chips = players_chips + player_bet + final_bet;
        tie = tie + 1;
    elseif Decision == 4
        players_chips = (4 * (player_bet + final_bet)) + players_chips;
        fprintf('YOU HAVE WON! YOUR BET HAS BEEN QUADRUPLED! CONGRAGULATIONS! Your balance is %i.\n', players_chips)
        win = win + 1;
    end
       



if players_chips > 0
    play = input('Would you like to play again? Press y for yes and n for no: ', 's');
    if play == 'n'
        fprintf('Hope to see you soon! You have %i win(s), %i loss(es), and %i tie(s).\n', win, loss, tie)
        fprintf('Congratulations you walk away with $%i.\n', players_chips)
    end
elseif players_chips == 0
    fprintf('Restart game to play again.')
    fprintf('You ended with %i win(s), %i loss(es), and %i tie(s). Better Luck Next Time!\n', win, loss, tie)
end
end