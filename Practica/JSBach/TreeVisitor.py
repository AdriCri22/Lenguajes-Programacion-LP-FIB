import os

if __name__ is not None and "." in __name__:
    from .jsbachParser import jsbachParser
    from .jsbachVisitor import jsbachVisitor
else:
    from jsbachParser import jsbachParser
    from jsbachVisitor import jsbachVisitor


def addition(num1, num2):
    return num1 + num2


def substraction(num1, num2):
    return num1 - num2


def multiplication(num1, num2):
    if num2 == 0:
        raise Exception("The divisor can not be equal to 0")

    return num1 * num2


def division(num1, num2):
    return num1 / num2


def module(num1, num2):
    return num1 % num2


def equal(op1, op2):
    return op1 == op2


def notEqual(op1, op2):
    return op1 != op2


def greater(op1, op2):
    return op1 < op2


def lower(op1, op2):
    return op1 > op2


def greaterEqual(op1, op2):
    return op1 <= op2


def lowerEqual(op1, op2):
    return op1 >= op2


def score(scores):
    res = ""
    for s in scores:
        res += "\n" + str(s)
    return res


TEMPO = "180"


def writeScore(scores, name):
    with open(name + '.lily', 'w') as f:
            f.write("""
            \\version "2.22.1"
            \\score {
            \\absolute {
            \\tempo 4 = """ + TEMPO + """
            """ + score(scores) + """
            }
            \\layout { }
            \\midi { }
            }
            """)

operators = {'+': addition,
             '-': substraction,
             '*': multiplication,
             '/': division,
             '%': module}

notes = {'A0': "a'0", 'B0': "b'0",
         'A1': "a'1", 'B1': "b'1", 'C1': "c'1", 'D1': "d'1",
         'E1': "e'1", 'F1': "f'1", 'G1': "g'1",
         'A2': "a'2", 'B2': "b'2", 'C2': "c'2", 'D2': "d'2",
         'E2': "e'2", 'F2': "f'2", 'G2': "g'2",
         'A3': "a'3", 'B3': "b'3", 'C3': "c'3", 'D3': "d'3",
         'E3': "e'3", 'F3': "f'3", 'G3': "g'3",
         'A4': "a'4", 'B4': "b'4", 'C4': "c'4", 'D4': "d'4",
         'E4': "e'4", 'F4': "f'4", 'G4': "g'4",
         'A5': "a'5", 'B5': "b'5", 'C5': "c'5", 'D5': "d'5",
         'E5': "e'5", 'F5': "f'5", 'G5': "g'5",
         'A6': "a'6", 'B6': "b'6", 'C6': "c'6", 'D6': "d'6",
         'E6': "e'6", 'F6': "f'6", 'G6': "g'6",
         'A7': "a'7", 'B7': "b'7", 'C7': "c'7", 'D7': "d'7",
         'E7': "e'7", 'F7': "f'7", 'G7': "g'7",
         'C8': "c'8",
         'A': "a'4", 'B': "b'4", 'C': "c'4", 'D': "d'4",
         'E': "e'4", 'F': "f'4", 'G': "g'4"}

comparators = {'=': equal, '/=': notEqual,
               '<': greater, '>': lower,
               '<=': greaterEqual, '>=': lowerEqual}


