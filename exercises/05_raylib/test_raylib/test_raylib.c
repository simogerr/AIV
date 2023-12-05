#include "raylib.h"
#include <stdio.h>

#define PLAYER_COLOR CLITERAL(Color){ 150, 100, 80, 255 }
#define BULLET_COLOR CLITERAL(Color){ 150, 200, 200, 255 }

typedef struct Actor
{
    Vector2 position;
    Vector2 size;
    float speed;

    Vector2 cannon_position;
    Vector2 cannon_size;
    bool canShoot;

}Actor;

// typedef struct Bullet
// {
//     Vector2 size;
//     float speed;
// }Bullet;

void Update_playerMove_Input(Actor *player, float deltaTime);

int main()
{
    const int screenWidth = 1024;
    const int screenHeight = 756;

    InitWindow(screenWidth, screenHeight, "raylib Exercise");
    SetTargetFPS(60);

    Actor player = {{screenWidth/2,screenHeight/2},{40,40},200,{screenWidth/2 + 15,(screenHeight/2)-10},{10,10},player.canShoot = false};
    // Bullet bullet = {{10,10},500};

    while (!WindowShouldClose())
    {
        /*TIME*/
        float deltaTime = GetFrameTime();

        /*UPDATE*/
        Update_playerMove_Input(&player,deltaTime);

        if (IsKeyDown(KEY_SPACE))
        {
            //Shoot(&player,&bullet_heavy,deltaTime);
        }
        
       /*DRAW*/
        BeginDrawing();
        ClearBackground(SKYBLUE);

        /*Draw items*/
        Rectangle player_rect = {player.position.x, player.position.y, 40,40};
        Rectangle cannon_rect = {player.cannon_position.x, player.cannon_position.y,10,10};
        DrawRectangleRec(player_rect, PLAYER_COLOR);
        DrawRectangleRec(cannon_rect,PLAYER_COLOR);

        DrawText("Move player with arrow keys",screenWidth, screenHeight-100, 30, DARKBLUE);
        EndDrawing();

    }
    CloseWindow();
    return 0;
}

void Update_playerMove_Input(Actor *player, float deltaTime)
{
    if(IsKeyDown(KEY_LEFT))
    {
        player->position.x -= player->speed * deltaTime;
        player->cannon_position.x -= player->speed * deltaTime;
    }

    if(IsKeyDown(KEY_RIGHT))
    {
        player->position.x += player->speed * deltaTime;
        player->cannon_position.x += player->speed * deltaTime;
    }

    if(IsKeyDown(KEY_DOWN))
    {
        player->position.y += player->speed * deltaTime;
        player->cannon_position.y += player->speed * deltaTime;
    }

    if(IsKeyDown(KEY_UP))
    {
        player->position.y -= player->speed * deltaTime;
        player->cannon_position.y -= player->speed * deltaTime;
    }

    if (IsKeyDown(KEY_SPACE))
    {
        player->canShoot = true;
    }
}
