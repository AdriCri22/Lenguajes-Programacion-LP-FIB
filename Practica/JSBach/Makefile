all: default
	
default:
	antlr4 -Dlanguage=Python3 -no-listener -visitor jsbach.g4

dependencies:
	pip3 install colorama

clean:
	rm -f jsbachLexer.py
	rm -f jsbachParser.py
	rm -f jsbachVisitor.py
	rm -rf __pycache__
	rm -f *.interp
	rm -f *.tokens

distclean: clean
	rm -f *.lily
	rm -f *.midi
	rm -f *.mp3
	rm -f *.pdf
	rm -f *.wav