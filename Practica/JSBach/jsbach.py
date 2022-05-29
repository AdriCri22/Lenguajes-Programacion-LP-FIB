from antlr4 import *
from jsbachLexer import jsbachLexer
from jsbachParser import jsbachParser
from TreeVisitor import TreeVisitor
import sys
import os


def main():
    fileName = sys.argv[1]
    if fileName[-3:] != "jsb":
        raise Exception("The file has to be an .jsb")

    if (os.path.exists(fileName[:-4] + '.lily')):
        os.remove(fileName[:-4] + '.lily')
    if (os.path.exists(fileName[:-4] + '.midi')):
        os.remove(fileName[:-4] + '.midi')
    if (os.path.exists(fileName[:-4] + '.wav')):
        os.remove(fileName[:-4] + '.wav')
    if (os.path.exists(fileName[:-4] + '.mp3')):
        os.remove(fileName[:-4] + '.mp3')
    if (os.path.exists(fileName[:-4] + '.pdf')):
        os.remove(fileName[:-4] + '.pdf')

    input_stream = FileStream(fileName, encoding='utf-8')
    lexer = jsbachLexer(input_stream)
    token_stream = CommonTokenStream(lexer)
    parser = jsbachParser(token_stream)
    tree = parser.root()
    visitor = TreeVisitor(fileName[:-4])
    visitor.visit(tree)

    if len(sys.argv) == 2:
        visitor.start('Main')
    elif len(sys.argv) == 3:
        visitor.start(sys.argv[2])
    else:
        visitor.startWithArguments(sys.argv[2], sys.argv[3:])

    if (os.path.exists(fileName[:-4] + '.lily')):
        os.system("lilypond " + fileName[:-4] + ".lily > /dev/null 2>&1")
        os.system("timidity -Ow -o " + fileName[:-4] + ".wav " +
                  fileName[:-4] + ".midi > /dev/null 2>&1")
        os.system("ffmpeg -i " + fileName[:-4] +
                  ".wav -codec:a libmp3lame -qscale:a 2 " + fileName[:-4] +
                  ".mp3 -y > /dev/null 2>&1")
        os.system("afplay " + fileName[:-4] + ".mp3")

if __name__ == '__main__':
    main()