class TreeVisitor(jsbachVisitor):
    def __init__(self, name):
        self.procedures = {}
        self.assigs = [{}]
        self.scores = []
        self.name = name

    def start(self, procedure):
        if procedure in self.procedures:
            execute = self.procedures[procedure]
            self.visit(execute[0])
        else:
            raise Exception(procedure + " does not exist")

    def startWithArguments(self, procedure, arguments):
        if procedure in self.procedures:
            proc = self.procedures[procedure]
            parameters = proc[1]
            if len(parameters) == len(arguments):
                for i in range(len(parameters)):
                    if arguments[i].isnumeric():
                        self.assigs[-1][parameters[i]] = int(arguments[i])
                    elif arguments[i] in notes:
                        self.assigs[-1][parameters[i]] = arguments[i]
                    else:
                        raise Exception("The enter point only accepts notes " +
                                        "or integers")
                self.visit(proc[0])
            else:
                raise Exception(procedure + " do not have the same number of" +
                                            " elements")
        else:
            raise Exception(procedure + " does not exist")

    def visitExpr(self, ctx):
        childs = list(ctx.getChildren())
        if len(childs) == 1:
            value = childs[0].getText()
            if value.isnumeric():
                return int(value)
            if value in notes:
                l = list(notes)
                l = l[-7:]
                if value in l:
                    value = value + "4"
                return value
            elif '[' in value or '#' in value:
                return self.visit(childs[0])
            elif value in self.assigs[-1]:
                return self.assigs[-1][value]
            else:
                raise Exception(value + " not defined")
        else:
            if ('(' == childs[0].getText()):
                return self.visit(childs[1])
            else:
                num1 = self.visit(childs[0])
                op = childs[1].getText()
                num2 = self.visit(childs[2])

                l = list(notes)
                l = l[:-7]
                if num1 in notes:
                    index = l.index(num1)
                    result = operators[op](index, num2)
                    if result > 0 and result < len(l):
                        return l[result]
                    else:
                        raise Exception(str(num1) + str(op) + str(num2) +
                                        " the result is not a note")
                elif num2 in notes:
                    index = l.index(num2)
                    result = operators[op](num1, index)
                    if result > 0 and result < len(l):
                        return l[result]
                    else:
                        raise Exception(str(num1) + str(op) + str(num2) +
                                        " the result is not a note")

                if op in operators:
                    return operators[op](num1, num2)
                else:
                    raise Exception(op + " is not an operator")

    def visitAssig(self, ctx):
        childs = list(ctx.getChildren())
        elem = childs[2].getText()
        if elem in notes:
            l = list(notes)
            l = l[-7:]
            if elem in l:
                elem = elem + "4"
            self.assigs[-1][childs[0].getText()] = elem
        elif elem.isnumeric():
            self.assigs[-1][childs[0].getText()] = int(elem)
        else:
            elem2 = self.visit(childs[2])
            if elem2 is not None:
                if isinstance(elem2, list):
                    self.assigs[-1][childs[0].getText()] = elem2.copy()
                else:
                    self.assigs[-1][childs[0].getText()] = elem2
            else:
                raise Exception(elem + " cannot be assigned is not a note," +
                                       " a variable or an integer")

    def visitRead(self, ctx):
        childs = list(ctx.getChildren())
        value = input()
        if value.isnumeric():
            self.assigs[-1][childs[1].getText()] = int(value)
        elif value in notes:
            self.assigs[-1][childs[1].getText()] = value
        else:
            raise Exception(value + " is not an integer or a note")

    def visitWrite(self, ctx):
        childs = list(ctx.getChildren())
        elements = self.visit(childs[1])
        for elem in elements:
            if isinstance(elem, list):
                print('{', end='')
                for i in range(len(elem)):
                    if i == len(elem) - 1:
                        print(elem[i], end='}')
                    else:
                        print(elem[i], end=', ')
            else:
                print(elem, end=' ')
        print('\r')

    def visitWritable(self, ctx):
        childs = list(ctx.getChildren())
        result = []
        for child in childs:
            content = child.getText()
            if content.startswith('"') and content.endswith('"'):
                result.append(content[1:-1])
            elif content in notes:
                result.append(content)
            else:
                res = self.visit(child)
                if (res is not None):
                    result.append(res)
                else:
                    raise Exception(content + " is not a valid parameter")

        return result

    def visitPlay(self, ctx):
        childs = list(ctx.getChildren())
        elem = childs[1].getText()
        if len(childs) > 2:
            value = self.visit(childs[2])
            for e in value:
                if e in notes:
                    self.scores.append(notes[e])
                else:
                    raise Exception(e + " is not a note")
        elif elem in notes:
            self.scores.append(notes[elem])
        elif '[' in elem:
            value = self.visit(childs[1])
            if value in notes:
                self.scores.append(notes[value])
        elif elem in self.assigs[-1]:
            elem2 = self.assigs[-1][elem]
            if isinstance(elem2, list):
                for e in elem2:
                    if e in notes:
                        self.scores.append(notes[e])
                    else:
                        raise Exception(e + " is not a note")
            elif elem2 in notes:
                self.scores.append(notes[elem2])
            else:
                raise Exception(elem2 + " does not contains a note")
        else:
            raise Exception(elem + " is not a note or a variable")

        writeScore(self.scores, self.name)

    def visitCreateList(self, ctx):
        childs = list(ctx.getChildren())
        name = childs[0].getText()
        elements = self.visit(childs[3])
        self.assigs[-1][name] = elements

    def visitListParams(self, ctx):
        childs = list(ctx.getChildren())
        res = []
        for child in childs:
            elem = child.getText()
            if elem in notes:
                res.append(elem)
            else:
                elem2 = self.visit(child)
                if elem2 is None:
                    raise Exception(elem + " is not a valid element")
                else:
                    res.append(elem2)

        return res

    def visitAccesList(self, ctx):
        childs = list(ctx.getChildren())
        name = childs[0].getText()
        if (name not in self.assigs[-1]):
            raise Exception(name + " was not defined")
        index = self.visit(childs[2])
        if (len(self.assigs[-1][name]) < index or index == 0):
            raise Exception(str(index) + " in " + name + " is out of bounds")

        return self.assigs[-1][name][index-1]

    def visitDeleteList(self, ctx):
        childs = list(ctx.getChildren())
        name = childs[1].getText()
        if (name not in self.assigs[-1]):
            raise Exception(name + " was not defined")
        index = self.visit(childs[3])
        if (len(self.assigs[-1][name]) < index or index == 0):
            raise Exception(str(index) + " in " + name + " is out of bounds")
        self.assigs[-1][name].pop(index-1)

    def visitAddList(self, ctx):
        childs = list(ctx.getChildren())
        name = childs[0].getText()
        if (name not in self.assigs[-1]):
            raise Exception(name + " was not defined")
        elem = self.visit(childs[2])
        self.assigs[-1][name].append(elem)

    def visitSizeList(self, ctx):
        childs = list(ctx.getChildren())
        name = childs[1].getText()
        if (name not in self.assigs[-1]):
            raise Exception(name + " was not defined")

        l = self.assigs[-1][name]
        if isinstance(l, list):
            return len(l)
        else:
            raise Exception(name + " is not a list")

    def visitCondition(self, ctx):
        childs = list(ctx.getChildren())
        op = childs[1].getText()
        op1 = self.visit(childs[0])
        op2 = self.visit(childs[2])

        if op1 in notes:
            op1 = list(notes).index(op1)
        if op2 in notes:
            op2 = list(notes).index(op2)

        return comparators[op](op1, op2)

    def visitIfcondition(self, ctx):
        childs = list(ctx.getChildren())
        condition = self.visit(childs[1])
        if condition:
            self.visit(childs[3])
        elif len(childs) == 6:
            self.visit(childs[5])

    def visitElsecondition(self, ctx):
        childs = list(ctx.getChildren())
        self.visit(childs[2])

    def visitWhile(self, ctx):
        childs = list(ctx.getChildren())
        while self.visit(childs[1]):
            self.visit(childs[3])

    def visitCreateProcedure(self, ctx):
        childs = list(ctx.getChildren())
        procName = childs[0].getText()

        if procName in self.procedures:
            raise Exception(procName + " it already exists")

        params = self.visit(childs[1])
        self.procedures[procName] = [childs[3], params]

    def visitParameters(self, ctx):
        childs = list(ctx.getChildren())
        params = []
        for param in childs:
            variable = param.getText()
            params.append(variable)

        return params

    def visitAccesProcedure(self, ctx):
        childs = list(ctx.getChildren())
        procName = childs[0].getText()
        if procName not in self.procedures:
            raise Exception(procName + " does not exists")

        params = self.visit(childs[1])
        proc = self.procedures[procName]
        code = proc[0]
        parameters = proc[1]

        self.assigs.append({})

        if len(params) != len(parameters):
            raise Exception(procName + " do not have the same number of " +
                                       "elements")

        for i in range(0, len(parameters)):
            self.assigs[-1][parameters[i]] = params[i]

        self.visit(code)
        self.assigs.pop()

    def visitParameters2(self, ctx):
        childs = list(ctx.getChildren())
        params = []
        for param in childs:
            variable = param.getText()
            if variable in notes:
                params.append(variable)
            else:
                params.append(self.visit(param))

        return params
