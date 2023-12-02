txt = """
        ++++++++[>++++++++<-]>+++.
        <++++++[>++++++<-]>++.
        <++[>----<-]>.
        <++[>+++++++<-]>.
    """

def brainFuck_interpreter(input):
    head_position = 0
    tape = [0]*10

    _index = 0

    while _index != len(input):
        cmd = input[_index]
        _index+=1

        if cmd in (" ","\t","\n","\r"):
            continue

        elif cmd == "+":
            tape[head_position]+=1

        elif cmd == "-":
            tape[head_position]-=1

        elif cmd == ".":
            print(chr(tape[head_position]), end ="")

        elif cmd == ">":
            head_position+=1

        elif cmd == "<":
            head_position-=1

        elif cmd =="[":
            if tape[head_position] == 0:
                _last_index = _index
                while _last_index != len(input):
                    if input[_last_index] == "]":
                        _index = _last_index+1
                        break
                    _last_index+=1
               
        elif cmd == "]":
            if tape[head_position] !=0:
                _last_index = _index
                while _last_index > 0:
                    if input[_last_index] == "[":
                        _index = _last_index+1
                        break
                    _last_index-=1
    
brainFuck_interpreter(txt)


