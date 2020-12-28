function shootingGame()
    %use q to quit
    %use w,a,s and d to move
    x_max=10;
    y_max=10;
    player=[5 1];
    num_bullets=0;
    bullets=[];
    num_enemies=0;
    enemies=[];
    enemyBullets=[];
    num_enemyBullets=0;
    quit=0;
    score=0;
    live=5;
    r=1;
    figure('KeyPressFcn',@keyboard_callback,'WindowButtonDownFcn',@mouse_callback);
    while (quit~=1&&live>0)
        while(num_enemies<5)
            enemies=[enemies;rand()*10 rand()*5+5 rand()*0.1+0.1];
            num_enemies=num_enemies+1;
        end
        while(num_enemyBullets<5)
            v=player-enemies(r,1:2);
            enemyBullets=[enemyBullets;enemies(r,1:2) v/norm(v)*0.075];
            num_enemyBullets=num_enemyBullets+1;
            r=r+1;
            if r==6
                r=1;
            end
        end
        draw();
        pause(0.01);
    end
    close all
    if live==0
        msgbox("Game Over! Score:"+score);
    else
        msgbox("Score:"+score);
    end
    function draw()
        %bullets
        for ii=1:num_bullets
            plot(bullets(ii,1),bullets(ii,2),'Bo','MarkerSize',10);
            hold on
        end
        bulletsMove();
        %player
        plot(player(1),player(2),'B^','MarkerSize',10);
        hold on
        %enemies
        for ii=1:num_enemies
            plot(enemies(ii,1),enemies(ii,2),'Mdiamond','MarkerSize',10);
            hold on
        end
        enemiesMove();
        %enemyBullets
        for ii=1:num_enemyBullets
            plot(enemyBullets(ii,1),enemyBullets(ii,2),'Ro','MarkerSize',10);
            hold on
        end
        enemyBulletsMove();
        axis([0,x_max,0,y_max]);
        set(gca,'Color','w');
        set(gca,'xtick',[]); 
        set(gca,'xticklabel',{});
        set(gca,'ytick',[]); 
        set(gca,'yticklabel',{});
        text(9,9.5,"score:"+score);
        text(9,9,"live:"+live);
        drawnow
        hold off
    end
    function bulletsMove()
        n=num_bullets;
        ii=0;
        while ii<n
            ii=ii+1;
            bullets(ii,1)=bullets(ii,1)+bullets(ii,3);
            bullets(ii,2)=bullets(ii,2)+bullets(ii,4);
            if(bullets(ii,1)<0||bullets(ii,1)>x_max||bullets(ii,2)<0||bullets(ii,2)>y_max)
                bullets=[bullets(1:ii-1,:);bullets(ii+1:num_bullets,:)];
                num_bullets=num_bullets-1;
                n=n-1;
                ii=ii-1;
            end
        end
    end
    function enemiesMove()
        n=num_enemies;
        ii=0;
        while ii<n
            ii=ii+1;
            enemies(ii,1)=enemies(ii,1)+enemies(ii,3);
            if(enemies(ii,1)<=0||enemies(ii,1)>=x_max)
                enemies(ii,3)=enemies(ii,3)*(-1);
            end
            m=num_bullets;
            jj=0;
            if (enemies(ii,1)-player(1))^2+(enemies(ii,2)-player(2))^2<0.1
                enemies=[enemies(1:ii-1,:);enemies(ii+1:num_enemies,:)];
                num_enemies=num_enemies-1;
                n=n-1;
                ii=ii-1;
                live=live-1;
                player=[5 1];
                continue;
            end
            while jj<m&&ii>0
                jj=jj+1;
                if (enemies(ii,1)-bullets(jj,1))^2+(enemies(ii,2)-bullets(jj,2))^2<0.3
                    enemies=[enemies(1:ii-1,:);enemies(ii+1:num_enemies,:)];
                    num_enemies=num_enemies-1;
                    n=n-1;
                    ii=ii-1;
                    bullets=[bullets(1:jj-1,:);bullets(jj+1:num_bullets,:)];
                    num_bullets=num_bullets-1;
                    m=m-1;
                    jj=jj-1;
                    score=score+1;
                end
            end
        end
    end
    function enemyBulletsMove()
        n=num_enemyBullets;
        ii=0;
        while ii<n
            ii=ii+1;
            enemyBullets(ii,1)=enemyBullets(ii,1)+enemyBullets(ii,3);
            enemyBullets(ii,2)=enemyBullets(ii,2)+enemyBullets(ii,4);
            if(enemyBullets(ii,1)<0||enemyBullets(ii,1)>x_max||enemyBullets(ii,2)<0||enemyBullets(ii,2)>y_max)
                enemyBullets=[enemyBullets(1:ii-1,:);enemyBullets(ii+1:num_enemyBullets,:)];
                num_enemyBullets=num_enemyBullets-1;
                n=n-1;
                ii=ii-1;
                continue;
            end
            if (enemyBullets(ii,1)-player(1))^2+(enemyBullets(ii,2)-player(2))^2<0.1
                enemyBullets=[enemyBullets(1:ii-1,:);enemyBullets(ii+1:num_enemyBullets,:)];
                num_enemyBullets=num_enemyBullets-1;
                n=n-1;
                ii=ii-1;
                live=live-1;
                player=[5 1];
            end
        end
    end
    function keyboard_callback(~,event)
        switch event.Character
            case 'q'
                quit=1;
            case 30 %up
                if(player(2)<y_max)
                    player(2)=player(2)+0.25;
                else
                    player(2)=y_max;
                end
            case 31 %down
                if(player(2)>0)
                    player(2)=player(2)-0.25;
                else
                    player(2)=0;
                end
            case 29 %right
                if(player(1)<x_max)
                    player(1)=player(1)+0.25;
                else
                    player(1)=x_max;
                end
            case 28 %left
                if(player(1)>0)
                    player(1)=player(1)-0.25;
                else
                    player(1)=0;
                end
            case 'w' %up
                if(player(2)<y_max)
                    player(2)=player(2)+0.25;
                else
                    player(2)=y_max;
                end
            case 's' %down
                if(player(2)>0)
                    player(2)=player(2)-0.25;
                else
                    player(2)=0;
                end
            case 'd' %right
                if(player(1)<x_max)
                    player(1)=player(1)+0.25;
                else
                    player(1)=x_max;
                end
            case 'a' %left
                if(player(1)>0)
                    player(1)=player(1)-0.25;
                else
                    player(1)=0;
                end
         end
    end
    function mouse_callback(~,~)
        c=get(gca,'CurrentPoint');
        v=c(1,1:2)-player;
        bullets=[bullets;[player v/norm(v)*0.75]];
        num_bullets=num_bullets+1;
    end
    
end
