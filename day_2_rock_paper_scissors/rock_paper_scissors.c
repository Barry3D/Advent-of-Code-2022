#include <stdio.h>
#include <stdlib.h>
#include <string.h>

short shapeScore(char shape) {
    switch(shape) {
        case 'A':
            return 1;
        case 'B':
            return 2;
        case 'C':
            return 3;
    }
    return 0;
}

char neededDraw(char opponent, char condition) {
    if (condition == 'Y') {
        return opponent;
    }

    short mod = condition == 'Z' ? 1 : -1;
    char *draws = "ABC";
    char *found = strchr(draws, opponent);
    // Subtract the strings memory address from the found chars memory address
    int index = (found - draws + 3 + mod) % 3;

    return draws[index];
}

short calculateScore(char opponent, char condition) {
    char translated = neededDraw(opponent, condition);
    short score = shapeScore(translated);
    if (opponent == translated) {
        return 3 + score;
    }

    char winsagainst[] = {'C', 'A', 'B'};

    if (winsagainst[score-1] == opponent) {
        return 6 + score;
    }
    
    return score;
}

int calculateTotalScore() {
    FILE *stream = fopen("./input_file", "r");
    char *line = NULL;
    size_t len = 0;
    ssize_t nread;

    int totalScore = 0;
    while ((nread = getline(&line, &len, stream)) != -1) {
        totalScore += calculateScore(line[0], line[2]);
    }

    fclose(stream);
    free(line);

    return totalScore;
}

int main() {
    printf("%d", calculateTotalScore());
    

    return 0;
}
