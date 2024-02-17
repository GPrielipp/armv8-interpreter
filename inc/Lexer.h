#ifndef LEXER_H
#define LEXER_H

#include <iostream>
#include <string>
#include <vector>

#include "./Token.h"

class Lexer
{
private:
  std::ifstream ifs;
  class Iterator
  {
  private:
    std::ifstream ifs;
  public:
    Iterator(std::ifstream ifs);
    bool hasNext();
    std::string next();
  }

public:
  Lexer(std::ifstream ifs); // construct the Lexer
  std::vector<Token>* lex(); // parse my file
}

#endif//LEXER_H
